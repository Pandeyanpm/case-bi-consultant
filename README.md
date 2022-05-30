# Case: Business Intelligence Consultant
The case resolves around a hypothetical online store. They're selling merchandise
in different product categories to customers within the United States. Attached to the document you will find CSV
which cover information about orders, returns and area managers of the e-commerce company. Please use this data
to prepare the following tasks.

### Tasks

0. You only have read access to this repository, so please fork it to your github account and upload the solution files to share it with us.

1. Attached to this document you will find three CSV files:
    1. Orders.csv
    2. People.csv
    3. Returns.csv

   Please load these files into a database of your choice. This database needs to be accessible to the analytical tool you select for the subsequent tasks. Examples for potential databases include SQLite (stored locally), a Postgres database (server running on localhost or a location of your
choice) and BigQuery. These are just examples, please feel free to make your own choice. Just
don't work simply based on the CSV files. You can choose whether to import the data into your
database via a data import wizard (e.g. provided as part of the SQL IDE Dbeaver) or by writing a
Python script.

2. Choose a tool that you would like to use for analysis of the previously imported data. Tableau
Desktop is preferred; however, any other BI tool is also fine (e.g., Metabase, PowerBI)

3. Using either queries on your database or the analytical tool of your choice, please prepare
answers to the following questions:
    1. We're interested in customers who are spending quite a lot with individual orders. Can you
tell us how many customers there are which have placed at least one order in which their
total sales amount exceeded 2,000$?
    2. We're a little bit worried about the increasing number of returns. Can you look into the data
on return and see whether you can find any valuable information on these returns? e.g. in
the context of product category, time, etc.
    3. Imagine you - in the role of a BI analyst - had a meeting with one of the area managers
coming up next week (which of them you'd like to meet is up to your choice). Can you dive
into the data and come up with some valuable insights on the business in the respective
manager's area which you think would provide value for them in the future? Note: Please
definitely use the analytical tool rather than just database queries for this task. All four area
managers are not too data-savvy and prefer visual analyses over plain numbers and
text.
