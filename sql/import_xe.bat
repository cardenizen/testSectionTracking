rem sqlplus sys/admin@localhost/XE as sysdba @tst_drop_security_xe.sql
sqlplus sys/admin@localhost/XE as sysdba @tst_create_user.sql
imp 'tst/tst@localhost/XE as sysdba' tables=(AUTHORITY, AUTHORITY_PERSON, PERSON, REQUESTMAP) grants=N fromuser=mnr touser=tst file=tst_security.dmp
rem sqlplus sys/admin@localhost/XE as sysdba @tst_drop_data_xe.sql
imp 'tst/tst@localhost/XE as sysdba' tables=(COUNTIES, TEST_SECTION, APP_CONFIG) grants=N fromuser=mnr touser=tst FILE=tst_data.dmp
sqlplus sys/admin@localhost/XE as sysdba @tst_grants.sql
del genned_sequences.sql



																				 