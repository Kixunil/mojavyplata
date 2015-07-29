from django.conf.urls import patterns, include, url
from django.contrib import admin
from home import HelloPDFView,views_home

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'payrollswift.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', views_home.home_page),
    url(r'^xml_handle',views_home.xml_handler)
)
