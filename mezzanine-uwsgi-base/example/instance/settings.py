
from .defaults import *

# A boolean that turns on/off debug mode. When set to ``True``, stack traces
# are displayed for error pages. Should always be set to ``False`` in
# production. Best set to ``True`` in local_settings.py
DEBUG = True
TEMPLATE_DEBUG = True
NOCACHE = True

ALLOWED_HOSTS = ['*']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
         'NAME': 'example.db',
    }
}


##########
# CACHES #
##########
if not NOCACHE:
    MIDDLEWARE_CLASSES = (
        'johnny.middleware.LocalStoreClearMiddleware',
        'johnny.middleware.QueryCacheMiddleware',
    ) + MIDDLEWARE_CLASSES

    TEMPLATE_LOADERS = (
        ('django_mobile.loader.CachedLoader', TEMPLATE_LOADERS),
    )

    CACHES = {
        'default': {
            'BACKEND': 'johnny.backends.memcached.MemcachedCache',
            'LOCATION': ['127.0.0.1:11211',],
            'KEY_PREFIX': 'a',
            'VERSION': '1',
            'TIMEOUT':0,
            'JOHNNY_CACHE': True,
            'TIMEOUT':3600,
        },
    }

if DEBUG:

    INSTALLED_APPS += ('debug_toolbar',)
    MIDDLEWARE_CLASSES += ('debug_toolbar.middleware.DebugToolbarMiddleware',)
    INTERNAL_IPS = ('127.0.0.1', 'dev1.localhost', 'dev2.localhost')
    #DEBUG_TOOLBAR_CONFIG = {"INTERCEPT_REDIRECTS": False}
    #DEBUG_TOOLBAR_PATCH_SETTINGS = False




####################
# DYNAMIC SETTINGS #
####################

# set_dynamic_settings() will rewrite globals based on what has been
# defined so far, in order to provide some better defaults where
# applicable. We also allow this settings module to be imported
# without Mezzanine installed, as the case may be when using the
# fabfile, where setting the dynamic settings below isn't strictly
# required.
try:
    from mezzanine.utils.conf import set_dynamic_settings
except ImportError:
    pass
else:
    set_dynamic_settings(globals())

