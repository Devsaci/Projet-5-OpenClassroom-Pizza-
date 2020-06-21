
CREATE SEQUENCE public.pizza_id_seq;

CREATE TABLE public.pizza (
                id INTEGER NOT NULL DEFAULT nextval('public.pizza_id_seq'),
                refpizza VARCHAR(100) NOT NULL,
                prix_unitaire_ht NUMERIC(4,2) NOT NULL,
                CONSTRAINT pizza_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.pizza_id_seq OWNED BY public.pizza.id;

CREATE SEQUENCE public.ingrediant_id_seq;

CREATE TABLE public.ingrediant (
                id INTEGER NOT NULL DEFAULT nextval('public.ingrediant_id_seq'),
                refingrediant VARCHAR(100) NOT NULL,
                CONSTRAINT ingrediant_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.ingrediant_id_seq OWNED BY public.ingrediant.id;

CREATE TABLE public.recette (
                pizza_id INTEGER NOT NULL,
                ingrediant_id INTEGER NOT NULL,
                modepreparation VARCHAR(1000) NOT NULL,
                quantiteingrediant INTEGER NOT NULL,
                CONSTRAINT recette_pk PRIMARY KEY (pizza_id, ingrediant_id)
);


CREATE SEQUENCE public.adresse_id_seq;

CREATE TABLE public.adresse (
                id INTEGER NOT NULL DEFAULT nextval('public.adresse_id_seq'),
                numvoie VARCHAR(10) NOT NULL,
                voie VARCHAR(100) NOT NULL,
                ville VARCHAR(100) NOT NULL,
                codepostal VARCHAR(10) NOT NULL,
                pays VARCHAR(100) NOT NULL,
                CONSTRAINT adresse_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.adresse_id_seq OWNED BY public.adresse.id;

CREATE TABLE public.utilisateur (
                id INTEGER NOT NULL,
                password VARCHAR(10) NOT NULL,
                nom VARCHAR(100) NOT NULL,
                prenom VARCHAR(100) NOT NULL,
                login VARCHAR(10) NOT NULL,
                adresse_id INTEGER NOT NULL,
                CONSTRAINT utilisateur_pk PRIMARY KEY (id)
);


CREATE TABLE public.client (
                utilisateur_id INTEGER NOT NULL,
                email VARCHAR(100) NOT NULL,
                phone VARCHAR(10) NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (utilisateur_id)
);


CREATE TABLE public.employe (
                utilisateur_id INTEGER NOT NULL,
                role VARCHAR NOT NULL,
                CONSTRAINT employe_pk PRIMARY KEY (utilisateur_id)
);


CREATE TABLE public.commande (
                id INTEGER NOT NULL,
                employe_id INTEGER NOT NULL,
                client_id INTEGER NOT NULL,
                adresse_id INTEGER NOT NULL,
                etatcommande VARCHAR NOT NULL,
                paiement BOOLEAN NOT NULL,
                modepaiement VARCHAR NOT NULL,
                date TIMESTAMP NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (id)
);


CREATE TABLE public.etablissement (
                id INTEGER NOT NULL,
                commande_id INTEGER NOT NULL,
                adresse_id INTEGER NOT NULL,
                nomets VARCHAR(100) NOT NULL,
                email VARCHAR(100) NOT NULL,
                phone VARCHAR(10) NOT NULL,
                CONSTRAINT etablissement_pk PRIMARY KEY (id)
);


CREATE TABLE public.stock (
                ingrediant_id INTEGER NOT NULL,
                etablissement_id INTEGER NOT NULL,
                quantitestock INTEGER NOT NULL,
                CONSTRAINT stock_pk PRIMARY KEY (ingrediant_id, etablissement_id)
);


CREATE SEQUENCE public.facture_command_id_seq;

CREATE TABLE public.facture (
                id INTEGER NOT NULL,
                command_id INTEGER NOT NULL DEFAULT nextval('public.facture_command_id_seq'),
                date TIME NOT NULL,
                nomclient VARCHAR(100) NOT NULL,
                prixtotalttc NUMERIC(6,2) NOT NULL,
                CONSTRAINT facture_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.facture_command_id_seq OWNED BY public.facture.command_id;

CREATE TABLE public.lignecommande (
                command_id INTEGER NOT NULL,
                produit_id INTEGER NOT NULL,
                quantite VARCHAR NOT NULL,
                CONSTRAINT lignecommande_pk PRIMARY KEY (command_id, produit_id)
);


ALTER TABLE public.lignecommande ADD CONSTRAINT pizza_lignecommande_fk
FOREIGN KEY (produit_id)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.recette ADD CONSTRAINT pizza_recette_fk
FOREIGN KEY (pizza_id)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.recette ADD CONSTRAINT ingrediant_recette_fk
FOREIGN KEY (ingrediant_id)
REFERENCES public.ingrediant (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT ingrediant_stock_fk
FOREIGN KEY (ingrediant_id)
REFERENCES public.ingrediant (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT adresse_commande_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.etablissement ADD CONSTRAINT adresse_etablissement_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.utilisateur ADD CONSTRAINT adresse_utilisateur_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employe ADD CONSTRAINT utilisateur_employe_fk
FOREIGN KEY (utilisateur_id)
REFERENCES public.utilisateur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT utilisateur_client_fk
FOREIGN KEY (utilisateur_id)
REFERENCES public.utilisateur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (client_id)
REFERENCES public.client (utilisateur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT employe_commande_fk
FOREIGN KEY (employe_id)
REFERENCES public.employe (utilisateur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.lignecommande ADD CONSTRAINT commande_lignecommande_fk
FOREIGN KEY (command_id)
REFERENCES public.commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.facture ADD CONSTRAINT commande_facture_fk
FOREIGN KEY (command_id)
REFERENCES public.commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.etablissement ADD CONSTRAINT commande_etablissement_fk
FOREIGN KEY (commande_id)
REFERENCES public.commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT etablissement_stock_fk
FOREIGN KEY (etablissement_id)
REFERENCES public.etablissement (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;




--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.19
-- Dumped by pg_dump version 9.5.5

-- Started on 2020-01-04 17:25:52

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 2198 (class 0 OID 33385)
-- Dependencies: 187
-- Data for Name: adresse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY adresse (id, numvoie, voie, ville, codepostal, pays) FROM stdin;
8       8       rue8    ville8  0008    pays
1       1       rue1    ville1  0001    pays
2       2       rue2    ville2  0002    pays
3       3       rue3    ville3  0003    pays
4       4       rue4    ville4  0004    pays
5       5       rue5    ville5  0005    pays
6       6       rue6    ville6  0006    pays
7       7       rue7    ville7  0007    pays
9       9       rue9    ville9  0009    pays
10      10      rue10   ville10 00010   pays
11      11      rue11   ville11 00011   pays
12      12      rue12   ville12 00012   pays
13      13      rue13   ville13 00013   pays
14      14      rue14   ville14 00014   pays
15      15      rue15   ville15 00015   pays
16      16      rue16   ville16 00016   pays
17      17      rue17   ville17 00017   pays
18      18      rue18   ville18 00018   pays
19      19      rue19   ville19 00019   pays
20      20      rue20   ville20 00020   pays
\.


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 186
-- Name: adresse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('adresse_id_seq', 1, false);


--
-- TOC entry 2199 (class 0 OID 33391)
-- Dependencies: 188
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY utilisateur (id, password, nom, prenom, login, adresse_id) FROM stdin;
2       pwclient2       nomclient2      prenomclient2   lgclient2       2
1       pwclient1       nomclient1      prenomclient1   lgclient1       1
3       pwclient3       nomclient3      prenomclient3   lgclient3       3
4       pwclient4       nomclient4      prenomclient4   lgclient4       4
5       pwclient5       nomclient5      prenomclient5   lgclent5        5
6       pwclient6       nomclient6      prenomclient6   lgclient6       6
7       pwclient7       nomclient7      prenomclient7   lgclient7       7
8       pwclient8       nomclient8      prenomclient8   lgclient8       8
9       pwclient9       nomclient9      prenomclient9   lgclient9       9
10      pweploiye1      nomemploi10     prenomemploye10 lgemploye1      10
11      pwemploye1      nompmolye11     prenomemploye11 lgemploye1      11
13      pwemploye1      nompmolye13     prenomemploye13 lgemploye1      13
12      pwemploye1      nompmolye12     prenomemploye12 lgemploye1      12
14      pwemploye1      nompmolye14     prenomemploye14 lgemploye1      14
15      pwemploye1      nompmolye15     prenomemploye15 lgemploye1      15
\.


--
-- TOC entry 2200 (class 0 OID 33396)
-- Dependencies: 189
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY client (utilisateur_id, email, phone) FROM stdin;
1       mail1   tel1
2       mail2   tel2
3       mail3   tel3
4       mail4   tel4
5       mail5   tel5
6       mail6   tel6
7       mail7   tel7
9       mail9   tel9
8       mail8   tel8
\.


--
-- TOC entry 2201 (class 0 OID 33401)
-- Dependencies: 190
-- Data for Name: employe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employe (utilisateur_id, role) FROM stdin;
10      livreur
11      livreur
12      livreur
13      livreur
14      livreur
15      livreur
\.


--
-- TOC entry 2202 (class 0 OID 33409)
-- Dependencies: 191
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY commande (id, employe_id, client_id, adresse_id, etatcommande, paiement, modepaiement, date) FROM stdin;
2       12      2       2       liv     t       cb      2000-01-02 00:00:00
3       13      3       3       liv     t       esp     2000-01-03 12:00:00
1       11      1       1       liv     t       cb      2000-01-01 11:00:00
\.


--
-- TOC entry 2203 (class 0 OID 33417)
-- Dependencies: 192
-- Data for Name: etablissement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY etablissement (id, commande_id, adresse_id, nomets, email, phone) FROM stdin;
2    2   17      etsnom2 	etsmail2        etstel2
3    3   18      etsnom3 	etsmail3        etstel3
4    4   19      etsnom4 	etsmail4        etstel4
5    5   20      etsnom4 	etsmail4        etstel4
1    1   16      etsnom1 	etsmail1        etstel1
\.


--
-- TOC entry 2206 (class 0 OID 33429)
-- Dependencies: 195
-- Data for Name: facture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY facture (id, command_id, date, nomclient, prixtotalttc) FROM stdin;
1       1       11:00:00        nomclient1      50.00
2       2       11:00:00        nomclient2      60.00
3       3       01:00:00        nomclient3      500.00
\.


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 194
-- Name: facture_command_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('facture_command_id_seq', 1, false);


--
-- TOC entry 2195 (class 0 OID 33369)
-- Dependencies: 184
-- Data for Name: ingrediant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ingrediant (id, refingrediant) FROM stdin;
1       ing1
3       ing3
4       ing4
5       ing5
2       ing2
\.


--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 183
-- Name: ingrediant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ingrediant_id_seq', 1, false);


--
-- TOC entry 2193 (class 0 OID 33361)
-- Dependencies: 182
-- Data for Name: pizza; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pizza (id, refpizza, prix_unitaire_ht) FROM stdin;
1       pizza1  10.00
2       pizza2  20.00
3       pizza3  30.00
4       pizza4  40.00
5       pizza5  50.00
6       pizza6  60.00
\.


--
-- TOC entry 2207 (class 0 OID 33435)
-- Dependencies: 196
-- Data for Name: lignecommande; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lignecommande (command_id, produit_id, quantite) FROM stdin;
1       1       1
1       2       2
2       1       1
2       2       1
2       3       1
3       5       100
\.


--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 181
-- Name: pizza_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pizza_id_seq', 1, false);


--
-- TOC entry 2196 (class 0 OID 33375)
-- Dependencies: 185
-- Data for Name: recette; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY recette (pizza_id, ingrediant_id, modepreparation, quantiteingrediant) FROM stdin;
1       1       md1     10
2       1       md2     10
3       1       md3     10
3       3       md3     6
2       2       md2     8
3       2       md3     8
4       1       md4     10
4       2       md4     8
4       3       md4     6
4       4       md4     4
5       1       md5     10
5       2       md5     8
5       3       md5     6
5       4       md5     4
5       5       md5     2
\.


--
-- TOC entry 2204 (class 0 OID 33422)
-- Dependencies: 193
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY stock (ingrediant_id, etablissement_id, quantitestock) FROM stdin;
1       1       5000
2       1       4000
3       1       3000
4       1       2000
5       1       1000
1       2       5000
2       2       4000
3       2       3000
4       2       2000
5       2       1000
1       3       5000
2       3       4000
3       3       3000
4       3       2000
5       3       1000
\.


-- Completed on 2020-01-04 17:25:53

--
-- PostgreSQL database dump complete
--

