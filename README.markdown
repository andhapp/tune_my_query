tune_my_query
============

About
-----
**tune_my_query** is an extension of the gem **me_gusta** written by **John Pignata**

It is a simple way to switch between standard SQL and extended SQL syntax depending on the adapter. For example: PostgreSql has an ILIKE extension which is not found in other databases like mysql. This gem ensures the query is adapted based on the current database. 


Inspiration
-----------
Gemcutter uses PostgreSql in production and uses ILIKE in one of the queries. For anyone, hacking on their local machine will have to change it to LIKE for it to work. Also, when it comes to accepting patches this would again pose a minor issue. Hence, this gem.


Usage
-----

It is simple to use. Just install it like:

    sudo gem install tune_my_query

And do in the model class where you have used a database specific SQL, like this:

    tune_my_query :like

Here like signifies the extension to usual SQL LIKE.


Does it only work with LIKE? What a futile effort
-------------------------------------------------
Yes, at the moment it only does that. But, you can fork the code and add your own commands in the commands directory inside lib. Every new command that you add should have a name ending with Command. For example: AwesomeCommand. Add a singleton execute method to it and send me a patch, I will add it in. Please do add specs. 


Specs
-----
In order to run the specs you should have mysql and postgresql installed. [Here's](http://developer.apple.com/internet/opensource/postgres.html) how to install PostgreSql on a Mac. And, just do:

    sudo gem install postgres-pr

to install postgreSql adapter. 


Bugs
----

Please report the issues through gitHub's issues.


Authors
-------
* John Pignata
* Anuj Dutta - [andHapp.com](http://www.andhapp.com/blog)