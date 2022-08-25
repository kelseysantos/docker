<?php
// LDAP variables
$ldapuri = "ldap://ldap.example.com:389";  // your ldap-uri
// Connecting to LDAP
$ldapconn = ldap_connect($ldapuri)
          or die("That LDAP-URI was not parseable");
?>