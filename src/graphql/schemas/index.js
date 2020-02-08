const exampleSchema = require('./exampleSchema');
const { gql } = require('apollo-server-koa');

const linkSchema = gql`
  type Query {
    _: Boolean
  }
  type Mutation {
    _: Boolean
  }
`;

module.exports = [linkSchema, exampleSchema];
