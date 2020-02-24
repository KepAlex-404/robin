const { AuthenticationError, UserInputError } = require('apollo-server-koa');

module.exports = {
  Query: {
    example: async (parent, { id }, { models: { exampleModel }, me }) => {
      if (!me) {
        throw new AuthenticationError('You are not authenticated');
      }
      const example = await exampleModel
        .findById({ _id: id });
      return example;
    },
  },

  Mutation: {
    createExample: async (
      parent,
      { exampleData },
      { models: { exampleModel } }
    ) => {
      let found = await exampleModel.findOne({ exampleData });
      if (found) {
        throw new UserInputError('Example creation failed', {
          errors: {
            exampleData: 'Such data is uniq and already in database',
          },
        });
      }
      found = await exampleModel.create({
        exampleData
      });
      return found;
    },
  }
};
