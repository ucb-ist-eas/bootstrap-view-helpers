# bootstrap-view-helpers

This gem provides helper methods for various Bootstrap components.

Includes support for:

  * navigation
    * nav bar
    * nav list
  * buttons
    * `<button>`
    * `<a>` styled as button
  * button groups
  * button toolbars
  * labels and badges
  * dropdowns
    * nav dropdowns
    * button dropdowns
    * split-button dropdowns
  * accordion
  * form helpers
    * submit_tag_button 
  
## Note

This is a new gem undergoing a lot of change.  There is a chance that some backwards
compatibility will be broken until things settle down.  

## Installation

Add it to your Gemfile:

```ruby
gem "bootstrap-view-helpers"
```

Run bundler:

```sh
bundle install
```

## API Documentation

Complete [API documentation](http://rubydoc.info/gems/bootstrap-view-helpers/frames/file/README.md) at [RubyGems.org](https://rubygems.org/).

## Examples

### Navigation

#### Navigation Bar
```
<%= nav_bar do %>      

  <%= brand('Span Brand')%>
  <%= brand('Link Brand', url: '#')%>

  <%= nav_bar_links do %>

    <%= nav_bar_link('Active', '#', active: true) %>
    <%= nav_bar_link('Link1', '/link1') %>

    <%= nav_bar_divider %>

    <%= nav_dropdown('Foo') do %>
      <%= dropdown_item('One', 'foo')%>
    <% end %>

     <% end %>
   <% end %>
```

#### Navigation List (sidebar)
```erb
<%= nav_list(id: 'my') do %>
  <%= nav_list_header('Buttons & Labels') %>
  <%= dropdown_item('Buttons', 'butons')%>
  <%= dropdown_item('Labels', 'butons')%>
<% end %>
```

### Buttons

```ruby
# button
button('Default')

# add url option to make <a> styled as button
button('Home', url: '/')

# a button styled as a link
button('Home', :link)

# give it a type; see BUTTON_TYPES
button('Info', :info)

# give it a size (see BUTTON_SIZES)
button('Small', :small)

# size, type, additional class and additional html attributes
button('Warning', :warning, :large, id: 'warn-id', class: 'more-class', my_key: 'my_value')
```

### Button Groups

```erb
<%= button_group do %>
  <%= button("Left", url: "/left") %>
  <%= button("Right", id: 'right') %>
<% end %>
```

### Button Toolbars

```erb
<%= button_toolbar do %>
  <%= button('Single Button', url: '/single') %>
  <%= button_group do %>
    <%= button('Group Button 1') %>
    <%= button('Group Button 2') %>
  <% end %>
  <%= button('Another Single') %>
<% end %>
```
### Labels and Badges

http://twitter.github.io/bootstrap/components.html#labels-badges

#### Labels (Stamps)

Because `label` is a Rails helper method we use `stamp` -- because Elle thinks it looks like a stamp.

Supports the Bootstrap label types:
  * default
  * success
  * warning
  * important
  * info
  * inverse
  
```erb
<%= stamp('Default') %>
<%= stamp('Info', :info) %>
<%= stamp('Warning', :warning, id: 'warn-id', class: 'more-class', my_key: 'my_value') %>
```

#### Badges
Supports the Bootstrap badge types: 
  * default
  * success
  * warning
  * important
  * info
  * inverse
  
```erb
<%= badge('Default') %>
<%= badge('Info', :info) %>
<%= badge('Warning', :warning, id: 'warn-id', class: 'more-class', my_key: 'my_value') %>
```


### Accordions

See: http://twitter.github.io/bootstrap/javascript.html#collapse

```erb
<%= accordion do %>

  <%= accordion_group('Section 1', open: true) do %>
    content for group 1
  <% end >

  <%= accordion_group('Section 1') do %>
    content for group 2
  <% end %>

<% end %>
```

### Form Helpers

#### submit_tag_button

Returns <input> similar to +#submit_tag()+ but:
  * styled like a Bootstrap button, type `:primary`
  * has `:disable_with` set to "Processing ..."
  
```ruby
submit_button_tag   # => <input class="btn btn-primary" data-disable-with="Processing ..." name="commit" type="submit" value="Save changes" />
submit_button_tag('Save')
submit_button_tag('Delete', :danger)
submit_button_tag('Big', :large)
submit_button_tag('With Options', :small, :info, id: 'my-id')
```


