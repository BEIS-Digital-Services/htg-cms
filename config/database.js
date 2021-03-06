module.exports = () => ({
  defaultConnection: 'default',
  connections: {
    default: {
      connector: 'bookshelf',
      settings: {
        client: '{{DATABASE_CLIENT}}',
        host: '{{DATABASE_HOST}}',
        port: {{DATABASE_PORT}},
        database: '{{DATABASE_NAME}}',
        username: '{{DATABASE_USERNAME}}',
        password: '{{DATABASE_PASSWORD}}',
        schema: 'public',
        ssl: false,
      },
      options: {},
    },
  },
});
