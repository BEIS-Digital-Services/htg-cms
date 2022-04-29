const { sanitizeEntity } = require('strapi-utils');

/**
 * Create default fetch params
 * @param {*} params
 * @returns
 */
 const getFetchParamsPreview = (params = {}) => {
  return {
    _publicationState: 'preview',
    ...params,
    _limit: {
      defaultLimit:10,
      maxLimit: 10,
    },
  };
};

module.exports = {
  /**
   * Retrieve a record.
   *
   * @return {Object}
   */

  async findOne(ctx) {
    const { pagename } = ctx.params;

    const entity = await strapi.services['custom-pages'].findOne({ pagename });
    
    await addFilteredArticles(entity);

    return sanitizeEntity(entity, { model: strapi.models['custom-pages'] });

  },

  async findOnePreview(ctx) {
    const { id } = ctx.params;

    const entity = await strapi.entityService.findOne(
      { params: getFetchParamsPreview({ id }) },
      { model: 'custom-pages' }
    );

    await addFilteredArticles(entity);

    return sanitizeEntity(entity, { model: strapi.models['custom-pages'] });

  }  
};
async function addFilteredArticles(entity) {
  if (entity.components) {
    const articles = await strapi.services['search-articles'].find();
    let filteredArticles = [];
  
    for (var i = 0; i < entity.components.length; i++) {
      if (entity.components[i].type === 'articleBlock') {
        let articleBlock = entity.components[i].search_articles;
        for (let article of articleBlock) {
          filteredArticles.push(articles.find(x => x.id === article.id));
        }
        entity.components[i].search_articles = filteredArticles;
      }
    }
  }
}

