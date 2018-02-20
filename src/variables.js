class Variable {
  constructor({label, question, valueLabels}) {
    this.label = label;
    this.question = question;
    this.valueLabels = valueLabels;
  }
}

export default {
  MaritalStatus: new Variable({
    label: 'MaritalStatus',
    question: 'Are you currently ....',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No answer',
      1: 'Married',
      2: 'Living together as married',
      3: 'Divorced',
      4: 'Separated',
      5: 'Widowed',
      6: 'Single/Never married',
    },
  }),
  Children: new Variable({
    label: 'Children',
    question: 'Have you had any children? If yes, how many?',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No answer',
      1: '1child',
      2: '2child',
      3: '3child',
      4: '4child',
      5: '5child',
      6: '6child',
    },
  }),
  LifeMeaning: new Variable({
    label: 'LifeMeaning',
    question: 'How often, if at all, do you think about the meaning and purpose of life?',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No answer',
      1: 'Often',
      2: 'Sometimes',
      3: 'Rarely',
      4: 'Never',
    },
  }),
  ServiceAttend: new Variable({
    label: 'ServiceAttend',
    question: 'Apart from weddings, funerals and christenings, about how often do you attend religious services these days?',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No anser',
      1: 'More than once a week',
      2: 'Once a week',
      3: 'Once a month',
      4: 'Only on special holy days',
      5: 'Once a year',
      6: 'Less often',
      7: 'Never or practically never',
    },
  }),
  ReligiousPerson: new Variable({
    label: 'ReligiousPerson',
    question: 'Independently of whether you go to church or not, would you say you are…',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No answer',
      1: 'A religious person',
      2: 'Not a religious person',
      3: 'A convinced atheist',
    },
  }),
  JustifyHomosexuality: new Variable({
    label: 'JustifyHomosexuality',
    question: '...whether you think it can always be justified, never be justified, or something in between...',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No answer',
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
  }),
  JustifyAbortion: new Variable({
    label: 'JustifyAbortion',
    question: '...whether you think it can always be justified, never be justified, or something in between...',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No answer',
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
  }),
  JustifyDivorce: new Variable({
    label: 'JustifyDivorce',
    question: '...whether you think it can always be justified, never be justified, or something in between...',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No answer',
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
  }),
  ReligiousDenom: new Variable({
    label: 'ReligiousDenom',
    question: 'Do you belong to a religious denomination? In case you do, answer which one.',
    valueLabels: {
      ... ???
    },
  })
  PoliticalScale: new Variable({
    label: 'PoliticalScale',
    question: 'In political matters, people talk of "the left" and "the right." How would you place your views on this scale, generally speaking?',
    valueLabels: {
      -4: 'Not asked',
      -2: 'No answer',
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
  }),
};
