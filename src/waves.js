import wv1 from '@/r/wv1.csv';
import wv2 from '@/r/wv2.csv';
import wv3 from '@/r/wv3.csv';
import wv4 from '@/r/wv4.csv';
import wv5 from '@/r/wv5.csv';
import wv6 from '@/r/wv6.csv';
import { csvParse } from 'd3';
import variables, { TYPES as VARIABLE_TYPES } from './variables';

class Waves {
  /**
   * @param  {object} data csv data ran through d3's csvParse function
   */
  constructor() {
    this.waves = [wv1, wv2, wv3, wv4, wv5, wv6].map(wave => Waves.parseWave(csvParse(wave)));

    console.dir(this.waves[0]);
    console.dir(this.medianMean(0));
  }

  static parseWave(wave) {
    const data = {};

    wave.forEach((row) => {
      const { country, x } = row;

      if (data[country] === undefined) data[country] = {};

      Object.keys(variables)
        .filter(variable => variables[variable].inBounds(x))
        .forEach((variable) => {
          if (data[country][variable] === undefined) data[country][variable] = {};
          const value = row[variable] === 'NA' ? 0 : parseInt(row[variable], 10);
          data[country][variable][x] = value;
        });
    });

    return data;
  }

  /**
   * @param  {Object} variable e.g.: {1: 3214, 2: 12, 3: 534}
   * @return number
   */
  static median(variable) {
    const totalCount = Object.keys(variable).reduce((acc, curr) => acc + variable[curr], 0);
    const target = totalCount / 2;
    let sum = 0;
    for (let i = 1; i <= Object.keys(variable).length; i += 1) {
      sum += variable[i];
      if (sum > target) {
        return i;
      }
    }
    return 0;
  }

  /**
   * @param  {Object} variable e.g.: {1: 3214, 2: 12, 3: 534}
   * @return number
   */
  static mean(variable) {
    const totalCount = Object.keys(variable).reduce((acc, curr) => acc + variable[curr], 0);
    let sum = 0;
    Object.keys(variable).forEach((i) => {
      sum += variable[i] * i;
    });
    return sum / totalCount;
  }

  medianMean(waveIndex) {
    const wave = this.waves[waveIndex];
    const data = [];

    Object.keys(wave).forEach((country) => {
      const row = wave[country];
      const newRow = { country };
      Object.keys(row).forEach((label) => {
        const variable = row[label];
        if (variables[label].type === VARIABLE_TYPES.ordinal) {
          newRow[label] = Waves.median(variable);
        } else if (variables[label].type === VARIABLE_TYPES.interval) {
          newRow[label] = Waves.mean(variable);
        }
      });

      data.push(newRow);
    });

    return data;
  }

/*
  byCountries() {
  }

  byWave() {
  }
*/
}

export default Waves;
