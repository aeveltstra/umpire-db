# Umpire-db
A MySql database model for the Unidentified and Missing Marginalized People

This database is meant to make it easy to compare the profiles of missing people against those of unidentified people, helping researchers to name and locate people. 

The organizations using this database model seek to aid individuals who are part of marginalized communities. They generally are left out, ignored, and maltreated by law enforcement. Thus, to protect sensitive data about the people in the database, specific care is taken to limit who and what can be seen by law enforcement as well as the public. 

The intent is to make it possible for anyone to enter cases, but only a select few can review case content.

This database model is designed for use with MySQL, using the InnoDB storage engine. This should suffice for initial needs and activity expectations. It is expected an application developer will use a common middleware web language like php or python to connect a web application to the database.

Note that this repository does not contain information about missing and deceased people. It merely contains the DDL instructions to recreate the database model, and the initial data setup to allow for populating profiles.
