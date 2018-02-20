<template>
  <div id="app">
    <h1>Hello world!</h1>
  </div>
</template>

<script>
import { csvParse } from 'd3';
import data from '@/r/wv1.csv';

export default {
  name: 'app',
  created() {
    const cool = csvParse(data);

    console.dir(cool);
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  }
}
</script>

<style lang="scss">
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
