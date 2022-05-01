module.exports = ({ env }) => ({    
    navigation: {
        relatedContentTypes: [
            'application::custom-pages.custom-pages'
        ],
        allowedLevels: 3,
        contentTypesNameFields: {
            'application::custom-pages.custom-pages': ['pagename', 'id'],
            'custom_pages': ['pagename', 'id']
        }
    }
});