
| *Maven Artifact*  | *Version*  | *FIPS Artifact*  | *FIPS Version*  ||
|---------|-------|--------------|--------|---|
| bcmail  | 1.81  | bcmail-fips  | 2.1.6  | S/MIME with JavaMail  |
| bcpg    | 1.81  | bcpg-fips    | 2.1.11 | OpenPGP Protocol  |
| bcpkix  | 1.81  | bcpkix-fips  | 2.1.9  | CMS, PKCS, EAC, TSP, CMP, CRMF, OCSP, S/MIME and certificate generation  |
| bcprov  | 1.81  | bc-fips      | 2.1.0  | JCE Provider  |
| bcutil  | 1.81  | bcutil-fips  | 2.1.4  | ASN.1 extension and utility APIs  |

* Check latest version available at https://mvnrepository.com/
* bc-fips doesn't include JCE provider, only JCAJCE Provider
* Apply fips.diff to switch from normal bouncy castle bundles to FIPS 140-3 Level 1 compliance bundles


