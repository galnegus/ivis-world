<template>
  <div id="app" ref="app">
  </div>
</template>

<script>
import 'parcoord-es/dist/parcoords.css';
import { brushSelection, select, selectAll, extent, scaleLinear, scalePoint, range, axisLeft, min, brushY, tsvFormat, event as d3_event } from 'd3';
import Waves from './waves';
import ParCoords from 'parcoord-es';
import variables from './variables';
import renderQueue from './render-queue';

export default {
  name: 'app',
  mounted() {
    const { app } = this.$refs;
    const waves = new Waves();

    const data = waves.medianMean(0);

    this.margin = {
      top: 66, right: 110, bottom: 20, left: 188,
    };
    this.width = app.clientWidth - this.margin.left - this.margin.right;
    this.height = 340 - this.margin.top - this.margin.bottom;
    this.innerHeight = this.height - 2;

    const devicePixelRatio = window.devicePixelRatio || 1;

    this.pscale = scalePoint().range([0, this.innerHeight]);

    this.dimensions = [];
    Object.keys(variables).forEach((variable) => {
      this.dimensions.push(variables[variable].dimension());
    });

    this.xscale = scalePoint()
      .domain(range(this.dimensions.length)) // .domain(d3.range(this.dimensions.length))
      .range([0, this.width]);
    const yAxis = axisLeft();
    const container = select(app).append('div')
      .attr('class', 'parcoords')
      .style('width', `${this.width + this.margin.left + this.margin.right}px`)
      .style('height', `${this.height + this.margin.top + this.margin.bottom}px`);
    this.svg = container.append('svg')
      .attr('width', this.width + this.margin.left + this.margin.right)
      .attr('height', this.height + this.margin.top + this.margin.bottom)
      .append('g')
      .attr('transform', `translate(${this.margin.left},${this.margin.top})`);
    const canvas = container.append('canvas')
      .attr('width', this.width * devicePixelRatio)
      .attr('height', this.height * devicePixelRatio)
      .style('width', `${this.width}px`)
      .style('height', `${this.height}px`)
      .style('margin-top', `${this.margin.top}px`)
      .style('margin-left', `${this.margin.left}px`);
    this.ctx = canvas.node().getContext('2d');
    this.ctx.globalCompositeOperation = 'darken';
    this.ctx.globalAlpha = 0.15;
    this.ctx.lineWidth = 1.5;
    this.ctx.scale(devicePixelRatio, devicePixelRatio);
    // const output = select(app).append('pre');
    const axes = this.svg.selectAll('.axis')
      .data(this.dimensions)
      .enter().append('g')
      .attr('class', d => `axis ${d.key.replace(/ /g, '_')}`)
      .attr('transform', (d, i) => `translate(${this.xscale(i)})`);

    data.forEach((d) => {
      /*this.dimensions.forEach((p) => {
        d[p.key] = !d[p.key] ? null : p.type.coerce(d[p.key]);
      });*/
      // truncate long text strings to fit in data table
      Object.keys(d).forEach((key) => { // for (const key in d) {
        if (d[key] && d[key].length > 35) d[key] = d[key].slice(0, 36);
      });
    });
    // type/dimension default setting happens here
    this.dimensions.forEach((dim) => {
      if (!('domain' in dim)) {
        // detect domain using dimension type's extent function
        dim.domain = this.d3_functor(dim.type.extent)(data.map(d => d[dim.key]));
      }
      if (!('scale' in dim)) {
        // use type's default scale for dimension
        dim.scale = this.pscale.copy();
      }
      dim.scale.domain(dim.domain);
    });

    this.render = renderQueue(this.draw).rate(30);

    this.ctx.clearRect(0, 0, this.width, this.height);
    this.ctx.globalAlpha = min([1.15 / (data.length ** 0.3), 1]);
    this.render(data);
    axes.append('g')
      .each((d) => {
        const renderAxis = 'axis' in d
          ? d.axis.scale(d.scale) // custom axis
          : yAxis.scale(d.scale); // default axis
        select(this).call(renderAxis);
      })
      .append('text')
      .attr('class', 'title')
      .attr('text-anchor', 'start')
      .text(d => ('description' in d ? d.description : d.key));
    // Add and store a brush for each axis.
    axes.append('g')
      .attr('class', 'brush')
      .each((d) => {
        select(this).call(d.brush = brushY()
          .extent([[-10, 0], [10, this.height]])
          .on('start', this.brushstart)
          .on('brush', this.brush)
          .on('end', this.brush));
      })
      .selectAll('rect')
      .attr('x', -8)
      .attr('width', 16);
    // selectAll('.axis.pl_discmethod .tick text')
    //  .style('fill', color);
    // output.text(tsvFormat(data.slice(0, 24)));
  },
  data() {
    return {
      msg: 'Welcome to Your Vue.js App',
    };
  },
  methods: {
    draw(d) {
      // this.ctx.strokeStyle = color(d.pl_discmethod);
      this.ctx.beginPath();
      const coords = this.project(d);
      coords.forEach((p, i) => {
        // this tricky bit avoids rendering null values as 0
        if (p === null) {
          // this bit renders horizontal lines on the previous/next
          // dimensions, so that sandwiched null values are visible
          if (i > 0) {
            const prev = coords[i - 1];
            if (prev !== null) {
              this.ctx.moveTo(prev[0], prev[1]);
              this.ctx.lineTo(prev[0] + 6, prev[1]);
            }
          }
          if (i < coords.length - 1) {
            const next = coords[i + 1];
            if (next !== null) {
              this.ctx.moveTo(next[0] - 6, next[1]);
            }
          }
          return;
        }
        if (i === 0) {
          this.ctx.moveTo(p[0], p[1]);
          return;
        }
        this.ctx.lineTo(p[0], p[1]);
      });
      this.ctx.stroke();
    },
    project(d) {
      return this.dimensions.map((p, i) => {
        // check if data element has property and contains a value
        if (
          !(p.key in d) ||
          d[p.key] === null
        ) return null;
        return [this.xscale(i), this.pscale(d[p.key])]; // p.scale
      });
    },
    brushstart() {
      d3_event.sourceEvent.stopPropagation();
    },
    // Handles a brush event, toggling the display of foreground lines.
    brush() {
      this.render.invalidate();
      const actives = [];
      this.svg.selectAll('.axis .brush')
        .filter(d => brushSelection(this))
        .each((d) => {
          actives.push({
            dimension: d,
            extent: brushSelection(this),
          });
        });
      const selected = this.data.filter((d) => {
        if (actives.every((active) => {
          const dim = active.dimension;
          // test if point is within extents for each active brush
          return dim.type.within(d[dim.key], active.extent, dim);
        })) {
          return true;
        }
        return false;
      });
      // show ticks for active brush dimensions
      // and filter ticks to only those within brush extents
      /*
       svg.selectAll(".axis")
       .filter(function(d) {
       return actives.indexOf(d) > -1 ? true : false;
       })
       .classed("active", true)
       .each(function(dimension, i) {
       var extent = extents[i];
       d3.select(this)
       .selectAll(".tick text")
       .style("display", function(d) {
       var value = dimension.type.coerce(d);
       return dimension.type.within(value, extent, dimension) ? null : "none";
       });
       });
       // reset dimensions without active brushes
       svg.selectAll(".axis")
       .filter(function(d) {
       return actives.indexOf(d) > -1 ? false : true;
       })
       .classed("active", false)
       .selectAll(".tick text")
       .style("display", null);
       */
      this.ctx.clearRect(0, 0, this.width, this.height);
      this.ctx.globalAlpha = min([0.85 / (selected.length ** 0.3), 1]);
      this.render(selected);
      // output.text(d3.tsvFormat(selected.slice(0,24)));
    },
    d3_functor(v) {
      return typeof v === 'function' ? v : function functor() { return v; };
    },
  },
};
</script>

<style lang="scss">
html, body {
  margin: 0;
  padding: 0;
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
