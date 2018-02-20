<template>
  <div id="app" ref="app">
    <div id="example" ref="parcoords" class="parcoords" style="width:1500px;height:600px"></div>
  
    <div class="select">
      <select v-model="wave" @input="changeWave">
        <option value="0">Wave 1 (1981-1984)</option>
        <option value="1">Wave 2 (1990-1994)</option>
        <option value="2">Wave 3 (1995-1998)</option>
        <option value="3">Wave 4 (1999-2004)</option>
        <option value="4">Wave 5 (2005-2009)</option>
        <option value="5">Wave 6 (2010-2014)</option>
      </select>
      <div class="select__arrow"></div>
    </div>
    <div class="analysis">
      <h1>Analytic Trail 1: Religion and politics</h1>
      <p>We want to examine what kind of relationship exists between religion and politics in 2010-2014. To do this, we have a few variables of interest. <strong>ReligiousPerson</strong> describes how religious the median person of the country considers themself (lower means more religious). <strong>PoliticalScale</strong> is also of interest, where higher means more right-leaning, lower means left-leaning (from 1 to 10), similarly with <strong>JustifyHomosexuality</strong>, <strong>JustifyAbortion</strong> and <strong>JustifyDivorce</strong>. The hypothesis being that people who are more religious will be more right-leaning.</p>

      <img src="./assets/p1_1.png">

      <p>The first image shows as expected that right-leaning countries are more religious, going by the medians. They are as well more negatively disposed towards homosexuality, abortion and divorce.</p>

      <img src="./assets/p1_2.png">

      <p>On the other end of the spectrum, we interestingly see a greater occurences of countries with more religious people. They are also more tolerant towards homosexuality, abortion and divorce.</p>

      <h1>Analytic Trail 2: Meaning of life</h1>

      <p>The second question is about the meaning of life, how does it relate to religion. The variable <strong>LifeMeaning</strong></p>
    </div>
  </div>

</template>

<script>
import 'parcoord-es/dist/parcoords.css';
import { select } from 'd3';
import Waves from './waves';
import ParCoords from 'parcoord-es';
import variables from './variables';
import renderQueue from './render-queue';

export default {
  name: 'app',
  mounted() {
    this.app = this.$refs.app;
    this.$par = select(this.$refs.parcoords);
    this.waves = new Waves();

    const data = this.waves.medianMean(5);
    const dimensions = {};
    Object.keys(variables).forEach((variable) => {
      dimensions[variable] = variables[variable].dimension();
    });

    this.setWave(this.wave);
  },
  data() {
    return {
      wave: '5',
    };
  },
  methods: {
    changeWave(e) {
      this.setWave(e.target.value);
    },
    setWave(waveIndex) {
      this.$par.html('');
      //this.$app.remove();

      this.parcoords = ParCoords()('#example')
        .margin({ top: 20, bottom: 50, left: 100, right: 50})
        .data(this.waves.medianMean(waveIndex))
        //.dimensions(dimensions)
        //.autoscale()
        .alpha(0.4)
        .composite('darker')
        .shadows()
        .color((d) => {
          const r = Math.floor(((d.PoliticalScale - 1) / 9) * 255);
          const b = Math.floor(255 - (((d.PoliticalScale - 1) / 9) * 255));
          return `rgba(${r}, 0, ${b}, 0.9)`;
        })
        .width(app.clientWidth)
        .render()
        .createAxes()
        .brushMode('1D-axes')
        .reorderable();
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
  font-family: 'Rubik', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  //text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

h1, h2 {
  font-weight: 300;
}

p {
  line-height: 1.6;
}

strong {
  font-weight: 500;
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

.parcoords {

}

.select {
  position: relative;
  display: block;
  width: 400px;
  margin-bottom: 15px;
  margin-left: auto;
  margin-right: auto;
}

.select select {
  display: inline-block;
  width: 100%;
  padding: 10px 15px;
  cursor: pointer;
  color: #7b7b7b;
  border: 0;
  border-radius: 0;
  outline: 0;
  background: #e6e6e6;
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
}

.select select::-ms-expand {
  display: none;
}

.select select:hover,
.select select:focus {
  color: #000;
  background: #ccc;
}

.select select:disabled {
  pointer-events: none;
  opacity: .5;
}

.select__arrow {
  position: absolute;
  top: 16px;
  right: 15px;
  width: 0;
  height: 0;
  pointer-events: none;
  border-width: 8px 5px 0 5px;
  border-style: solid;
  border-color: #7b7b7b transparent transparent transparent;
}
.select select:hover ~ .select__arrow,
.select select:focus ~ .select__arrow {
  border-top-color: #000;
}

.select select:disabled ~ .select__arrow {
  border-top-color: #ccc;
}

.analysis {
  width: 50%;
  margin: 50px auto;

  h1 {
    text-align: center;
  }
}

img {
  text-align: center;
  max-width:100%;
  height: auto;
}
</style>
