const { sanitizeEntity } = require('strapi-utils');

module.exports = {
  /**
   * Retrieve a record.
   *
   * @return {Object}
   */

  async findOne(ctx) {
    const { pagename } = ctx.params;

    const entity = await strapi.services['diagnostic-tool'].findOne({ pagename });
    return sanitizeEntity(entity, { model: strapi.models['diagnostic-tool'] });
  },
};
