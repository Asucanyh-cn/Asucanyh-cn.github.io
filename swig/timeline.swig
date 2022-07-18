{% extends '_layout.swig' %}
{% import '_macro/post-collapse.swig' as post_template with context %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ __('title.timeline') }} | {{ title }}{% endblock %}

{% block class %}timeline{% endblock %}

{% block content %}

  {#####################}
  {### ARCHIVE BLOCK ###}
  {#####################}
  <div class="post-block">
    <div class="posts-collapse">

    {%- set current_year = '1970' %}
    <span itemprop="name"></span>
    {%- for post in page.posts %}

        {%- set year = date(post.date, 'YYYY') %}

        {%- if year !== current_year %}
            {%- set current_year = year %}
            <div class="collection-year">
            <span class="collection-header">{{ current_year }}</span>
            </div>
        {%- endif %}

        <article itemscope itemtype="http://schema.org/Article">
            <header class="post-header">

            <div class="post-meta">
                <time itemprop="dateCreated"
                    datetime="{{ moment(post.date).format() }}"
                    content="{{ date(post.date, config.date_format) }}">
                {{ date(post.date, 'MM-DD') }}
                </time>
            </div>

            <div class="post-title">
               <span itemprop="name">{{ post.content }}</span>
                
            </div>

            </header>
    </article>

    {%- endfor %}

    </div>
  </div>
  {#########################}
  {### END ARCHIVE BLOCK ###}
  {#########################}

  {% include '_partials/pagination.swig' %}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
