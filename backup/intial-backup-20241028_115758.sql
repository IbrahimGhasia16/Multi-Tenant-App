--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.users_tenants_roles DROP CONSTRAINT users_tenants_roles_parent_fk;
ALTER TABLE ONLY public.users_tenants DROP CONSTRAINT users_tenants_parent_id_fk;
ALTER TABLE ONLY public.users_roles DROP CONSTRAINT users_roles_parent_fk;
ALTER TABLE ONLY public.users_rels DROP CONSTRAINT users_rels_tenants_fk;
ALTER TABLE ONLY public.users_rels DROP CONSTRAINT users_rels_parent_fk;
ALTER TABLE ONLY public.tenants_domains DROP CONSTRAINT tenants_domains_parent_id_fk;
ALTER TABLE ONLY public.payload_preferences_rels DROP CONSTRAINT payload_preferences_rels_users_fk;
ALTER TABLE ONLY public.payload_preferences_rels DROP CONSTRAINT payload_preferences_rels_parent_fk;
ALTER TABLE ONLY public.pages_rels DROP CONSTRAINT pages_rels_tenants_fk;
ALTER TABLE ONLY public.pages_rels DROP CONSTRAINT pages_rels_parent_fk;
DROP INDEX public.users_tenants_roles_parent_idx;
DROP INDEX public.users_tenants_roles_order_idx;
DROP INDEX public.users_tenants_parent_id_idx;
DROP INDEX public.users_tenants_order_idx;
DROP INDEX public.users_roles_parent_idx;
DROP INDEX public.users_roles_order_idx;
DROP INDEX public.users_rels_tenants_id_idx;
DROP INDEX public.users_rels_path_idx;
DROP INDEX public.users_rels_parent_idx;
DROP INDEX public.users_rels_order_idx;
DROP INDEX public.users_email_idx;
DROP INDEX public.users_created_at_idx;
DROP INDEX public.tenants_domains_parent_id_idx;
DROP INDEX public.tenants_domains_order_idx;
DROP INDEX public.tenants_created_at_idx;
DROP INDEX public.payload_preferences_rels_users_id_idx;
DROP INDEX public.payload_preferences_rels_path_idx;
DROP INDEX public.payload_preferences_rels_parent_idx;
DROP INDEX public.payload_preferences_rels_order_idx;
DROP INDEX public.payload_preferences_key_idx;
DROP INDEX public.payload_preferences_created_at_idx;
DROP INDEX public.payload_migrations_created_at_idx;
DROP INDEX public.pages_slug_idx;
DROP INDEX public.pages_rels_tenants_id_idx;
DROP INDEX public.pages_rels_path_idx;
DROP INDEX public.pages_rels_parent_idx;
DROP INDEX public.pages_rels_order_idx;
DROP INDEX public.pages_created_at_idx;
ALTER TABLE ONLY public.users_tenants_roles DROP CONSTRAINT users_tenants_roles_pkey;
ALTER TABLE ONLY public.users_tenants DROP CONSTRAINT users_tenants_pkey;
ALTER TABLE ONLY public.users_roles DROP CONSTRAINT users_roles_pkey;
ALTER TABLE ONLY public.users_rels DROP CONSTRAINT users_rels_pkey;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.tenants DROP CONSTRAINT tenants_pkey;
ALTER TABLE ONLY public.tenants_domains DROP CONSTRAINT tenants_domains_pkey;
ALTER TABLE ONLY public.payload_preferences_rels DROP CONSTRAINT payload_preferences_rels_pkey;
ALTER TABLE ONLY public.payload_preferences DROP CONSTRAINT payload_preferences_pkey;
ALTER TABLE ONLY public.payload_migrations DROP CONSTRAINT payload_migrations_pkey;
ALTER TABLE ONLY public.pages_rels DROP CONSTRAINT pages_rels_pkey;
ALTER TABLE ONLY public.pages DROP CONSTRAINT pages_pkey;
ALTER TABLE public.users_tenants_roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.users_roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.users_rels ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.tenants ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.payload_preferences_rels ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.payload_preferences ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.payload_migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.pages_rels ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.pages ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.users_tenants_roles_id_seq;
DROP TABLE public.users_tenants_roles;
DROP TABLE public.users_tenants;
DROP SEQUENCE public.users_roles_id_seq;
DROP TABLE public.users_roles;
DROP SEQUENCE public.users_rels_id_seq;
DROP TABLE public.users_rels;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.tenants_id_seq;
DROP TABLE public.tenants_domains;
DROP TABLE public.tenants;
DROP SEQUENCE public.payload_preferences_rels_id_seq;
DROP TABLE public.payload_preferences_rels;
DROP SEQUENCE public.payload_preferences_id_seq;
DROP TABLE public.payload_preferences;
DROP SEQUENCE public.payload_migrations_id_seq;
DROP TABLE public.payload_migrations;
DROP SEQUENCE public.pages_rels_id_seq;
DROP TABLE public.pages_rels;
DROP SEQUENCE public.pages_id_seq;
DROP TABLE public.pages;
DROP TYPE public.enum_users_tenants_roles;
DROP TYPE public.enum_users_roles;
--
-- Name: enum_users_roles; Type: TYPE; Schema: public; Owner: keytoz
--

CREATE TYPE public.enum_users_roles AS ENUM (
    'super-admin',
    'user'
);


ALTER TYPE public.enum_users_roles OWNER TO keytoz;

--
-- Name: enum_users_tenants_roles; Type: TYPE; Schema: public; Owner: keytoz
--

CREATE TYPE public.enum_users_tenants_roles AS ENUM (
    'admin',
    'user'
);


ALTER TYPE public.enum_users_tenants_roles OWNER TO keytoz;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: pages; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.pages (
    id integer NOT NULL,
    title character varying NOT NULL,
    slug character varying,
    rich_text jsonb NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pages OWNER TO keytoz;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pages_id_seq OWNER TO keytoz;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: pages_rels; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.pages_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    tenants_id integer
);


ALTER TABLE public.pages_rels OWNER TO keytoz;

--
-- Name: pages_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.pages_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pages_rels_id_seq OWNER TO keytoz;

--
-- Name: pages_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.pages_rels_id_seq OWNED BY public.pages_rels.id;


--
-- Name: payload_migrations; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.payload_migrations (
    id integer NOT NULL,
    name character varying,
    batch numeric,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payload_migrations OWNER TO keytoz;

--
-- Name: payload_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.payload_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_migrations_id_seq OWNER TO keytoz;

--
-- Name: payload_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.payload_migrations_id_seq OWNED BY public.payload_migrations.id;


--
-- Name: payload_preferences; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.payload_preferences (
    id integer NOT NULL,
    key character varying,
    value jsonb,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payload_preferences OWNER TO keytoz;

--
-- Name: payload_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.payload_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_preferences_id_seq OWNER TO keytoz;

--
-- Name: payload_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.payload_preferences_id_seq OWNED BY public.payload_preferences.id;


--
-- Name: payload_preferences_rels; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.payload_preferences_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    users_id integer
);


ALTER TABLE public.payload_preferences_rels OWNER TO keytoz;

--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.payload_preferences_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_preferences_rels_id_seq OWNER TO keytoz;

--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.payload_preferences_rels_id_seq OWNED BY public.payload_preferences_rels.id;


--
-- Name: tenants; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.tenants (
    id integer NOT NULL,
    name character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.tenants OWNER TO keytoz;

--
-- Name: tenants_domains; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.tenants_domains (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    domain character varying NOT NULL
);


ALTER TABLE public.tenants_domains OWNER TO keytoz;

--
-- Name: tenants_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.tenants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tenants_id_seq OWNER TO keytoz;

--
-- Name: tenants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.tenants_id_seq OWNED BY public.tenants.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    email character varying NOT NULL,
    reset_password_token character varying,
    reset_password_expiration timestamp(3) with time zone,
    salt character varying,
    hash character varying,
    login_attempts numeric,
    lock_until timestamp(3) with time zone
);


ALTER TABLE public.users OWNER TO keytoz;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO keytoz;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_rels; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.users_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    tenants_id integer
);


ALTER TABLE public.users_rels OWNER TO keytoz;

--
-- Name: users_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.users_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_rels_id_seq OWNER TO keytoz;

--
-- Name: users_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.users_rels_id_seq OWNED BY public.users_rels.id;


--
-- Name: users_roles; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.users_roles (
    "order" integer NOT NULL,
    parent_id integer NOT NULL,
    value public.enum_users_roles,
    id integer NOT NULL
);


ALTER TABLE public.users_roles OWNER TO keytoz;

--
-- Name: users_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.users_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_roles_id_seq OWNER TO keytoz;

--
-- Name: users_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.users_roles_id_seq OWNED BY public.users_roles.id;


--
-- Name: users_tenants; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.users_tenants (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL
);


ALTER TABLE public.users_tenants OWNER TO keytoz;

--
-- Name: users_tenants_roles; Type: TABLE; Schema: public; Owner: keytoz
--

CREATE TABLE public.users_tenants_roles (
    "order" integer NOT NULL,
    parent_id character varying NOT NULL,
    value public.enum_users_tenants_roles,
    id integer NOT NULL
);


ALTER TABLE public.users_tenants_roles OWNER TO keytoz;

--
-- Name: users_tenants_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: keytoz
--

CREATE SEQUENCE public.users_tenants_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_tenants_roles_id_seq OWNER TO keytoz;

--
-- Name: users_tenants_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: keytoz
--

ALTER SEQUENCE public.users_tenants_roles_id_seq OWNED BY public.users_tenants_roles.id;


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: pages_rels id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.pages_rels ALTER COLUMN id SET DEFAULT nextval('public.pages_rels_id_seq'::regclass);


--
-- Name: payload_migrations id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.payload_migrations ALTER COLUMN id SET DEFAULT nextval('public.payload_migrations_id_seq'::regclass);


--
-- Name: payload_preferences id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.payload_preferences ALTER COLUMN id SET DEFAULT nextval('public.payload_preferences_id_seq'::regclass);


--
-- Name: payload_preferences_rels id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.payload_preferences_rels ALTER COLUMN id SET DEFAULT nextval('public.payload_preferences_rels_id_seq'::regclass);


--
-- Name: tenants id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.tenants ALTER COLUMN id SET DEFAULT nextval('public.tenants_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_rels id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_rels ALTER COLUMN id SET DEFAULT nextval('public.users_rels_id_seq'::regclass);


--
-- Name: users_roles id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_roles ALTER COLUMN id SET DEFAULT nextval('public.users_roles_id_seq'::regclass);


--
-- Name: users_tenants_roles id; Type: DEFAULT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_tenants_roles ALTER COLUMN id SET DEFAULT nextval('public.users_tenants_roles_id_seq'::regclass);


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.pages (id, title, slug, rich_text, updated_at, created_at) FROM stdin;
\.


--
-- Data for Name: pages_rels; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.pages_rels (id, "order", parent_id, path, tenants_id) FROM stdin;
\.


--
-- Data for Name: payload_migrations; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.payload_migrations (id, name, batch, updated_at, created_at) FROM stdin;
1	dev	-1	2024-10-28 06:11:51.135+00	2024-10-28 06:08:13.193+00
\.


--
-- Data for Name: payload_preferences; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.payload_preferences (id, key, value, updated_at, created_at) FROM stdin;
2	pages-list	{"limit": "10", "columns": [{"active": true, "accessor": "_select"}, {"active": true, "accessor": "title"}, {"active": true, "accessor": "slug"}, {"active": true, "accessor": "updatedAt"}, {"active": false, "accessor": "id"}, {"active": false, "accessor": "tenant"}, {"active": false, "accessor": "richText"}, {"active": false, "accessor": "createdAt"}]}	2024-10-28 06:11:04.899+00	2024-10-28 06:11:04.899+00
1	tenants-list	{"columns": [{"active": true, "accessor": "_select"}, {"active": true, "accessor": "name"}, {"active": true, "accessor": "id"}, {"active": true, "accessor": "domains"}, {"active": true, "accessor": "updatedAt"}, {"active": false, "accessor": "createdAt"}]}	2024-10-28 06:11:03.948+00	2024-10-28 06:11:03.948+00
3	users-list	{"columns": [{"active": true, "accessor": "_select"}, {"active": true, "accessor": "email"}, {"active": true, "accessor": "id"}, {"active": true, "accessor": "firstName"}, {"active": true, "accessor": "lastName"}, {"active": false, "accessor": "roles"}, {"active": false, "accessor": "tenants"}, {"active": false, "accessor": "lastLoggedInTenant"}, {"active": false, "accessor": "updatedAt"}, {"active": false, "accessor": "createdAt"}]}	2024-10-28 06:11:05.804+00	2024-10-28 06:11:05.804+00
\.


--
-- Data for Name: payload_preferences_rels; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.payload_preferences_rels (id, "order", parent_id, path, users_id) FROM stdin;
2	\N	2	user	1
7	\N	1	user	1
8	\N	3	user	1
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.tenants (id, name, updated_at, created_at) FROM stdin;
\.


--
-- Data for Name: tenants_domains; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.tenants_domains (_order, _parent_id, id, domain) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.users (id, first_name, last_name, updated_at, created_at, email, reset_password_token, reset_password_expiration, salt, hash, login_attempts, lock_until) FROM stdin;
1	Moiz	Palitanawala	2024-10-28 06:11:00.937+00	2024-10-28 06:10:59.711+00	moiz@keytoz.com	\N	\N	6fde58a3edd32fc0d0a18c55c90f42b01bfadf35fca708df5d0c5d9c8e2a6a30	068e225b939aea135096aa74e61ec628197a95426858705e65051433d8cc8695bd3f6286b62339286eabd618e8cb0150acfa6e8fb88ae4d219c1d4e7440d28df94384d6747ec2088423c005b8f5af41a0e0d26e2dbe87ba5d85c874f326e2c90a4b1bd35f56d58b302ec262a707243b37f5e89e507540e606e53b55697a76d85a9ce2c098ddea557c35cb7c2eb37fc42ab6c9d1de08928127a0261529d201575aac7ece657db0c61db9d938a5835179aaf61a1d95a937485a646e1b75cc0022650d95b37d5e992a4f04a8c28ca2cae3887b6b1dd3df9123100fdccb4a03a237b346877c36ff798ebf1a9c2541d548d5e3805a0519bbff2102f4adc519f3e50a0cbf49313c1761559b9b904e56e85f42d9bd43c20bdb5bf3e83a770e3ffd2588c265dd992e766323b325c4a9837c2e2a1f7953f2fe79617c5528aff78c35033dcff4ff3968da674a39a50e222047f94a5a869ad2b18a1e99078a8c0fd4d5bd4f0cac1c2e45d09bfa9a469e77aafc3e483f49395d2c8aa5d718422bc131b4d3f811ddb8bcd380da5aa2531024bb695847608ca05d400f103128081093417d53c8b9d09627fa20b242375f2929c637c3684959f77f209137f0a6028dcdd1f6a2ed3193ce5bf1894591654f6b940573a44750a86a782710964c6e130d269cc8de364699931a2e0faae2b4c9fc3562fe3b31158c728bdf3cab951ec7c351b983e1131	0	\N
\.


--
-- Data for Name: users_rels; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.users_rels (id, "order", parent_id, path, tenants_id) FROM stdin;
\.


--
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.users_roles ("order", parent_id, value, id) FROM stdin;
1	1	super-admin	3
\.


--
-- Data for Name: users_tenants; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.users_tenants (_order, _parent_id, id) FROM stdin;
\.


--
-- Data for Name: users_tenants_roles; Type: TABLE DATA; Schema: public; Owner: keytoz
--

COPY public.users_tenants_roles ("order", parent_id, value, id) FROM stdin;
\.


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.pages_id_seq', 1, false);


--
-- Name: pages_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.pages_rels_id_seq', 1, false);


--
-- Name: payload_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.payload_migrations_id_seq', 1, true);


--
-- Name: payload_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.payload_preferences_id_seq', 3, true);


--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.payload_preferences_rels_id_seq', 8, true);


--
-- Name: tenants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.tenants_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: users_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.users_rels_id_seq', 1, false);


--
-- Name: users_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.users_roles_id_seq', 3, true);


--
-- Name: users_tenants_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: keytoz
--

SELECT pg_catalog.setval('public.users_tenants_roles_id_seq', 1, false);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: pages_rels pages_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.pages_rels
    ADD CONSTRAINT pages_rels_pkey PRIMARY KEY (id);


--
-- Name: payload_migrations payload_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.payload_migrations
    ADD CONSTRAINT payload_migrations_pkey PRIMARY KEY (id);


--
-- Name: payload_preferences payload_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.payload_preferences
    ADD CONSTRAINT payload_preferences_pkey PRIMARY KEY (id);


--
-- Name: payload_preferences_rels payload_preferences_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_pkey PRIMARY KEY (id);


--
-- Name: tenants_domains tenants_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.tenants_domains
    ADD CONSTRAINT tenants_domains_pkey PRIMARY KEY (id);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_rels users_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_rels
    ADD CONSTRAINT users_rels_pkey PRIMARY KEY (id);


--
-- Name: users_roles users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (id);


--
-- Name: users_tenants users_tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_tenants
    ADD CONSTRAINT users_tenants_pkey PRIMARY KEY (id);


--
-- Name: users_tenants_roles users_tenants_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_tenants_roles
    ADD CONSTRAINT users_tenants_roles_pkey PRIMARY KEY (id);


--
-- Name: pages_created_at_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX pages_created_at_idx ON public.pages USING btree (created_at);


--
-- Name: pages_rels_order_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX pages_rels_order_idx ON public.pages_rels USING btree ("order");


--
-- Name: pages_rels_parent_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX pages_rels_parent_idx ON public.pages_rels USING btree (parent_id);


--
-- Name: pages_rels_path_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX pages_rels_path_idx ON public.pages_rels USING btree (path);


--
-- Name: pages_rels_tenants_id_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX pages_rels_tenants_id_idx ON public.pages_rels USING btree (tenants_id);


--
-- Name: pages_slug_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX pages_slug_idx ON public.pages USING btree (slug);


--
-- Name: payload_migrations_created_at_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX payload_migrations_created_at_idx ON public.payload_migrations USING btree (created_at);


--
-- Name: payload_preferences_created_at_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX payload_preferences_created_at_idx ON public.payload_preferences USING btree (created_at);


--
-- Name: payload_preferences_key_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX payload_preferences_key_idx ON public.payload_preferences USING btree (key);


--
-- Name: payload_preferences_rels_order_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX payload_preferences_rels_order_idx ON public.payload_preferences_rels USING btree ("order");


--
-- Name: payload_preferences_rels_parent_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX payload_preferences_rels_parent_idx ON public.payload_preferences_rels USING btree (parent_id);


--
-- Name: payload_preferences_rels_path_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX payload_preferences_rels_path_idx ON public.payload_preferences_rels USING btree (path);


--
-- Name: payload_preferences_rels_users_id_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX payload_preferences_rels_users_id_idx ON public.payload_preferences_rels USING btree (users_id);


--
-- Name: tenants_created_at_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX tenants_created_at_idx ON public.tenants USING btree (created_at);


--
-- Name: tenants_domains_order_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX tenants_domains_order_idx ON public.tenants_domains USING btree (_order);


--
-- Name: tenants_domains_parent_id_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX tenants_domains_parent_id_idx ON public.tenants_domains USING btree (_parent_id);


--
-- Name: users_created_at_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_created_at_idx ON public.users USING btree (created_at);


--
-- Name: users_email_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE UNIQUE INDEX users_email_idx ON public.users USING btree (email);


--
-- Name: users_rels_order_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_rels_order_idx ON public.users_rels USING btree ("order");


--
-- Name: users_rels_parent_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_rels_parent_idx ON public.users_rels USING btree (parent_id);


--
-- Name: users_rels_path_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_rels_path_idx ON public.users_rels USING btree (path);


--
-- Name: users_rels_tenants_id_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_rels_tenants_id_idx ON public.users_rels USING btree (tenants_id);


--
-- Name: users_roles_order_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_roles_order_idx ON public.users_roles USING btree ("order");


--
-- Name: users_roles_parent_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_roles_parent_idx ON public.users_roles USING btree (parent_id);


--
-- Name: users_tenants_order_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_tenants_order_idx ON public.users_tenants USING btree (_order);


--
-- Name: users_tenants_parent_id_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_tenants_parent_id_idx ON public.users_tenants USING btree (_parent_id);


--
-- Name: users_tenants_roles_order_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_tenants_roles_order_idx ON public.users_tenants_roles USING btree ("order");


--
-- Name: users_tenants_roles_parent_idx; Type: INDEX; Schema: public; Owner: keytoz
--

CREATE INDEX users_tenants_roles_parent_idx ON public.users_tenants_roles USING btree (parent_id);


--
-- Name: pages_rels pages_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.pages_rels
    ADD CONSTRAINT pages_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.pages(id) ON DELETE CASCADE;


--
-- Name: pages_rels pages_rels_tenants_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.pages_rels
    ADD CONSTRAINT pages_rels_tenants_fk FOREIGN KEY (tenants_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: payload_preferences_rels payload_preferences_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.payload_preferences(id) ON DELETE CASCADE;


--
-- Name: payload_preferences_rels payload_preferences_rels_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: tenants_domains tenants_domains_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.tenants_domains
    ADD CONSTRAINT tenants_domains_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: users_rels users_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_rels
    ADD CONSTRAINT users_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_rels users_rels_tenants_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_rels
    ADD CONSTRAINT users_rels_tenants_fk FOREIGN KEY (tenants_id) REFERENCES public.tenants(id) ON DELETE CASCADE;


--
-- Name: users_roles users_roles_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_parent_fk FOREIGN KEY (parent_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_tenants users_tenants_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_tenants
    ADD CONSTRAINT users_tenants_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_tenants_roles users_tenants_roles_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: keytoz
--

ALTER TABLE ONLY public.users_tenants_roles
    ADD CONSTRAINT users_tenants_roles_parent_fk FOREIGN KEY (parent_id) REFERENCES public.users_tenants(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

