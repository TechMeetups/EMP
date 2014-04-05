EMP
===

Event Managment Platform

Use Datatables 
===============

1.Add to your gemfile

gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'

2.Install the bundle

bundle install

3.Add the required javascript in application.js

//= require dataTables/jquery.dataTables

4.Add the stylesheets to the application.css

*= require dataTables/jquery.dataTables

5.Add the jquery code in your ModelName.js.coffee 

jQuery ->
  $('#table_id').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true

6.Give table id in your jquery code   


  