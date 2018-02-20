import { scaleOrdinal } from 'd3';

export const TYPES = {
  ordinal: 'ordinal',
  interval: 'interval',
};

class Variable {
  constructor({
    label, question, valueLabels, min, max, type,
  }) {
    this.label = label;
    this.question = question;
    this.valueLabels = valueLabels;
    this.min = min;
    this.max = max;
    this.type = type;
  }

  inBounds(x) {
    return x >= this.min && x <= this.max;
  }

  dimension() {
    return {
      title: this.label,
      //key: this.label,
      //description: this.question,
      //type: Number,
      ticks: this.max,
      tickValues: Array.from(Array(this.max).keys()).map(i => i + 1),
      yscale: scaleOrdinal([this.min, this.max]),
    };
  }
}

export default {
  MaritalStatus: new Variable({
    label: 'MaritalStatus',
    question: 'Are you currently ....',
    valueLabels: {
      1: 'Married',
      2: 'Living together as married',
      3: 'Divorced',
      4: 'Separated',
      5: 'Widowed',
      6: 'Single/Never married',
      // 7: 'Divorced, separated or Widow',
      // 8: 'Living apart but steady relation (married, cohabitation)',
      // 10: 'Living apart while married/cohabitation',
    },
    min: 1,
    max: 6,
    type: TYPES.ordinal,
  }),
  Children: new Variable({
    label: 'Children',
    question: 'Have you had any children? If yes, how many?',
    valueLabels: {
      1: '1 child',
      2: '2 children',
      3: '3 children',
      4: '4 children',
      5: '5 children',
      6: '6 children',
      7: '7 children', // missing in wv1, wv2
      8: '8 children', // missing in wv1, wv2, wv4
    },
    min: 1,
    max: 8,
    type: TYPES.interval,
  }),
  LifeMeaning: new Variable({
    label: 'LifeMeaning',
    question: 'How often, if at all, do you think about the meaning and purpose of life?',
    valueLabels: {
      1: 'Often',
      2: 'Sometimes',
      3: 'Rarely',
      4: 'Never',
    },
    min: 1,
    max: 4,
    type: TYPES.ordinal,
  }),
  ServiceAttend: new Variable({
    label: 'ServiceAttend',
    question: 'Apart from weddings, funerals and christenings, about how often do you attend religious services these days?',
    valueLabels: {
      1: 'More than once a week',
      2: 'Once a week',
      3: 'Once a month',
      4: 'Only on special holy days',
      5: 'Once a year',
      6: 'Less often',
      7: 'Never or practically never',
      8: 'Never', // only wv2
    },
    min: 1,
    max: 8,
    type: TYPES.ordinal,
  }),
  ReligiousPerson: new Variable({
    label: 'ReligiousPerson',
    question: 'Independently of whether you go to church or not, would you say you are…',
    valueLabels: {
      1: 'A religious person',
      2: 'Not a religious person',
      3: 'A convinced atheist',
      4: 'Other answer', // only wv3 and wv5
    },
    min: 1,
    max: 3,
    type: TYPES.ordinal,
  }),
  JustifyHomosexuality: new Variable({
    label: 'JustifyHomosexuality',
    question: '...whether you think it can always be justified, never be justified, or something in between...',
    valueLabels: {
      1: 'Never justifiable',
      2: '2',
      3: '3',
      4: '4',
      5: '5',
      6: '6',
      7: '7',
      8: '8',
      9: '9',
      10: 'Always justifiable',
    },
    min: 1,
    max: 10,
    type: TYPES.interval,
  }),
  JustifyAbortion: new Variable({
    label: 'JustifyAbortion',
    question: '...whether you think it can always be justified, never be justified, or something in between...',
    valueLabels: {
      1: 'Never justifiable',
      2: '2',
      3: '3',
      4: '4',
      5: '5',
      6: '6',
      7: '7',
      8: '8',
      9: '9',
      10: 'Always justifiable',
    },
    min: 1,
    max: 10,
    type: TYPES.interval,
  }),
  JustifyDivorce: new Variable({
    label: 'JustifyDivorce',
    question: '...whether you think it can always be justified, never be justified, or something in between...',
    valueLabels: {
      1: 'Never justifiable',
      2: '2',
      3: '3',
      4: '4',
      5: '5',
      6: '6',
      7: '7',
      8: '8',
      9: '9',
      10: 'Always justifiable',
    },
    min: 1,
    max: 10,
    type: TYPES.interval,
  }),
  PoliticalScale: new Variable({
    label: 'PoliticalScale',
    question: 'In political matters, people talk of "the left" and "the right." How would you place your views on this scale, generally speaking?',
    valueLabels: {
      1: 'Left',
      2: '2',
      3: '3',
      4: '4',
      5: '5',
      6: '6',
      7: '7',
      8: '8',
      9: '9',
      10: 'Right',
    },
    min: 1,
    max: 10,
    type: TYPES.interval,
  }),
};
