sqlplus mnru/@MRL2K3MRDB.ad.dot.state.mn.us:1521/mnrd.ad.dot.state.mn.us @tst_gen_sequences.sql
exp mnru/@MRL2K3MRDB.ad.dot.state.mn.us:1521/mnrd.ad.dot.state.mn.us tables=(MNR.COUNTIES, MNR.TEST_SECTION, MNR.APP_CONFIG) FILE=tst_data.dmp
exp mnru/@MRL2K3MRDB.ad.dot.state.mn.us:1521/mnrd.ad.dot.state.mn.us tables=(MNR.AUTHORITY, MNR.AUTHORITY_PERSON, MNR.PERSON, MNR.REQUESTMAP) FILE=tst_security.dmp





																				 