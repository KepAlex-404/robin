const { gql } = require('apollo-server-koa');

module.exports = gql`
  type Example {
    exampleData: String!
  }

  extend type Query {
    example(id: ID!): Example!
  }

  extend type Mutation {
    create(exampleData: String!): Example!
  }
`;
