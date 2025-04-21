--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Homebrew)
-- Dumped by pg_dump version 16.8 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: AttendeeStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."AttendeeStatus" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'DECLINED',
    'TENTATIVE'
);


--
-- Name: Status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."Status" AS ENUM (
    'PENDING',
    'PAID',
    'MISSED'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Account; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Account" (
    id text NOT NULL,
    "userId" integer NOT NULL,
    type text NOT NULL,
    provider text NOT NULL,
    "providerAccountId" text NOT NULL,
    refresh_token text,
    access_token text,
    expires_at integer,
    token_type text,
    scope text,
    id_token text,
    session_state text
);


--
-- Name: CalendarEvent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CalendarEvent" (
    id integer NOT NULL,
    title text NOT NULL,
    description text,
    start_time timestamp(3) without time zone NOT NULL,
    end_time timestamp(3) without time zone NOT NULL,
    location text,
    created_by integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: CalendarEventAttendee; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CalendarEventAttendee" (
    id integer NOT NULL,
    event_id integer NOT NULL,
    user_id integer NOT NULL,
    status public."AttendeeStatus" DEFAULT 'PENDING'::public."AttendeeStatus" NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: CalendarEventAttendee_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."CalendarEventAttendee_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: CalendarEventAttendee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."CalendarEventAttendee_id_seq" OWNED BY public."CalendarEventAttendee".id;


--
-- Name: CalendarEvent_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."CalendarEvent_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: CalendarEvent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."CalendarEvent_id_seq" OWNED BY public."CalendarEvent".id;


--
-- Name: Contribution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Contribution" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    month text NOT NULL,
    year integer NOT NULL,
    status public."Status" DEFAULT 'PENDING'::public."Status" NOT NULL,
    notes text,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Contribution_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Contribution_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Contribution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Contribution_id_seq" OWNED BY public."Contribution".id;


--
-- Name: Inquiry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Inquiry" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    subject text NOT NULL,
    message text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: Inquiry_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Inquiry_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Inquiry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Inquiry_id_seq" OWNED BY public."Inquiry".id;


--
-- Name: Session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Session" (
    id text NOT NULL,
    "sessionToken" text NOT NULL,
    "userId" integer NOT NULL,
    expires timestamp(3) without time zone NOT NULL
);


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "emailVerified" timestamp(3) without time zone,
    password text NOT NULL,
    image text,
    is_admin boolean DEFAULT false NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: CalendarEvent id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CalendarEvent" ALTER COLUMN id SET DEFAULT nextval('public."CalendarEvent_id_seq"'::regclass);


--
-- Name: CalendarEventAttendee id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CalendarEventAttendee" ALTER COLUMN id SET DEFAULT nextval('public."CalendarEventAttendee_id_seq"'::regclass);


--
-- Name: Contribution id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Contribution" ALTER COLUMN id SET DEFAULT nextval('public."Contribution_id_seq"'::regclass);


--
-- Name: Inquiry id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inquiry" ALTER COLUMN id SET DEFAULT nextval('public."Inquiry_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Account; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Account" (id, "userId", type, provider, "providerAccountId", refresh_token, access_token, expires_at, token_type, scope, id_token, session_state) FROM stdin;
\.


--
-- Data for Name: CalendarEvent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CalendarEvent" (id, title, description, start_time, end_time, location, created_by, created_at, updated_at) FROM stdin;
1	Training Session	Virtus voluptates tredecim nostrum via cinis. Solitudo assumenda amet damnatio acceptus vetus vomito. Abstergo spero spiritus utrum dicta arbor.	2025-03-03 04:00:00	2025-03-03 06:00:00	Community Center	15	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
2	Workshop	Astrum cubicularis vulgo barba tempora dolore totidem. Conicio cattus vulnero aut voro. Vociferor attonbitus communis inventore.	2025-03-28 06:00:00	2025-03-28 09:00:00	Outdoor Park	37	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
3	Board Meeting	Desolo dapifer debilito. Artificiose carcer ipsam abundans dignissimos viduo balbus. Comminor casso coepi delinquo corporis sub dapifer fugit cena.	2025-03-08 05:00:00	2025-03-08 08:00:00	Library	32	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
4	Networking Event	Stultus arguo usque sodalitas et confero tot curia aestivus. Perferendis vulariter subvenio clibanus socius pariatur acervus confero textus. Cavus cicuta comparo deripio deleo socius utilis.	2025-03-05 02:00:00	2025-03-05 03:00:00	Beach Resort	15	2025-04-18 18:55:33.07	2025-04-18 18:55:33.07
5	Community Service	Quae exercitationem sodalitas conspergo caste. Inventore cognomen acsi turba adduco adfectus capto acceptus paens cogo. Congregatio succedo amplexus aestas.	2025-03-02 05:00:00	2025-03-02 07:00:00	Community Center	44	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
6	Member Orientation	Aedificium aegre cunctatio villa arcesso complectus nesciunt adulescens. Velit subiungo umerus. A cuius videlicet vomica deserunt vulticulus.	2025-03-11 01:00:00	2025-03-11 03:00:00	Garden Venue	27	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
7	Member Orientation	Cubicularis torrens una decumbo studio ocer deripio vorago. Benevolentia aut pauper nobis ventus. Xiphias deporto celer auctor.	2025-03-10 06:00:00	2025-03-10 09:00:00	Library	39	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
9	Strategic Planning	Admiratio quam comes varius dens depono nobis pecco admoveo acer. Ex torqueo doloremque avaritia. Vulgivagus qui sustineo utor.	2025-03-19 07:00:00	2025-03-19 10:00:00	Community Center	43	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
10	Special Project Discussion	Caelestis cursim calculus absorbeo temeritas vero absque corona aeger victoria. Porro consectetur aequus amet. Commodo spiritus teneo artificiose maiores paens damno.	2025-03-08 06:00:00	2025-03-08 08:00:00	School Auditorium	19	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
11	Team Building	Pel currus tergeo curiositas ars ulciscor labore auditor. Itaque celo voveo colligo careo aduro bellicus sunt. Desipio super acervus quasi arma sordeo defleo coruscus vir.	2025-03-03 05:00:00	2025-03-03 06:00:00	Main Hall	22	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
12	Training Session	Sub uxor surculus canonicus articulus suffoco. Earum abscido bis cunabula aegrus. Tempore maiores demoror sunt assumenda vitium vinco.	2025-03-08 08:00:00	2025-03-08 11:00:00	Library	47	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
13	Special Project Discussion	Dolorum vesco dolorem vere adsuesco denique pauci testimonium vociferor damnatio. Credo quisquam careo tollo vallum. Tripudio aestas benigne.	2025-03-23 02:00:00	2025-03-23 03:00:00	School Auditorium	11	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
14	Workshop	Decumbo tergum vinum pectus adsum comburo necessitatibus substantia. Tutamen baiulus solvo dolor. Vel tenetur accedo valens cilicium cerno copiose.	2025-03-10 02:00:00	2025-03-10 04:00:00	Cultural Center	1	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
15	Team Building	Comitatus tenuis vito viduo defungo utique creo aetas vomito sui. Aspicio voluptatem administratio distinctio. Venia decens audacia.	2025-03-06 01:00:00	2025-03-06 03:00:00	Cultural Center	43	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
16	Fundraising Event	Arcesso ultio defero bibo capto. Chirographum turba decipio defendo ulciscor crux beneficium abduco comis tum. Tersus statua distinctio cerno creator alter synagoga.	2025-04-10 08:00:00	2025-04-10 10:00:00	Town Hall	45	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
17	Monthly Meeting	Adsidue surgo dolor adhaero carmen aro conitor pariatur eligendi cruciamentum. Antiquus aegre advoco accusamus carpo depromo voluptates viridis capillus. Allatus hic defessus vulticulus derideo.	2025-04-09 07:00:00	2025-04-09 10:00:00	Sports Complex	34	2025-04-18 18:55:33.158	2025-04-18 18:55:33.158
18	Committee Meeting	Altus subvenio conturbo virtus cornu decipio ventus. Totus terga aptus custodia crudelis tabesco id numquam deleo. Repudiandae absorbeo vesica arguo.	2025-04-03 06:00:00	2025-04-03 08:00:00	Online Meeting	45	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
19	Member Orientation	Harum aufero coniecto defluo carus blandior deinde aliqua cauda. Defetiscor caterva cunabula aliqua. Argumentum vulgaris numquam defleo nesciunt quae.	2025-04-02 08:00:00	2025-04-02 09:00:00	Main Hall	44	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
20	Community Outreach	Spargo via cum numquam libero adfectus congregatio. Vero tonsor vestigium consuasor ubi vallum exercitationem spero. Conatus contego sapiente.	2025-04-28 02:00:00	2025-04-28 04:00:00	Town Hall	37	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
21	Community Service	Subiungo tabernus tenetur mollitia vacuus. Architecto illo vereor demonstro tollo aetas ventosus damnatio. Delectus synagoga alienus stella quisquam sortitus demitto clarus deludo.	2025-04-25 08:00:00	2025-04-25 11:00:00	Outdoor Park	36	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
22	Community Outreach	Depulso valetudo dolore tantum repellendus aperiam denuo reiciendis maxime claro. Vallum cura vos alo decimus abduco sequi trans tutis. Absconditus capitulus pecco angulus.	2025-04-25 01:00:00	2025-04-25 03:00:00	Garden Venue	13	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
23	Annual General Assembly	Patria asper uxor demens auditor tres theca. Usus demum ascit dapifer soluta deprecator. Crustulum addo theatrum dolorum cohors considero accommodo tibi culpo.	2025-04-04 07:00:00	2025-04-04 09:00:00	School Auditorium	49	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
24	Special Project Discussion	Attero urbs triumphus altus. Deserunt tergo autus blanditiis sono terra. Valeo commodo speculum tersus stella.	2025-04-20 05:00:00	2025-04-20 06:00:00	Hotel Conference Room	25	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
25	Volunteer Training	Deripio sublime pauper. Circumvenio natus ventus cursim inflammatio amissio testimonium terga. Absque cornu aureus earum utpote adimpleo.	2025-04-02 07:00:00	2025-04-02 10:00:00	Online Meeting	24	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
26	Community Outreach	Patruus defetiscor demulceo clamo amo cultellus acidus vereor. Maxime quaerat sopor molestiae aestus beneficium theatrum spero. Aestus neque amet demonstro.	2025-04-27 07:00:00	2025-04-27 10:00:00	Cultural Center	51	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
27	Member Orientation	Quam casso thesis bis advenio deleniti. Cohaero teneo coaegresco velum solio demo adipiscor cinis. Demo attonbitus studio.	2025-04-04 04:00:00	2025-04-04 07:00:00	Outdoor Park	18	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
28	Annual Review	Territo spero officiis virgo pectus. Debilito casus desparatus crinis delego similique tenus. Argumentum clementia vulariter astrum adeo comes.	2025-04-06 08:00:00	2025-04-06 09:00:00	Main Hall	28	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
29	Member Orientation	Temporibus nisi facilis acerbitas crudelis. Audio paulatim super accusantium commodi quas tergum tonsor cometes canonicus. Exercitationem appello aliqua absorbeo dapifer ulterius vox vomer.	2025-04-03 03:00:00	2025-04-03 06:00:00	Outdoor Park	27	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
30	Committee Meeting	Adduco denuo auxilium centum. Thymbra degenero aetas debilito assumenda adulatio currus tepesco creptio tot. Clibanus truculenter carus xiphias solio.	2025-04-16 01:00:00	2025-04-16 02:00:00	Town Hall	48	2025-04-18 18:55:33.191	2025-04-18 18:55:33.191
31	Member Orientation	Dedico crinis canonicus esse triumphus usque supellex laudantium. Cuius totam concedo compono reiciendis tyrannus bonus. Ab quod aggredior.	2025-05-06 05:00:00	2025-05-06 08:00:00	Online Meeting	3	2025-04-18 18:55:33.192	2025-04-18 18:55:33.192
32	Board Meeting	Arceo audeo alter umbra virga. Suggero defleo acerbitas ad. Vero temptatio provident.	2025-05-20 04:00:00	2025-05-20 05:00:00	Conference Room A	21	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
33	Award Ceremony	Confero bos caute usque. Decet abbas uredo uxor pel. Vitiosus tabgo nemo constans spectaculum vereor tactus corporis crur.	2025-05-06 03:00:00	2025-05-06 04:00:00	Garden Venue	5	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
34	Volunteer Training	Cado acies tabernus brevis. Claustrum cupio bellicus suus aeger ulterius fuga spectaculum decipio circumvenio. Adipiscor caput ustulo tres delego vociferor quos tollo curatio officia.	2025-05-24 08:00:00	2025-05-24 09:00:00	Member's Residence	49	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
35	Member Orientation	Arbustum tenetur verumtamen aqua ratione supplanto omnis saepe. Decimus vilis autem aureus carpo ademptio somniculosus esse subnecto. At sequi cometes crur bene eius caste speciosus nemo.	2025-05-11 08:00:00	2025-05-11 11:00:00	Cultural Center	5	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
36	Community Outreach	Bonus cras appono iusto torqueo. Viscus valeo inventore. Pauper vapulus cibo.	2025-05-09 06:00:00	2025-05-09 07:00:00	Outdoor Park	1	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
37	Workshop	Perspiciatis explicabo custodia tamdiu sufficio. Dolores circumvenio tero quaerat. Sequi creo trado arbitro deorsum abscido circumvenio concido delinquo tristis.	2025-05-30 03:00:00	2025-05-30 06:00:00	Garden Venue	38	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
38	Team Building	Vitae ante consectetur amaritudo civis comis aqua ullam conculco necessitatibus. Degero debilito solus conforto voluptas cerno et vulnus coniuratio. Thorax cribro solvo conor numquam attonbitus cito tenuis avarus.	2025-05-30 08:00:00	2025-05-30 10:00:00	Online Meeting	35	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
39	Committee Meeting	Vinculum deserunt dolorem corroboro cur adstringo bene vetus terror tabernus. Tergum degero pauci itaque creta ascisco accusamus. Stillicidium cumque vulgus stipes cariosus defetiscor baiulus.	2025-05-03 03:00:00	2025-05-03 05:00:00	Garden Venue	47	2025-04-18 18:55:33.206	2025-04-18 18:55:33.206
40	Community Outreach	Demens damnatio rerum deleo adficio desipio amor aegrotatio quis tres. Suffoco accusamus adsuesco. Quae aperte vigilo crastinus amoveo vinitor tego damno.	2025-05-05 05:00:00	2025-05-05 06:00:00	Sports Complex	21	2025-04-18 18:55:33.208	2025-04-18 18:55:33.208
41	Annual General Assembly	Aliqua collum delego administratio. Cubitum timidus addo vicissitudo. Claudeo decipio patior amet.	2025-05-06 02:00:00	2025-05-06 05:00:00	Town Hall	13	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
42	Community Service	Accusamus demitto cui vergo textus universe. Trans versus turbo terminatio totus deleo verus aedificium casus depereo. Arguo adiuvo adhaero creo vigor tutamen vesco tracto antepono.	2025-05-03 01:00:00	2025-05-03 04:00:00	Community Center	8	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
43	Workshop	Aliquid victus depereo cursim. Volup infit votum umerus beatae depopulo. Vobis vicinus deserunt aegre adduco.	2025-05-13 01:00:00	2025-05-13 03:00:00	Town Hall	37	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
45	Strategic Planning	Temeritas crinis volo enim aggredior provident undique correptius armarium color. Tabesco tredecim solitudo. Concedo cerno voluptates vir claro illum defendo tergiversatio.	2025-05-12 03:00:00	2025-05-12 05:00:00	Restaurant	27	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
55	asdf	asdf	2025-04-19 14:08:00	2025-04-19 15:08:00	adsf	1	2025-04-19 11:08:16.516	2025-04-19 11:08:16.516
\.


--
-- Data for Name: CalendarEventAttendee; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CalendarEventAttendee" (id, event_id, user_id, status, created_at, updated_at) FROM stdin;
1	1	15	ACCEPTED	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
2	1	20	TENTATIVE	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
3	1	37	DECLINED	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
4	1	21	TENTATIVE	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
5	1	1	DECLINED	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
6	1	27	PENDING	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
7	1	4	TENTATIVE	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
8	1	47	TENTATIVE	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
9	1	32	PENDING	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
10	1	13	ACCEPTED	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
11	1	11	ACCEPTED	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
12	1	24	DECLINED	2025-04-18 18:55:33.049	2025-04-18 18:55:33.049
13	2	37	ACCEPTED	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
15	2	7	PENDING	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
16	2	32	TENTATIVE	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
17	2	34	ACCEPTED	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
18	2	19	TENTATIVE	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
19	2	25	TENTATIVE	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
20	2	52	DECLINED	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
22	2	48	TENTATIVE	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
23	2	8	PENDING	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
24	2	50	TENTATIVE	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
25	2	28	PENDING	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
26	2	4	TENTATIVE	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
27	2	30	ACCEPTED	2025-04-18 18:55:33.062	2025-04-18 18:55:33.062
28	3	32	ACCEPTED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
29	3	2	DECLINED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
30	3	45	TENTATIVE	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
31	3	49	DECLINED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
32	3	11	PENDING	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
33	3	43	ACCEPTED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
34	3	8	PENDING	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
35	3	24	DECLINED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
36	3	51	ACCEPTED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
37	3	18	ACCEPTED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
38	3	35	ACCEPTED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
39	3	4	DECLINED	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
40	3	22	TENTATIVE	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
41	3	53	PENDING	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
42	3	33	TENTATIVE	2025-04-18 18:55:33.067	2025-04-18 18:55:33.067
43	4	15	ACCEPTED	2025-04-18 18:55:33.07	2025-04-18 18:55:33.07
44	4	47	TENTATIVE	2025-04-18 18:55:33.07	2025-04-18 18:55:33.07
45	4	44	TENTATIVE	2025-04-18 18:55:33.07	2025-04-18 18:55:33.07
46	4	22	ACCEPTED	2025-04-18 18:55:33.07	2025-04-18 18:55:33.07
47	4	4	ACCEPTED	2025-04-18 18:55:33.07	2025-04-18 18:55:33.07
48	4	33	PENDING	2025-04-18 18:55:33.07	2025-04-18 18:55:33.07
49	5	44	ACCEPTED	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
50	5	8	PENDING	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
51	5	7	ACCEPTED	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
52	5	39	DECLINED	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
53	5	38	ACCEPTED	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
54	5	51	PENDING	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
55	5	3	DECLINED	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
56	5	49	PENDING	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
57	5	12	PENDING	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
58	5	25	PENDING	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
59	5	41	ACCEPTED	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
61	5	22	PENDING	2025-04-18 18:55:33.073	2025-04-18 18:55:33.073
62	6	27	ACCEPTED	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
63	6	8	PENDING	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
64	6	26	DECLINED	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
65	6	48	ACCEPTED	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
66	6	4	TENTATIVE	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
68	6	46	TENTATIVE	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
69	6	51	DECLINED	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
70	6	3	PENDING	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
71	6	42	ACCEPTED	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
72	6	25	PENDING	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
73	6	5	ACCEPTED	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
74	6	23	DECLINED	2025-04-18 18:55:33.075	2025-04-18 18:55:33.075
75	7	39	ACCEPTED	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
76	7	49	TENTATIVE	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
77	7	26	PENDING	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
78	7	43	ACCEPTED	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
79	7	17	PENDING	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
80	7	50	TENTATIVE	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
81	7	51	DECLINED	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
82	7	36	PENDING	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
83	7	42	TENTATIVE	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
84	7	28	TENTATIVE	2025-04-18 18:55:33.076	2025-04-18 18:55:33.076
97	9	43	ACCEPTED	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
98	9	46	TENTATIVE	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
99	9	49	TENTATIVE	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
100	9	41	ACCEPTED	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
101	9	37	TENTATIVE	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
102	9	3	PENDING	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
103	9	52	TENTATIVE	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
104	9	6	TENTATIVE	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
105	9	21	DECLINED	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
106	9	15	ACCEPTED	2025-04-18 18:55:33.083	2025-04-18 18:55:33.083
107	10	19	ACCEPTED	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
108	10	53	ACCEPTED	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
110	10	41	ACCEPTED	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
111	10	5	ACCEPTED	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
112	10	25	PENDING	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
113	10	35	PENDING	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
114	10	36	PENDING	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
115	10	49	ACCEPTED	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
116	10	16	DECLINED	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
117	10	6	TENTATIVE	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
118	10	28	PENDING	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
119	10	8	PENDING	2025-04-18 18:55:33.085	2025-04-18 18:55:33.085
120	11	22	ACCEPTED	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
121	11	45	ACCEPTED	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
122	11	23	DECLINED	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
123	11	32	DECLINED	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
124	11	39	TENTATIVE	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
125	11	42	PENDING	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
126	11	14	PENDING	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
127	11	51	DECLINED	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
128	11	36	PENDING	2025-04-18 18:55:33.087	2025-04-18 18:55:33.087
129	12	47	ACCEPTED	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
130	12	44	DECLINED	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
131	12	11	PENDING	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
132	12	15	ACCEPTED	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
133	12	14	TENTATIVE	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
134	12	16	DECLINED	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
135	12	3	TENTATIVE	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
136	12	21	TENTATIVE	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
137	12	24	TENTATIVE	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
138	12	34	ACCEPTED	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
139	12	39	DECLINED	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
140	12	17	TENTATIVE	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
141	12	31	PENDING	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
142	12	49	PENDING	2025-04-18 18:55:33.091	2025-04-18 18:55:33.091
144	13	11	ACCEPTED	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
145	13	36	DECLINED	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
146	13	2	TENTATIVE	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
147	13	27	ACCEPTED	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
148	13	43	PENDING	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
149	13	14	PENDING	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
150	13	18	PENDING	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
151	13	31	PENDING	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
152	13	45	ACCEPTED	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
153	13	47	DECLINED	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
154	13	22	TENTATIVE	2025-04-18 18:55:33.127	2025-04-18 18:55:33.127
155	14	1	ACCEPTED	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
156	14	33	TENTATIVE	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
157	14	18	PENDING	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
159	14	46	ACCEPTED	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
160	14	53	DECLINED	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
161	14	14	TENTATIVE	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
162	14	15	TENTATIVE	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
166	14	21	DECLINED	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
167	14	12	PENDING	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
168	14	25	TENTATIVE	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
169	14	42	ACCEPTED	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
170	14	39	ACCEPTED	2025-04-18 18:55:33.144	2025-04-18 18:55:33.144
171	15	43	ACCEPTED	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
172	15	28	TENTATIVE	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
173	15	20	ACCEPTED	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
174	15	31	PENDING	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
176	15	8	ACCEPTED	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
177	15	34	DECLINED	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
178	15	50	PENDING	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
179	15	6	TENTATIVE	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
180	15	33	PENDING	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
181	15	25	TENTATIVE	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
183	15	52	ACCEPTED	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
184	15	11	ACCEPTED	2025-04-18 18:55:33.149	2025-04-18 18:55:33.149
185	16	45	ACCEPTED	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
186	16	4	DECLINED	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
187	16	34	ACCEPTED	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
188	16	38	PENDING	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
189	16	35	ACCEPTED	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
190	16	33	ACCEPTED	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
191	16	28	ACCEPTED	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
192	16	12	PENDING	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
193	16	48	ACCEPTED	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
194	16	42	ACCEPTED	2025-04-18 18:55:33.152	2025-04-18 18:55:33.152
195	17	34	ACCEPTED	2025-04-18 18:55:33.158	2025-04-18 18:55:33.158
196	17	51	DECLINED	2025-04-18 18:55:33.158	2025-04-18 18:55:33.158
197	17	8	DECLINED	2025-04-18 18:55:33.158	2025-04-18 18:55:33.158
198	17	47	PENDING	2025-04-18 18:55:33.158	2025-04-18 18:55:33.158
199	17	7	TENTATIVE	2025-04-18 18:55:33.158	2025-04-18 18:55:33.158
200	17	6	TENTATIVE	2025-04-18 18:55:33.158	2025-04-18 18:55:33.158
201	17	24	DECLINED	2025-04-18 18:55:33.158	2025-04-18 18:55:33.158
202	18	45	ACCEPTED	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
203	18	48	DECLINED	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
204	18	5	TENTATIVE	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
205	18	22	PENDING	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
207	18	33	PENDING	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
208	18	1	TENTATIVE	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
209	18	53	TENTATIVE	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
210	18	35	ACCEPTED	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
211	18	3	ACCEPTED	2025-04-18 18:55:33.16	2025-04-18 18:55:33.16
212	19	44	ACCEPTED	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
213	19	1	PENDING	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
214	19	20	TENTATIVE	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
215	19	28	TENTATIVE	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
217	19	19	DECLINED	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
219	19	33	PENDING	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
220	19	36	DECLINED	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
221	19	22	PENDING	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
222	19	47	PENDING	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
223	19	7	DECLINED	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
224	19	32	TENTATIVE	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
225	19	3	PENDING	2025-04-18 18:55:33.171	2025-04-18 18:55:33.171
226	20	37	ACCEPTED	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
227	20	5	ACCEPTED	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
228	20	33	DECLINED	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
229	20	12	ACCEPTED	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
230	20	48	ACCEPTED	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
231	20	13	PENDING	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
232	20	18	DECLINED	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
233	20	52	TENTATIVE	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
234	20	26	ACCEPTED	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
235	20	43	TENTATIVE	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
236	20	41	PENDING	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
237	20	49	ACCEPTED	2025-04-18 18:55:33.175	2025-04-18 18:55:33.175
238	21	36	ACCEPTED	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
239	21	6	DECLINED	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
240	21	14	ACCEPTED	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
241	21	17	DECLINED	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
242	21	19	PENDING	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
243	21	26	PENDING	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
244	21	32	PENDING	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
245	21	12	DECLINED	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
246	21	50	TENTATIVE	2025-04-18 18:55:33.177	2025-04-18 18:55:33.177
247	22	13	ACCEPTED	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
248	22	17	DECLINED	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
249	22	21	ACCEPTED	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
251	22	36	DECLINED	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
252	22	30	ACCEPTED	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
253	22	52	PENDING	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
254	22	6	PENDING	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
255	22	38	DECLINED	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
256	22	50	DECLINED	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
257	22	37	TENTATIVE	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
259	22	2	DECLINED	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
260	22	20	PENDING	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
261	22	44	TENTATIVE	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
262	22	33	TENTATIVE	2025-04-18 18:55:33.179	2025-04-18 18:55:33.179
263	23	49	ACCEPTED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
264	23	32	ACCEPTED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
266	23	39	PENDING	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
267	23	47	ACCEPTED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
268	23	27	DECLINED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
269	23	16	DECLINED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
270	23	14	ACCEPTED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
271	23	35	PENDING	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
272	23	18	DECLINED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
273	23	41	DECLINED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
274	23	44	ACCEPTED	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
275	23	23	TENTATIVE	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
276	23	48	PENDING	2025-04-18 18:55:33.181	2025-04-18 18:55:33.181
277	24	25	ACCEPTED	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
279	24	18	DECLINED	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
280	24	7	TENTATIVE	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
281	24	41	DECLINED	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
282	24	44	DECLINED	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
283	24	28	ACCEPTED	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
284	24	1	TENTATIVE	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
285	24	8	TENTATIVE	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
286	24	35	PENDING	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
287	24	22	TENTATIVE	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
288	24	23	PENDING	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
289	24	31	PENDING	2025-04-18 18:55:33.184	2025-04-18 18:55:33.184
290	25	24	ACCEPTED	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
291	25	8	ACCEPTED	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
292	25	26	ACCEPTED	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
293	25	27	DECLINED	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
294	25	16	TENTATIVE	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
295	25	6	TENTATIVE	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
296	25	42	TENTATIVE	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
298	25	45	PENDING	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
299	25	53	DECLINED	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
300	25	36	DECLINED	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
301	25	31	TENTATIVE	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
302	25	52	ACCEPTED	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
304	25	28	ACCEPTED	2025-04-18 18:55:33.185	2025-04-18 18:55:33.185
305	26	51	ACCEPTED	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
306	26	27	PENDING	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
307	26	43	DECLINED	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
308	26	12	PENDING	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
309	26	35	ACCEPTED	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
310	26	17	TENTATIVE	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
311	26	53	PENDING	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
312	26	8	TENTATIVE	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
314	26	26	TENTATIVE	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
315	26	30	PENDING	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
317	26	13	TENTATIVE	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
318	26	38	TENTATIVE	2025-04-18 18:55:33.186	2025-04-18 18:55:33.186
319	27	18	ACCEPTED	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
320	27	32	PENDING	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
321	27	8	TENTATIVE	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
322	27	41	PENDING	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
324	27	43	TENTATIVE	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
325	27	4	PENDING	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
326	27	46	TENTATIVE	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
327	27	28	PENDING	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
328	27	44	PENDING	2025-04-18 18:55:33.188	2025-04-18 18:55:33.188
329	28	28	ACCEPTED	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
330	28	52	PENDING	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
331	28	36	TENTATIVE	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
332	28	33	ACCEPTED	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
333	28	3	DECLINED	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
334	28	16	ACCEPTED	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
335	28	42	ACCEPTED	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
337	28	2	PENDING	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
338	28	17	TENTATIVE	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
339	28	45	ACCEPTED	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
340	28	15	DECLINED	2025-04-18 18:55:33.189	2025-04-18 18:55:33.189
341	29	27	ACCEPTED	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
342	29	35	TENTATIVE	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
343	29	8	ACCEPTED	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
344	29	12	DECLINED	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
345	29	36	TENTATIVE	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
346	29	51	TENTATIVE	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
347	29	46	DECLINED	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
348	29	32	DECLINED	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
349	29	2	TENTATIVE	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
350	29	7	ACCEPTED	2025-04-18 18:55:33.19	2025-04-18 18:55:33.19
351	30	48	ACCEPTED	2025-04-18 18:55:33.191	2025-04-18 18:55:33.191
352	30	47	DECLINED	2025-04-18 18:55:33.191	2025-04-18 18:55:33.191
353	30	7	DECLINED	2025-04-18 18:55:33.191	2025-04-18 18:55:33.191
354	30	32	DECLINED	2025-04-18 18:55:33.191	2025-04-18 18:55:33.191
355	30	50	DECLINED	2025-04-18 18:55:33.191	2025-04-18 18:55:33.191
357	30	39	PENDING	2025-04-18 18:55:33.191	2025-04-18 18:55:33.191
358	30	2	ACCEPTED	2025-04-18 18:55:33.191	2025-04-18 18:55:33.191
360	31	3	ACCEPTED	2025-04-18 18:55:33.192	2025-04-18 18:55:33.192
361	31	15	DECLINED	2025-04-18 18:55:33.192	2025-04-18 18:55:33.192
362	31	34	ACCEPTED	2025-04-18 18:55:33.192	2025-04-18 18:55:33.192
363	31	12	PENDING	2025-04-18 18:55:33.192	2025-04-18 18:55:33.192
364	31	27	ACCEPTED	2025-04-18 18:55:33.192	2025-04-18 18:55:33.192
365	31	26	TENTATIVE	2025-04-18 18:55:33.192	2025-04-18 18:55:33.192
366	31	16	PENDING	2025-04-18 18:55:33.192	2025-04-18 18:55:33.192
367	32	21	ACCEPTED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
368	32	39	TENTATIVE	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
369	32	53	DECLINED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
370	32	42	DECLINED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
371	32	27	TENTATIVE	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
372	32	15	ACCEPTED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
373	32	20	TENTATIVE	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
374	32	12	ACCEPTED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
375	32	45	DECLINED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
376	32	41	DECLINED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
377	32	34	TENTATIVE	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
378	32	26	DECLINED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
379	32	1	PENDING	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
380	32	17	ACCEPTED	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
381	32	14	PENDING	2025-04-18 18:55:33.194	2025-04-18 18:55:33.194
382	33	5	ACCEPTED	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
383	33	34	PENDING	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
385	33	41	DECLINED	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
386	33	19	ACCEPTED	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
387	33	50	ACCEPTED	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
388	33	21	DECLINED	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
389	33	27	ACCEPTED	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
390	33	26	DECLINED	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
391	33	35	DECLINED	2025-04-18 18:55:33.195	2025-04-18 18:55:33.195
392	34	49	ACCEPTED	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
393	34	2	TENTATIVE	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
395	34	4	TENTATIVE	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
396	34	6	ACCEPTED	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
397	34	41	DECLINED	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
398	34	42	PENDING	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
399	34	38	PENDING	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
400	34	12	ACCEPTED	2025-04-18 18:55:33.196	2025-04-18 18:55:33.196
401	35	5	ACCEPTED	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
402	35	31	DECLINED	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
403	35	25	TENTATIVE	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
404	35	15	TENTATIVE	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
405	35	18	TENTATIVE	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
407	35	21	ACCEPTED	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
408	35	45	TENTATIVE	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
409	35	42	ACCEPTED	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
410	35	2	ACCEPTED	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
411	35	47	TENTATIVE	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
412	35	11	TENTATIVE	2025-04-18 18:55:33.198	2025-04-18 18:55:33.198
414	36	1	ACCEPTED	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
415	36	28	ACCEPTED	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
416	36	35	PENDING	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
417	36	48	PENDING	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
418	36	44	PENDING	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
419	36	52	TENTATIVE	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
420	36	49	PENDING	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
421	36	3	DECLINED	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
422	36	42	DECLINED	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
423	36	18	PENDING	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
424	36	37	DECLINED	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
425	36	38	DECLINED	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
426	36	21	PENDING	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
427	36	22	DECLINED	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
428	36	12	ACCEPTED	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
429	36	7	TENTATIVE	2025-04-18 18:55:33.2	2025-04-18 18:55:33.2
430	37	38	ACCEPTED	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
431	37	17	TENTATIVE	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
432	37	8	DECLINED	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
433	37	47	ACCEPTED	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
434	37	33	DECLINED	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
435	37	43	ACCEPTED	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
436	37	15	PENDING	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
437	37	45	DECLINED	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
438	37	53	PENDING	2025-04-18 18:55:33.203	2025-04-18 18:55:33.203
439	38	35	ACCEPTED	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
440	38	22	DECLINED	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
441	38	11	PENDING	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
442	38	15	PENDING	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
443	38	42	PENDING	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
444	38	41	TENTATIVE	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
445	38	16	DECLINED	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
446	38	13	PENDING	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
447	38	37	TENTATIVE	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
448	38	47	PENDING	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
449	38	28	ACCEPTED	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
450	38	46	TENTATIVE	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
451	38	14	PENDING	2025-04-18 18:55:33.205	2025-04-18 18:55:33.205
452	39	47	ACCEPTED	2025-04-18 18:55:33.206	2025-04-18 18:55:33.206
453	39	49	TENTATIVE	2025-04-18 18:55:33.206	2025-04-18 18:55:33.206
455	39	27	DECLINED	2025-04-18 18:55:33.206	2025-04-18 18:55:33.206
456	39	43	TENTATIVE	2025-04-18 18:55:33.206	2025-04-18 18:55:33.206
457	39	5	TENTATIVE	2025-04-18 18:55:33.206	2025-04-18 18:55:33.206
458	40	21	ACCEPTED	2025-04-18 18:55:33.208	2025-04-18 18:55:33.208
459	40	23	TENTATIVE	2025-04-18 18:55:33.208	2025-04-18 18:55:33.208
460	40	44	PENDING	2025-04-18 18:55:33.208	2025-04-18 18:55:33.208
461	40	6	PENDING	2025-04-18 18:55:33.208	2025-04-18 18:55:33.208
463	40	4	DECLINED	2025-04-18 18:55:33.208	2025-04-18 18:55:33.208
464	41	13	ACCEPTED	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
465	41	22	DECLINED	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
466	41	25	DECLINED	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
467	41	33	ACCEPTED	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
469	41	5	TENTATIVE	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
470	41	50	TENTATIVE	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
471	41	16	DECLINED	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
472	41	6	DECLINED	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
473	41	1	PENDING	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
474	41	23	DECLINED	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
475	41	19	PENDING	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
477	41	4	TENTATIVE	2025-04-18 18:55:33.221	2025-04-18 18:55:33.221
478	42	8	ACCEPTED	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
479	42	20	PENDING	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
480	42	12	DECLINED	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
481	42	37	ACCEPTED	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
482	42	47	PENDING	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
483	42	36	PENDING	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
484	42	42	TENTATIVE	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
485	42	43	TENTATIVE	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
486	42	49	DECLINED	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
487	42	19	DECLINED	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
488	42	17	DECLINED	2025-04-18 18:55:33.222	2025-04-18 18:55:33.222
489	43	37	ACCEPTED	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
490	43	53	ACCEPTED	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
491	43	47	DECLINED	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
492	43	49	ACCEPTED	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
493	43	14	DECLINED	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
494	43	41	ACCEPTED	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
495	43	19	DECLINED	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
496	43	42	TENTATIVE	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
497	43	50	PENDING	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
498	43	27	TENTATIVE	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
499	43	13	PENDING	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
500	43	20	TENTATIVE	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
501	43	43	ACCEPTED	2025-04-18 18:55:33.224	2025-04-18 18:55:33.224
512	45	27	ACCEPTED	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
514	45	20	DECLINED	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
516	45	15	DECLINED	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
517	45	32	DECLINED	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
518	45	52	PENDING	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
519	45	41	DECLINED	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
520	45	30	ACCEPTED	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
521	45	12	DECLINED	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
522	45	49	PENDING	2025-04-18 18:55:33.226	2025-04-18 18:55:33.226
539	55	1	ACCEPTED	2025-04-19 11:08:16.516	2025-04-19 11:08:16.516
540	55	2	PENDING	2025-04-19 11:08:16.516	2025-04-19 11:08:16.516
541	55	3	PENDING	2025-04-19 11:08:16.516	2025-04-19 11:08:16.516
542	55	4	PENDING	2025-04-19 11:08:16.516	2025-04-19 11:08:16.516
\.


--
-- Data for Name: Contribution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Contribution" (id, user_id, amount, month, year, status, notes, created_at, updated_at) FROM stdin;
1	1	953.00	April	2025	PENDING	Payment scheduled	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
3	1	1048.00	February	2025	MISSED	Member requested extension	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
5	1	903.00	December	2024	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
6	1	919.00	November	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
7	1	925.00	October	2024	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
8	1	1079.00	September	2024	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
9	1	981.00	August	2024	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
10	1	1026.00	July	2024	MISSED	Member requested extension	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
11	1	1119.00	June	2024	PAID	Partial payment received	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
12	1	986.00	May	2024	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
13	1	804.00	April	2024	PAID	Payment confirmed	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
14	1	1043.00	March	2024	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
15	1	870.00	February	2024	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
16	1	1012.00	January	2024	PAID	Partial payment received	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
17	1	1094.00	December	2023	PENDING	Additional contribution included	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
18	1	960.00	November	2023	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
19	1	948.00	October	2023	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
20	1	1192.00	September	2023	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
21	1	1093.00	August	2023	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
22	1	904.00	July	2023	PAID	Additional contribution included	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
23	1	1180.00	June	2023	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
24	1	850.00	May	2023	PAID	\N	2025-04-18 18:55:32.749	2025-04-18 18:55:32.749
25	2	977.00	April	2025	PENDING	Partial payment received	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
26	2	818.00	March	2025	PAID	Paid via bank transfer	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
27	2	1185.00	February	2025	PAID	Partial payment received	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
29	2	1068.00	December	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
30	2	857.00	November	2024	MISSED	Payment failed	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
31	2	890.00	October	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
32	2	813.00	September	2024	PAID	Additional contribution included	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
33	2	898.00	August	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
34	2	898.00	July	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
35	2	1186.00	June	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
36	2	939.00	May	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
37	2	825.00	April	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
38	2	956.00	March	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
39	2	913.00	February	2024	PAID	Partial payment received	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
40	2	1007.00	January	2024	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
41	2	998.00	December	2023	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
42	2	1120.00	November	2023	PAID	Payment scheduled	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
43	2	935.00	October	2023	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
44	2	1158.00	September	2023	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
45	2	917.00	August	2023	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
46	2	1133.00	July	2023	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
47	2	1045.00	June	2023	PAID	Payment confirmed	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
48	2	900.00	May	2023	PAID	\N	2025-04-18 18:55:32.759	2025-04-18 18:55:32.759
49	3	815.00	April	2025	PENDING	Additional contribution included	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
51	3	954.00	February	2025	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
53	3	845.00	December	2024	PAID	Payment scheduled	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
54	3	928.00	November	2024	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
55	3	1070.00	October	2024	PAID	Payment scheduled	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
56	3	1154.00	September	2024	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
57	3	913.00	August	2024	PAID	Payment confirmed	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
58	3	1180.00	July	2024	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
59	3	833.00	June	2024	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
60	3	889.00	May	2024	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
61	3	1164.00	April	2024	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
62	3	1021.00	March	2024	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
63	3	830.00	February	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
64	3	1187.00	January	2024	PENDING	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
65	3	972.00	December	2023	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
66	3	1069.00	November	2023	MISSED	Financial hardship reported	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
67	3	1074.00	October	2023	PAID	Additional contribution included	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
68	3	1096.00	September	2023	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
69	3	1055.00	August	2023	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
70	3	946.00	July	2023	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
71	3	928.00	June	2023	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
72	3	1060.00	May	2023	PAID	\N	2025-04-18 18:55:32.761	2025-04-18 18:55:32.761
73	4	930.00	April	2025	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
74	4	1104.00	March	2025	PAID	Partial payment received	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
75	4	904.00	February	2025	PENDING	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
76	4	1081.00	January	2025	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
77	4	1119.00	December	2024	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
78	4	873.00	November	2024	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
79	4	841.00	October	2024	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
80	4	975.00	September	2024	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
81	4	1125.00	August	2024	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
82	4	1069.00	July	2024	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
83	4	1195.00	June	2024	PAID	Partial payment received	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
84	4	879.00	May	2024	PAID	Payment scheduled	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
85	4	986.00	April	2024	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
86	4	1062.00	March	2024	PAID	Payment confirmed	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
87	4	859.00	February	2024	PAID	Partial payment received	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
88	4	1046.00	January	2024	PAID	Additional contribution included	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
89	4	849.00	December	2023	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
90	4	916.00	November	2023	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
91	4	1095.00	October	2023	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
92	4	823.00	September	2023	MISSED	Member requested extension	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
93	4	1060.00	August	2023	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
94	4	938.00	July	2023	MISSED	Member requested extension	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
95	4	950.00	June	2023	PAID	\N	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
96	4	810.00	May	2023	MISSED	Member requested extension	2025-04-18 18:55:32.765	2025-04-18 18:55:32.765
97	5	968.00	April	2025	PENDING	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
98	5	1119.00	March	2025	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
100	5	1186.00	January	2025	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
101	5	1132.00	December	2024	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
102	5	1123.00	November	2024	PAID	Additional contribution included	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
103	5	836.00	October	2024	PENDING	Additional contribution included	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
104	5	1042.00	September	2024	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
105	5	835.00	August	2024	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
106	5	1134.00	July	2024	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
107	5	1106.00	June	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
108	5	913.00	May	2024	MISSED	Will pay next month	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
109	5	892.00	April	2024	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
110	5	931.00	March	2024	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
111	5	887.00	February	2024	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
112	5	836.00	January	2024	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
113	5	1052.00	December	2023	PAID	Payment confirmed	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
114	5	1188.00	November	2023	PENDING	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
115	5	909.00	October	2023	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
116	5	1016.00	September	2023	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
117	5	986.00	August	2023	PAID	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
118	5	884.00	July	2023	PENDING	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
119	5	802.00	June	2023	MISSED	Payment failed	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
120	5	838.00	May	2023	PENDING	\N	2025-04-18 18:55:32.777	2025-04-18 18:55:32.777
121	6	996.00	April	2025	PENDING	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
122	6	962.00	March	2025	PENDING	Additional contribution included	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
123	6	949.00	February	2025	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
124	6	950.00	January	2025	PAID	Partial payment received	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
125	6	819.00	December	2024	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
126	6	903.00	November	2024	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
127	6	909.00	October	2024	PAID	Partial payment received	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
128	6	1099.00	September	2024	PENDING	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
129	6	1177.00	August	2024	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
130	6	1145.00	July	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
131	6	909.00	June	2024	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
133	6	970.00	April	2024	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
134	6	938.00	March	2024	PAID	Partial payment received	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
135	6	948.00	February	2024	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
136	6	1199.00	January	2024	PAID	Additional contribution included	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
137	6	800.00	December	2023	PENDING	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
138	6	1083.00	November	2023	MISSED	Payment failed	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
139	6	889.00	October	2023	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
140	6	839.00	September	2023	PAID	Additional contribution included	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
141	6	883.00	August	2023	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
142	6	903.00	July	2023	PAID	Additional contribution included	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
143	6	927.00	June	2023	PAID	\N	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
144	6	1112.00	May	2023	MISSED	Will pay next month	2025-04-18 18:55:32.781	2025-04-18 18:55:32.781
145	7	809.00	April	2025	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
146	7	1127.00	March	2025	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
147	7	874.00	February	2025	PENDING	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
148	7	1067.00	January	2025	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
149	7	1187.00	December	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
150	7	1151.00	November	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
151	7	865.00	October	2024	PAID	Payment scheduled	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
152	7	1179.00	September	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
153	7	1089.00	August	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
154	7	1114.00	July	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
155	7	829.00	June	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
156	7	975.00	May	2024	PAID	Payment scheduled	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
157	7	927.00	April	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
158	7	904.00	March	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
159	7	1113.00	February	2024	PAID	Partial payment received	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
160	7	871.00	January	2024	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
161	7	903.00	December	2023	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
162	7	1001.00	November	2023	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
163	7	899.00	October	2023	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
164	7	837.00	September	2023	PAID	Payment scheduled	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
165	7	1190.00	August	2023	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
166	7	810.00	July	2023	PAID	Payment confirmed	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
167	7	997.00	June	2023	PENDING	Additional contribution included	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
168	7	983.00	May	2023	PAID	\N	2025-04-18 18:55:32.785	2025-04-18 18:55:32.785
169	8	1166.00	April	2025	PENDING	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
170	8	838.00	March	2025	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
171	8	940.00	February	2025	PENDING	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
172	8	924.00	January	2025	PAID	Partial payment received	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
173	8	1129.00	December	2024	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
174	8	867.00	November	2024	MISSED	Payment failed	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
175	8	1102.00	October	2024	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
176	8	990.00	September	2024	PAID	Payment scheduled	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
177	8	918.00	August	2024	PAID	Partial payment received	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
178	8	1056.00	July	2024	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
179	8	1118.00	June	2024	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
180	8	849.00	May	2024	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
181	8	1035.00	April	2024	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
182	8	892.00	March	2024	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
183	8	903.00	February	2024	MISSED	Will pay next month	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
184	8	1010.00	January	2024	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
185	8	861.00	December	2023	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
186	8	1068.00	November	2023	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
187	8	821.00	October	2023	PAID	Payment confirmed	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
188	8	938.00	September	2023	MISSED	Financial hardship reported	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
189	8	831.00	August	2023	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
190	8	1047.00	July	2023	MISSED	Member requested extension	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
191	8	971.00	June	2023	MISSED	Will pay next month	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
192	8	1110.00	May	2023	PAID	\N	2025-04-18 18:55:32.788	2025-04-18 18:55:32.788
241	11	1153.00	April	2025	PENDING	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
242	11	1119.00	March	2025	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
243	11	1036.00	February	2025	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
244	11	1155.00	January	2025	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
245	11	1131.00	December	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
246	11	1178.00	November	2024	PAID	Partial payment received	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
248	11	870.00	September	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
249	11	944.00	August	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
250	11	1116.00	July	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
251	11	1171.00	June	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
252	11	878.00	May	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
253	11	889.00	April	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
254	11	938.00	March	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
255	11	826.00	February	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
256	11	1034.00	January	2024	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
257	11	968.00	December	2023	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
258	11	988.00	November	2023	PAID	Partial payment received	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
260	11	926.00	September	2023	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
261	11	972.00	August	2023	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
262	11	1156.00	July	2023	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
263	11	1089.00	June	2023	PAID	\N	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
264	11	897.00	May	2023	PAID	Payment scheduled	2025-04-18 18:55:32.8	2025-04-18 18:55:32.8
265	12	962.00	April	2025	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
266	12	809.00	March	2025	PENDING	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
267	12	1003.00	February	2025	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
268	12	1166.00	January	2025	PENDING	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
269	12	1148.00	December	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
270	12	992.00	November	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
271	12	1097.00	October	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
272	12	1172.00	September	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
273	12	808.00	August	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
274	12	1083.00	July	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
275	12	900.00	June	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
276	12	1051.00	May	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
277	12	933.00	April	2024	PAID	Payment scheduled	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
278	12	891.00	March	2024	PAID	Partial payment received	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
279	12	1067.00	February	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
280	12	1178.00	January	2024	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
281	12	1008.00	December	2023	PAID	Payment scheduled	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
282	12	991.00	November	2023	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
283	12	1114.00	October	2023	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
284	12	839.00	September	2023	PAID	Payment confirmed	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
285	12	1031.00	August	2023	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
286	12	947.00	July	2023	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
287	12	1078.00	June	2023	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
288	12	1109.00	May	2023	PAID	\N	2025-04-18 18:55:32.803	2025-04-18 18:55:32.803
289	13	1107.00	April	2025	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
290	13	1034.00	March	2025	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
291	13	1138.00	February	2025	MISSED	Financial hardship reported	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
292	13	1124.00	January	2025	PAID	Paid via bank transfer	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
293	13	889.00	December	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
294	13	1003.00	November	2024	MISSED	Member requested extension	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
295	13	938.00	October	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
296	13	1076.00	September	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
297	13	955.00	August	2024	MISSED	Member on leave	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
298	13	842.00	July	2024	PAID	Payment scheduled	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
299	13	1162.00	June	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
300	13	1019.00	May	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
301	13	1079.00	April	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
302	13	1009.00	March	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
303	13	1083.00	February	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
304	13	821.00	January	2024	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
305	13	1026.00	December	2023	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
306	13	1011.00	November	2023	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
307	13	913.00	October	2023	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
308	13	1059.00	September	2023	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
309	13	850.00	August	2023	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
310	13	932.00	July	2023	MISSED	Payment failed	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
311	13	814.00	June	2023	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
312	13	984.00	May	2023	PAID	\N	2025-04-18 18:55:32.807	2025-04-18 18:55:32.807
313	14	868.00	April	2025	PENDING	Payment scheduled	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
314	14	1145.00	March	2025	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
315	14	1025.00	February	2025	MISSED	Payment failed	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
316	14	1075.00	January	2025	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
317	14	934.00	December	2024	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
318	14	990.00	November	2024	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
319	14	1082.00	October	2024	PAID	Additional contribution included	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
320	14	875.00	September	2024	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
321	14	1121.00	August	2024	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
322	14	985.00	July	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
323	14	1033.00	June	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
324	14	1000.00	May	2024	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
325	14	1006.00	April	2024	PENDING	Additional contribution included	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
326	14	1087.00	March	2024	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
327	14	1170.00	February	2024	MISSED	Member requested extension	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
328	14	878.00	January	2024	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
329	14	879.00	December	2023	PAID	Additional contribution included	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
330	14	956.00	November	2023	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
331	14	967.00	October	2023	MISSED	Payment failed	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
332	14	975.00	September	2023	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
333	14	1091.00	August	2023	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
334	14	1072.00	July	2023	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
335	14	901.00	June	2023	PAID	Payment confirmed	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
336	14	1044.00	May	2023	PAID	\N	2025-04-18 18:55:32.81	2025-04-18 18:55:32.81
337	15	903.00	April	2025	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
338	15	1052.00	March	2025	PAID	Paid via bank transfer	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
339	15	831.00	February	2025	PENDING	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
340	15	946.00	January	2025	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
341	15	1013.00	December	2024	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
342	15	1127.00	November	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
343	15	868.00	October	2024	MISSED	Member requested extension	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
344	15	842.00	September	2024	PAID	Payment confirmed	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
345	15	1037.00	August	2024	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
346	15	818.00	July	2024	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
347	15	1128.00	June	2024	PAID	Partial payment received	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
348	15	1171.00	May	2024	PAID	Partial payment received	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
349	15	860.00	April	2024	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
350	15	1024.00	March	2024	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
351	15	1113.00	February	2024	PENDING	Paid via bank transfer	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
352	15	950.00	January	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
353	15	820.00	December	2023	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
354	15	1061.00	November	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
355	15	865.00	October	2023	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
356	15	800.00	September	2023	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
357	15	874.00	August	2023	MISSED	Member requested extension	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
358	15	912.00	July	2023	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
359	15	833.00	June	2023	PENDING	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
360	15	1149.00	May	2023	PAID	\N	2025-04-18 18:55:32.813	2025-04-18 18:55:32.813
361	16	903.00	April	2025	PAID	Paid via bank transfer	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
362	16	999.00	March	2025	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
363	16	892.00	February	2025	PENDING	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
364	16	877.00	January	2025	PENDING	Payment scheduled	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
365	16	940.00	December	2024	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
366	16	933.00	November	2024	MISSED	Payment failed	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
367	16	889.00	October	2024	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
368	16	825.00	September	2024	PENDING	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
369	16	926.00	August	2024	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
370	16	827.00	July	2024	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
371	16	1139.00	June	2024	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
372	16	1033.00	May	2024	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
373	16	1036.00	April	2024	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
374	16	1065.00	March	2024	PAID	Payment scheduled	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
375	16	1052.00	February	2024	PAID	Payment scheduled	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
376	16	934.00	January	2024	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
377	16	938.00	December	2023	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
378	16	1016.00	November	2023	PAID	Payment confirmed	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
379	16	857.00	October	2023	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
380	16	1168.00	September	2023	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
381	16	975.00	August	2023	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
382	16	907.00	July	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
383	16	827.00	June	2023	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
384	16	960.00	May	2023	PAID	\N	2025-04-18 18:55:32.819	2025-04-18 18:55:32.819
385	17	941.00	April	2025	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
386	17	1187.00	March	2025	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
387	17	1094.00	February	2025	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
389	17	859.00	December	2024	PENDING	Partial payment received	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
390	17	1086.00	November	2024	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
391	17	1175.00	October	2024	PAID	Additional contribution included	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
392	17	992.00	September	2024	PAID	Partial payment received	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
393	17	1055.00	August	2024	MISSED	Payment failed	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
394	17	1138.00	July	2024	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
395	17	996.00	June	2024	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
396	17	919.00	May	2024	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
397	17	907.00	April	2024	PAID	Payment confirmed	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
398	17	1002.00	March	2024	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
399	17	922.00	February	2024	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
400	17	973.00	January	2024	PAID	Payment scheduled	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
401	17	1178.00	December	2023	MISSED	Member on leave	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
402	17	804.00	November	2023	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
403	17	1194.00	October	2023	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
404	17	1167.00	September	2023	MISSED	Will pay next month	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
405	17	1053.00	August	2023	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
406	17	1056.00	July	2023	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
407	17	953.00	June	2023	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
408	17	1012.00	May	2023	PAID	\N	2025-04-18 18:55:32.823	2025-04-18 18:55:32.823
409	18	1068.00	April	2025	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
410	18	1198.00	March	2025	MISSED	Payment failed	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
411	18	913.00	February	2025	PENDING	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
412	18	1174.00	January	2025	PENDING	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
413	18	1003.00	December	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
414	18	1089.00	November	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
415	18	886.00	October	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
416	18	971.00	September	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
417	18	1116.00	August	2024	PAID	Partial payment received	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
418	18	802.00	July	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
419	18	881.00	June	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
420	18	852.00	May	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
421	18	1019.00	April	2024	PENDING	Paid via bank transfer	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
422	18	848.00	March	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
423	18	1152.00	February	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
424	18	1087.00	January	2024	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
425	18	1059.00	December	2023	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
426	18	1066.00	November	2023	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
427	18	972.00	October	2023	MISSED	Will pay next month	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
428	18	814.00	September	2023	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
429	18	819.00	August	2023	PAID	Partial payment received	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
430	18	878.00	July	2023	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
431	18	948.00	June	2023	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
432	18	843.00	May	2023	PAID	\N	2025-04-18 18:55:32.827	2025-04-18 18:55:32.827
433	19	834.00	April	2025	PENDING	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
434	19	878.00	March	2025	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
435	19	1022.00	February	2025	PAID	Payment confirmed	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
436	19	1149.00	January	2025	MISSED	Member requested extension	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
437	19	971.00	December	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
438	19	1165.00	November	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
439	19	955.00	October	2024	PAID	Additional contribution included	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
440	19	1019.00	September	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
441	19	1008.00	August	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
442	19	1006.00	July	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
443	19	920.00	June	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
444	19	1111.00	May	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
445	19	936.00	April	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
446	19	1163.00	March	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
447	19	1153.00	February	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
448	19	1034.00	January	2024	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
449	19	899.00	December	2023	PAID	Payment confirmed	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
450	19	1141.00	November	2023	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
451	19	1160.00	October	2023	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
452	19	1148.00	September	2023	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
453	19	943.00	August	2023	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
454	19	1015.00	July	2023	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
455	19	1062.00	June	2023	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
456	19	968.00	May	2023	PAID	\N	2025-04-18 18:55:32.83	2025-04-18 18:55:32.83
457	20	1108.00	April	2025	PENDING	Paid via bank transfer	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
458	20	1152.00	March	2025	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
459	20	1195.00	February	2025	PAID	Paid via bank transfer	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
460	20	960.00	January	2025	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
461	20	1046.00	December	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
462	20	1096.00	November	2024	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
463	20	1046.00	October	2024	PAID	Partial payment received	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
464	20	1163.00	September	2024	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
465	20	956.00	August	2024	PAID	Payment scheduled	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
466	20	1080.00	July	2024	PAID	Partial payment received	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
467	20	1081.00	June	2024	PENDING	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
468	20	936.00	May	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
469	20	883.00	April	2024	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
470	20	1016.00	March	2024	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
471	20	914.00	February	2024	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
472	20	854.00	January	2024	PAID	Payment confirmed	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
473	20	923.00	December	2023	PAID	Additional contribution included	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
474	20	1104.00	November	2023	MISSED	Member requested extension	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
475	20	974.00	October	2023	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
476	20	1105.00	September	2023	PENDING	Payment confirmed	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
477	20	911.00	August	2023	PAID	\N	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
478	20	827.00	July	2023	PAID	Payment confirmed	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
479	20	1014.00	June	2023	MISSED	Payment failed	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
480	20	882.00	May	2023	PAID	Payment confirmed	2025-04-18 18:55:32.839	2025-04-18 18:55:32.839
481	21	1082.00	April	2025	PENDING	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
482	21	840.00	March	2025	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
483	21	937.00	February	2025	PENDING	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
484	21	1062.00	January	2025	PENDING	Partial payment received	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
485	21	994.00	December	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
486	21	1128.00	November	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
487	21	1185.00	October	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
488	21	827.00	September	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
489	21	910.00	August	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
490	21	1158.00	July	2024	PENDING	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
491	21	1136.00	June	2024	PENDING	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
492	21	912.00	May	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
493	21	1076.00	April	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
494	21	1110.00	March	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
495	21	1092.00	February	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
496	21	934.00	January	2024	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
497	21	960.00	December	2023	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
498	21	1053.00	November	2023	PENDING	Payment scheduled	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
499	21	905.00	October	2023	MISSED	Member requested extension	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
500	21	1164.00	September	2023	PENDING	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
501	21	930.00	August	2023	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
502	21	953.00	July	2023	MISSED	Will pay next month	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
503	21	864.00	June	2023	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
504	21	943.00	May	2023	PAID	\N	2025-04-18 18:55:32.843	2025-04-18 18:55:32.843
505	22	1114.00	April	2025	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
506	22	1003.00	March	2025	MISSED	Will pay next month	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
507	22	941.00	February	2025	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
508	22	911.00	January	2025	PENDING	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
509	22	901.00	December	2024	PENDING	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
510	22	1031.00	November	2024	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
511	22	1161.00	October	2024	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
512	22	947.00	September	2024	PAID	Payment confirmed	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
513	22	1029.00	August	2024	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
514	22	882.00	July	2024	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
515	22	1101.00	June	2024	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
516	22	903.00	May	2024	PENDING	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
517	22	969.00	April	2024	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
518	22	1184.00	March	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
519	22	924.00	February	2024	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
520	22	1047.00	January	2024	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
521	22	1137.00	December	2023	PAID	Additional contribution included	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
522	22	910.00	November	2023	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
523	22	829.00	October	2023	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
524	22	1144.00	September	2023	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
525	22	1110.00	August	2023	MISSED	Member requested extension	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
526	22	1180.00	July	2023	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
527	22	1067.00	June	2023	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
528	22	1053.00	May	2023	PAID	\N	2025-04-18 18:55:32.845	2025-04-18 18:55:32.845
529	23	1051.00	April	2025	PENDING	Additional contribution included	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
530	23	1050.00	March	2025	PENDING	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
531	23	1087.00	February	2025	PAID	Payment confirmed	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
532	23	968.00	January	2025	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
533	23	1045.00	December	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
534	23	1170.00	November	2024	PAID	Additional contribution included	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
535	23	1153.00	October	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
536	23	928.00	September	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
537	23	906.00	August	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
538	23	1199.00	July	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
539	23	937.00	June	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
540	23	897.00	May	2024	PENDING	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
541	23	1067.00	April	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
542	23	1111.00	March	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
543	23	1057.00	February	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
544	23	1071.00	January	2024	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
545	23	1057.00	December	2023	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
546	23	888.00	November	2023	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
547	23	1124.00	October	2023	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
548	23	1044.00	September	2023	PAID	Partial payment received	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
549	23	922.00	August	2023	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
550	23	1168.00	July	2023	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
551	23	1032.00	June	2023	PAID	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
552	23	1066.00	May	2023	PENDING	\N	2025-04-18 18:55:32.849	2025-04-18 18:55:32.849
553	24	1141.00	April	2025	PENDING	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
554	24	1001.00	March	2025	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
555	24	1099.00	February	2025	PENDING	Payment confirmed	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
556	24	991.00	January	2025	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
557	24	923.00	December	2024	MISSED	Member requested extension	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
558	24	917.00	November	2024	PENDING	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
559	24	889.00	October	2024	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
560	24	1168.00	September	2024	PAID	Partial payment received	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
561	24	965.00	August	2024	PAID	Payment scheduled	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
562	24	1041.00	July	2024	PAID	Additional contribution included	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
563	24	998.00	June	2024	PENDING	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
564	24	817.00	May	2024	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
565	24	1066.00	April	2024	PAID	Payment confirmed	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
566	24	930.00	March	2024	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
567	24	811.00	February	2024	PAID	Payment scheduled	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
568	24	901.00	January	2024	PAID	Payment scheduled	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
569	24	965.00	December	2023	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
570	24	1153.00	November	2023	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
571	24	952.00	October	2023	MISSED	Financial hardship reported	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
572	24	1056.00	September	2023	PAID	Payment scheduled	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
573	24	890.00	August	2023	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
574	24	1100.00	July	2023	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
575	24	1078.00	June	2023	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
576	24	975.00	May	2023	PAID	\N	2025-04-18 18:55:32.854	2025-04-18 18:55:32.854
577	25	1174.00	April	2025	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
578	25	890.00	March	2025	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
579	25	946.00	February	2025	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
580	25	857.00	January	2025	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
581	25	895.00	December	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
582	25	1024.00	November	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
583	25	1184.00	October	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
584	25	1141.00	September	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
585	25	874.00	August	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
586	25	1081.00	July	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
587	25	899.00	June	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
588	25	801.00	May	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
589	25	1050.00	April	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
590	25	1081.00	March	2024	PENDING	Payment scheduled	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
591	25	903.00	February	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
592	25	921.00	January	2024	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
593	25	1048.00	December	2023	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
594	25	862.00	November	2023	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
595	25	1103.00	October	2023	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
596	25	955.00	September	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
597	25	1143.00	August	2023	MISSED	Will pay next month	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
598	25	815.00	July	2023	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
599	25	1092.00	June	2023	PENDING	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
600	25	934.00	May	2023	PAID	\N	2025-04-18 18:55:32.858	2025-04-18 18:55:32.858
601	26	963.00	April	2025	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
602	26	1092.00	March	2025	PENDING	Payment confirmed	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
603	26	1070.00	February	2025	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
604	26	1069.00	January	2025	PENDING	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
605	26	896.00	December	2024	PENDING	Additional contribution included	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
606	26	1013.00	November	2024	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
607	26	1135.00	October	2024	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
608	26	988.00	September	2024	PENDING	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
610	26	1164.00	July	2024	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
611	26	876.00	June	2024	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
612	26	1145.00	May	2024	PAID	Partial payment received	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
613	26	828.00	April	2024	MISSED	Payment failed	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
614	26	1010.00	March	2024	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
615	26	991.00	February	2024	MISSED	Payment failed	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
616	26	1151.00	January	2024	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
617	26	1175.00	December	2023	MISSED	Payment failed	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
618	26	840.00	November	2023	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
619	26	1027.00	October	2023	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
620	26	909.00	September	2023	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
621	26	1055.00	August	2023	PAID	Additional contribution included	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
622	26	1194.00	July	2023	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
623	26	865.00	June	2023	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
624	26	1099.00	May	2023	PAID	\N	2025-04-18 18:55:32.861	2025-04-18 18:55:32.861
625	27	1156.00	April	2025	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
626	27	1103.00	March	2025	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
627	27	837.00	February	2025	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
628	27	1147.00	January	2025	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
629	27	828.00	December	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
630	27	904.00	November	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
631	27	1113.00	October	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
632	27	812.00	September	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
633	27	831.00	August	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
634	27	969.00	July	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
635	27	911.00	June	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
636	27	819.00	May	2024	PAID	Payment scheduled	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
637	27	1078.00	April	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
638	27	1197.00	March	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
639	27	957.00	February	2024	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
640	27	1131.00	January	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
641	27	1106.00	December	2023	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
642	27	1084.00	November	2023	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
643	27	905.00	October	2023	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
644	27	1150.00	September	2023	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
645	27	903.00	August	2023	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
646	27	1070.00	July	2023	PAID	Payment scheduled	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
647	27	925.00	June	2023	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
648	27	922.00	May	2023	PAID	\N	2025-04-18 18:55:32.864	2025-04-18 18:55:32.864
649	28	974.00	April	2025	PENDING	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
650	28	1159.00	March	2025	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
651	28	824.00	February	2025	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
652	28	949.00	January	2025	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
653	28	1048.00	December	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
654	28	906.00	November	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
655	28	1186.00	October	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
656	28	1051.00	September	2024	PAID	Payment scheduled	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
657	28	1150.00	August	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
658	28	817.00	July	2024	PAID	Partial payment received	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
659	28	871.00	June	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
660	28	1140.00	May	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
661	28	819.00	April	2024	MISSED	Will pay next month	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
662	28	1174.00	March	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
663	28	938.00	February	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
664	28	1144.00	January	2024	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
665	28	806.00	December	2023	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
666	28	901.00	November	2023	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
667	28	802.00	October	2023	MISSED	Will pay next month	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
668	28	1178.00	September	2023	PAID	Payment scheduled	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
669	28	1024.00	August	2023	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
670	28	1132.00	July	2023	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
671	28	979.00	June	2023	PENDING	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
672	28	954.00	May	2023	PAID	\N	2025-04-18 18:55:32.869	2025-04-18 18:55:32.869
697	30	927.00	April	2025	PENDING	Additional contribution included	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
698	30	1184.00	March	2025	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
699	30	935.00	February	2025	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
700	30	1009.00	January	2025	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
701	30	1121.00	December	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
702	30	806.00	November	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
703	30	1083.00	October	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
704	30	836.00	September	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
705	30	867.00	August	2024	PAID	Payment scheduled	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
706	30	962.00	July	2024	MISSED	Payment failed	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
707	30	924.00	June	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
708	30	1018.00	May	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
709	30	1184.00	April	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
710	30	988.00	March	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
711	30	843.00	February	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
712	30	1091.00	January	2024	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
713	30	1196.00	December	2023	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
714	30	890.00	November	2023	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
715	30	962.00	October	2023	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
716	30	1186.00	September	2023	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
717	30	1169.00	August	2023	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
718	30	1172.00	July	2023	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
719	30	1094.00	June	2023	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
720	30	899.00	May	2023	PAID	\N	2025-04-18 18:55:32.877	2025-04-18 18:55:32.877
721	31	1173.00	April	2025	PAID	Payment confirmed	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
722	31	1133.00	March	2025	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
723	31	1171.00	February	2025	PENDING	Partial payment received	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
724	31	1129.00	January	2025	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
725	31	1098.00	December	2024	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
726	31	816.00	November	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
727	31	803.00	October	2024	PAID	Payment scheduled	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
728	31	974.00	September	2024	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
729	31	1090.00	August	2024	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
730	31	1196.00	July	2024	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
731	31	831.00	June	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
732	31	890.00	May	2024	MISSED	Will pay next month	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
733	31	1017.00	April	2024	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
734	31	953.00	March	2024	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
735	31	1062.00	February	2024	MISSED	Payment failed	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
736	31	976.00	January	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
737	31	905.00	December	2023	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
738	31	813.00	November	2023	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
739	31	1113.00	October	2023	PENDING	Payment confirmed	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
740	31	954.00	September	2023	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
741	31	1086.00	August	2023	PENDING	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
742	31	871.00	July	2023	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
743	31	853.00	June	2023	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
744	31	1043.00	May	2023	PAID	\N	2025-04-18 18:55:32.881	2025-04-18 18:55:32.881
745	32	984.00	April	2025	PENDING	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
746	32	821.00	March	2025	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
747	32	1114.00	February	2025	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
748	32	975.00	January	2025	PENDING	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
749	32	1058.00	December	2024	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
750	32	1040.00	November	2024	PENDING	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
751	32	1181.00	October	2024	PENDING	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
752	32	1175.00	September	2024	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
753	32	994.00	August	2024	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
754	32	913.00	July	2024	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
755	32	1026.00	June	2024	PENDING	Partial payment received	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
756	32	951.00	May	2024	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
757	32	950.00	April	2024	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
758	32	1173.00	March	2024	PAID	Payment confirmed	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
759	32	939.00	February	2024	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
760	32	1171.00	January	2024	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
761	32	880.00	December	2023	MISSED	Payment failed	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
762	32	886.00	November	2023	PAID	Partial payment received	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
763	32	800.00	October	2023	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
764	32	959.00	September	2023	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
765	32	1055.00	August	2023	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
766	32	876.00	July	2023	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
767	32	1109.00	June	2023	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
768	32	926.00	May	2023	PAID	\N	2025-04-18 18:55:32.886	2025-04-18 18:55:32.886
769	33	884.00	April	2025	PENDING	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
770	33	1093.00	March	2025	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
771	33	1051.00	February	2025	PAID	Additional contribution included	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
772	33	969.00	January	2025	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
773	33	880.00	December	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
774	33	828.00	November	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
775	33	1095.00	October	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
776	33	1159.00	September	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
777	33	929.00	August	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
778	33	1184.00	July	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
779	33	923.00	June	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
780	33	1112.00	May	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
781	33	1049.00	April	2024	PENDING	Payment confirmed	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
782	33	818.00	March	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
783	33	1099.00	February	2024	PENDING	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
784	33	982.00	January	2024	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
785	33	957.00	December	2023	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
786	33	1056.00	November	2023	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
787	33	1012.00	October	2023	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
788	33	919.00	September	2023	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
789	33	851.00	August	2023	PAID	Additional contribution included	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
790	33	966.00	July	2023	MISSED	Financial hardship reported	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
791	33	1091.00	June	2023	MISSED	Member requested extension	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
792	33	838.00	May	2023	PAID	\N	2025-04-18 18:55:32.89	2025-04-18 18:55:32.89
793	34	1120.00	April	2025	PENDING	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
794	34	945.00	March	2025	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
795	34	1014.00	February	2025	PAID	Partial payment received	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
796	34	897.00	January	2025	PENDING	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
797	34	1057.00	December	2024	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
798	34	893.00	November	2024	PAID	Additional contribution included	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
799	34	1196.00	October	2024	PAID	Additional contribution included	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
800	34	1000.00	September	2024	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
801	34	1001.00	August	2024	PAID	Payment confirmed	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
802	34	1119.00	July	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
803	34	954.00	June	2024	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
804	34	1118.00	May	2024	PAID	Payment confirmed	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
805	34	980.00	April	2024	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
806	34	1138.00	March	2024	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
807	34	1195.00	February	2024	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
808	34	1093.00	January	2024	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
809	34	959.00	December	2023	PAID	Additional contribution included	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
810	34	938.00	November	2023	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
811	34	1068.00	October	2023	MISSED	Member requested extension	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
812	34	814.00	September	2023	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
813	34	1063.00	August	2023	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
814	34	924.00	July	2023	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
815	34	800.00	June	2023	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
816	34	988.00	May	2023	PAID	\N	2025-04-18 18:55:32.895	2025-04-18 18:55:32.895
817	35	1117.00	April	2025	PENDING	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
818	35	1057.00	March	2025	MISSED	Payment failed	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
819	35	806.00	February	2025	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
820	35	976.00	January	2025	PAID	Partial payment received	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
821	35	1078.00	December	2024	PENDING	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
822	35	1086.00	November	2024	PAID	Payment confirmed	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
823	35	1191.00	October	2024	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
915	39	961.00	February	2025	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
824	35	1119.00	September	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
825	35	815.00	August	2024	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
826	35	1143.00	July	2024	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
827	35	1085.00	June	2024	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
828	35	810.00	May	2024	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
829	35	825.00	April	2024	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
830	35	1102.00	March	2024	MISSED	Member on leave	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
831	35	1003.00	February	2024	PAID	Additional contribution included	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
832	35	1171.00	January	2024	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
833	35	976.00	December	2023	MISSED	Member requested extension	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
834	35	1023.00	November	2023	PAID	Partial payment received	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
835	35	1061.00	October	2023	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
836	35	890.00	September	2023	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
837	35	1013.00	August	2023	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
838	35	845.00	July	2023	PAID	\N	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
839	35	845.00	June	2023	MISSED	Will pay next month	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
840	35	900.00	May	2023	PAID	Payment scheduled	2025-04-18 18:55:32.899	2025-04-18 18:55:32.899
841	36	1181.00	April	2025	PENDING	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
842	36	1166.00	March	2025	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
843	36	975.00	February	2025	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
844	36	908.00	January	2025	PAID	Payment scheduled	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
845	36	982.00	December	2024	PAID	Additional contribution included	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
846	36	1095.00	November	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
847	36	921.00	October	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
848	36	1176.00	September	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
849	36	939.00	August	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
850	36	1125.00	July	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
851	36	1097.00	June	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
852	36	978.00	May	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
853	36	869.00	April	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
854	36	971.00	March	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
855	36	1020.00	February	2024	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
856	36	963.00	January	2024	MISSED	Payment failed	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
857	36	939.00	December	2023	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
858	36	883.00	November	2023	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
859	36	1024.00	October	2023	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
860	36	898.00	September	2023	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
861	36	1097.00	August	2023	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
862	36	941.00	July	2023	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
863	36	1130.00	June	2023	PAID	\N	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
864	36	1145.00	May	2023	PAID	Payment scheduled	2025-04-18 18:55:32.903	2025-04-18 18:55:32.903
865	37	1152.00	April	2025	PENDING	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
866	37	1101.00	March	2025	PENDING	Additional contribution included	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
867	37	1020.00	February	2025	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
868	37	909.00	January	2025	PENDING	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
869	37	1120.00	December	2024	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
870	37	1134.00	November	2024	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
871	37	873.00	October	2024	MISSED	Member requested extension	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
872	37	892.00	September	2024	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
873	37	1100.00	August	2024	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
874	37	1151.00	July	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
875	37	912.00	June	2024	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
876	37	858.00	May	2024	MISSED	Member on leave	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
877	37	880.00	April	2024	PENDING	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
878	37	1005.00	March	2024	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
879	37	1019.00	February	2024	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
880	37	866.00	January	2024	MISSED	Payment failed	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
881	37	959.00	December	2023	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
882	37	899.00	November	2023	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
883	37	916.00	October	2023	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
884	37	910.00	September	2023	MISSED	Member requested extension	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
885	37	1137.00	August	2023	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
886	37	893.00	July	2023	PENDING	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
887	37	1109.00	June	2023	PAID	\N	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
888	37	908.00	May	2023	PAID	Additional contribution included	2025-04-18 18:55:32.919	2025-04-18 18:55:32.919
889	38	936.00	April	2025	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
890	38	1149.00	March	2025	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
891	38	889.00	February	2025	PENDING	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
892	38	1174.00	January	2025	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
893	38	811.00	December	2024	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
894	38	996.00	November	2024	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
895	38	1122.00	October	2024	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
896	38	842.00	September	2024	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
897	38	1017.00	August	2024	PAID	Payment confirmed	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
898	38	915.00	July	2024	MISSED	Member requested extension	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
899	38	842.00	June	2024	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
900	38	842.00	May	2024	PAID	Partial payment received	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
901	38	896.00	April	2024	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
902	38	1029.00	March	2024	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
903	38	969.00	February	2024	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
904	38	1105.00	January	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
905	38	902.00	December	2023	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
906	38	830.00	November	2023	PAID	Payment scheduled	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
907	38	1179.00	October	2023	PAID	Partial payment received	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
908	38	946.00	September	2023	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
909	38	998.00	August	2023	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
910	38	915.00	July	2023	MISSED	Financial hardship reported	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
911	38	851.00	June	2023	PAID	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
912	38	1168.00	May	2023	PENDING	\N	2025-04-18 18:55:32.922	2025-04-18 18:55:32.922
913	39	1090.00	April	2025	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
914	39	934.00	March	2025	MISSED	Financial hardship reported	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
916	39	838.00	January	2025	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
917	39	1065.00	December	2024	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
918	39	1062.00	November	2024	PAID	Additional contribution included	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
919	39	1153.00	October	2024	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
920	39	807.00	September	2024	MISSED	Payment failed	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
921	39	1117.00	August	2024	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
922	39	1142.00	July	2024	PAID	Payment scheduled	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
923	39	945.00	June	2024	PAID	Partial payment received	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
924	39	912.00	May	2024	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
925	39	1191.00	April	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
926	39	980.00	March	2024	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
927	39	1126.00	February	2024	PAID	Payment confirmed	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
928	39	1026.00	January	2024	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
929	39	902.00	December	2023	PENDING	Payment confirmed	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
930	39	1149.00	November	2023	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
931	39	1133.00	October	2023	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
932	39	808.00	September	2023	MISSED	Member requested extension	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
933	39	1126.00	August	2023	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
934	39	1116.00	July	2023	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
935	39	824.00	June	2023	PENDING	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
936	39	1049.00	May	2023	PAID	\N	2025-04-18 18:55:32.926	2025-04-18 18:55:32.926
961	41	861.00	April	2025	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
962	41	837.00	March	2025	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
963	41	957.00	February	2025	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
964	41	877.00	January	2025	MISSED	Member requested extension	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
965	41	811.00	December	2024	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
966	41	992.00	November	2024	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
967	41	1027.00	October	2024	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
968	41	975.00	September	2024	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
969	41	1114.00	August	2024	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
970	41	1004.00	July	2024	PAID	Additional contribution included	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
971	41	1168.00	June	2024	PAID	Partial payment received	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
972	41	996.00	May	2024	PENDING	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
973	41	1108.00	April	2024	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
974	41	990.00	March	2024	PAID	Partial payment received	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
975	41	821.00	February	2024	PAID	Payment scheduled	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
976	41	1060.00	January	2024	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
977	41	985.00	December	2023	PAID	Additional contribution included	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
978	41	862.00	November	2023	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
979	41	897.00	October	2023	PAID	Payment scheduled	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
980	41	1050.00	September	2023	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
981	41	870.00	August	2023	PAID	Payment scheduled	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
982	41	1144.00	July	2023	MISSED	Member on leave	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
983	41	908.00	June	2023	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
984	41	1020.00	May	2023	PAID	\N	2025-04-18 18:55:32.932	2025-04-18 18:55:32.932
985	42	815.00	April	2025	PENDING	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
986	42	900.00	March	2025	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
987	42	1066.00	February	2025	MISSED	Member requested extension	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
988	42	849.00	January	2025	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
989	42	996.00	December	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
990	42	1023.00	November	2024	PAID	Payment confirmed	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
991	42	982.00	October	2024	PAID	Payment confirmed	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
992	42	1011.00	September	2024	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
993	42	1186.00	August	2024	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
994	42	923.00	July	2024	PAID	Partial payment received	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
995	42	937.00	June	2024	PAID	Payment confirmed	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
996	42	998.00	May	2024	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
997	42	842.00	April	2024	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
998	42	850.00	March	2024	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
999	42	869.00	February	2024	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1000	42	1119.00	January	2024	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1001	42	914.00	December	2023	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1002	42	929.00	November	2023	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1003	42	1024.00	October	2023	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1004	42	1006.00	September	2023	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1005	42	1077.00	August	2023	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1006	42	910.00	July	2023	PAID	Partial payment received	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1007	42	1059.00	June	2023	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1008	42	817.00	May	2023	PAID	\N	2025-04-18 18:55:32.935	2025-04-18 18:55:32.935
1009	43	998.00	April	2025	PENDING	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1010	43	880.00	March	2025	PENDING	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1011	43	1097.00	February	2025	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1012	43	1031.00	January	2025	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1013	43	831.00	December	2024	PAID	Partial payment received	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1014	43	1153.00	November	2024	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1015	43	1006.00	October	2024	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1016	43	898.00	September	2024	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1017	43	1061.00	August	2024	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1018	43	804.00	July	2024	PAID	Partial payment received	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1019	43	1118.00	June	2024	PENDING	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1020	43	914.00	May	2024	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1021	43	1143.00	April	2024	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1022	43	923.00	March	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1023	43	901.00	February	2024	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1024	43	1034.00	January	2024	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1025	43	1139.00	December	2023	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1026	43	837.00	November	2023	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1027	43	948.00	October	2023	MISSED	Will pay next month	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1028	43	861.00	September	2023	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1029	43	1033.00	August	2023	MISSED	Financial hardship reported	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1030	43	970.00	July	2023	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1031	43	988.00	June	2023	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1032	43	1141.00	May	2023	PAID	\N	2025-04-18 18:55:32.938	2025-04-18 18:55:32.938
1033	44	1044.00	April	2025	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1034	44	914.00	March	2025	PENDING	Partial payment received	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1035	44	997.00	February	2025	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1036	44	1090.00	January	2025	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1037	44	900.00	December	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1038	44	1134.00	November	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1039	44	846.00	October	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1040	44	1144.00	September	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1041	44	1140.00	August	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1042	44	1196.00	July	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1043	44	1133.00	June	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1044	44	947.00	May	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1045	44	957.00	April	2024	PAID	Payment confirmed	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1046	44	867.00	March	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1047	44	1124.00	February	2024	PAID	Payment scheduled	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1048	44	1187.00	January	2024	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1049	44	883.00	December	2023	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1050	44	1078.00	November	2023	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1051	44	1162.00	October	2023	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1052	44	876.00	September	2023	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1053	44	1193.00	August	2023	MISSED	Financial hardship reported	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1054	44	1182.00	July	2023	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1055	44	1138.00	June	2023	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1056	44	1141.00	May	2023	PAID	\N	2025-04-18 18:55:32.942	2025-04-18 18:55:32.942
1057	45	832.00	April	2025	PENDING	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1058	45	1087.00	March	2025	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1059	45	938.00	February	2025	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1060	45	876.00	January	2025	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1061	45	1077.00	December	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1062	45	837.00	November	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1063	45	1167.00	October	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1064	45	962.00	September	2024	MISSED	Will pay next month	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1065	45	809.00	August	2024	PAID	Additional contribution included	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1066	45	1017.00	July	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1067	45	911.00	June	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1068	45	917.00	May	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1069	45	1185.00	April	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1070	45	1178.00	March	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1071	45	1000.00	February	2024	PAID	Payment confirmed	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1072	45	954.00	January	2024	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1073	45	829.00	December	2023	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1074	45	981.00	November	2023	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1075	45	984.00	October	2023	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1076	45	1023.00	September	2023	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1077	45	805.00	August	2023	PAID	\N	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1078	45	957.00	July	2023	PAID	Partial payment received	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1079	45	1182.00	June	2023	PAID	Payment confirmed	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1080	45	964.00	May	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.945	2025-04-18 18:55:32.945
1081	46	1200.00	April	2025	PENDING	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1082	46	1015.00	March	2025	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1083	46	1058.00	February	2025	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1084	46	1038.00	January	2025	PAID	Partial payment received	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1085	46	970.00	December	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1086	46	1090.00	November	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1087	46	866.00	October	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1088	46	969.00	September	2024	PAID	Payment confirmed	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1089	46	1195.00	August	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1090	46	1084.00	July	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1091	46	960.00	June	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1092	46	960.00	May	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1093	46	1143.00	April	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1094	46	1088.00	March	2024	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1095	46	1037.00	February	2024	PAID	Additional contribution included	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1096	46	858.00	January	2024	MISSED	Will pay next month	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1097	46	1160.00	December	2023	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1098	46	969.00	November	2023	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1099	46	810.00	October	2023	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1100	46	1166.00	September	2023	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1101	46	872.00	August	2023	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1102	46	962.00	July	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1103	46	1130.00	June	2023	PAID	\N	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1104	46	878.00	May	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.953	2025-04-18 18:55:32.953
1105	47	986.00	April	2025	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1106	47	860.00	March	2025	MISSED	Member requested extension	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1107	47	878.00	February	2025	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1108	47	831.00	January	2025	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1109	47	1146.00	December	2024	PAID	Additional contribution included	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1110	47	971.00	November	2024	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1111	47	812.00	October	2024	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1112	47	1174.00	September	2024	PAID	Partial payment received	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1113	47	1157.00	August	2024	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1114	47	1093.00	July	2024	PENDING	Paid via bank transfer	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1115	47	1103.00	June	2024	PAID	Additional contribution included	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1116	47	986.00	May	2024	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1117	47	957.00	April	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1118	47	1116.00	March	2024	MISSED	Member requested extension	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1119	47	1032.00	February	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1120	47	916.00	January	2024	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1121	47	960.00	December	2023	PAID	Additional contribution included	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1122	47	1130.00	November	2023	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1123	47	933.00	October	2023	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1124	47	923.00	September	2023	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1125	47	1108.00	August	2023	PENDING	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1126	47	921.00	July	2023	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1127	47	1131.00	June	2023	PAID	\N	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1128	47	883.00	May	2023	PENDING	Paid via bank transfer	2025-04-18 18:55:32.958	2025-04-18 18:55:32.958
1129	48	993.00	April	2025	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1130	48	925.00	March	2025	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1131	48	801.00	February	2025	PENDING	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1132	48	945.00	January	2025	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1133	48	947.00	December	2024	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1134	48	909.00	November	2024	PAID	Payment scheduled	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1135	48	821.00	October	2024	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1136	48	1157.00	September	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1137	48	995.00	August	2024	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1138	48	994.00	July	2024	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1139	48	956.00	June	2024	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1140	48	1066.00	May	2024	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1141	48	957.00	April	2024	PAID	Payment scheduled	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1142	48	907.00	March	2024	PENDING	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1143	48	974.00	February	2024	PAID	Partial payment received	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1144	48	953.00	January	2024	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1145	48	929.00	December	2023	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1146	48	994.00	November	2023	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1147	48	1051.00	October	2023	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1148	48	1176.00	September	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1149	48	884.00	August	2023	PAID	Additional contribution included	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1150	48	1144.00	July	2023	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1151	48	1087.00	June	2023	PENDING	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1152	48	1082.00	May	2023	PAID	\N	2025-04-18 18:55:32.962	2025-04-18 18:55:32.962
1153	49	1139.00	April	2025	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1154	49	1187.00	March	2025	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1155	49	813.00	February	2025	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1156	49	939.00	January	2025	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1157	49	1191.00	December	2024	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1158	49	1011.00	November	2024	PENDING	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1159	49	853.00	October	2024	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1160	49	1169.00	September	2024	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1161	49	1183.00	August	2024	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1162	49	898.00	July	2024	PAID	Payment confirmed	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1163	49	886.00	June	2024	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1164	49	853.00	May	2024	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1165	49	1076.00	April	2024	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1166	49	1002.00	March	2024	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1167	49	821.00	February	2024	PAID	Partial payment received	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1168	49	914.00	January	2024	MISSED	Member requested extension	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1169	49	1148.00	December	2023	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1170	49	993.00	November	2023	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1171	49	810.00	October	2023	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1172	49	1133.00	September	2023	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1173	49	969.00	August	2023	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1174	49	1041.00	July	2023	MISSED	Payment failed	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1175	49	1129.00	June	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1176	49	967.00	May	2023	PAID	\N	2025-04-18 18:55:32.97	2025-04-18 18:55:32.97
1177	50	988.00	April	2025	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1178	50	1080.00	March	2025	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1179	50	1174.00	February	2025	PAID	Payment confirmed	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1180	50	1151.00	January	2025	PAID	Additional contribution included	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1181	50	1096.00	December	2024	PAID	Payment confirmed	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1182	50	871.00	November	2024	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1183	50	950.00	October	2024	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1184	50	987.00	September	2024	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1185	50	947.00	August	2024	PAID	Payment scheduled	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1186	50	947.00	July	2024	PAID	Payment scheduled	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1187	50	1038.00	June	2024	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1188	50	926.00	May	2024	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1189	50	1030.00	April	2024	PENDING	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1190	50	1081.00	March	2024	PAID	Payment scheduled	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1191	50	942.00	February	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1192	50	1145.00	January	2024	PAID	Paid via bank transfer	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1193	50	971.00	December	2023	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1194	50	962.00	November	2023	PAID	Additional contribution included	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1195	50	803.00	October	2023	PAID	Payment confirmed	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1196	50	1106.00	September	2023	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1197	50	999.00	August	2023	PAID	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1198	50	1126.00	July	2023	PENDING	\N	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1199	50	815.00	June	2023	PAID	Partial payment received	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1200	50	838.00	May	2023	MISSED	Member on leave	2025-04-18 18:55:32.973	2025-04-18 18:55:32.973
1201	51	810.00	April	2025	PENDING	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1202	51	1004.00	March	2025	PAID	Partial payment received	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1203	51	1019.00	February	2025	PENDING	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1204	51	1035.00	January	2025	PAID	Payment confirmed	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1205	51	843.00	December	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1206	51	961.00	November	2024	MISSED	Financial hardship reported	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1207	51	1058.00	October	2024	PAID	Payment confirmed	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1208	51	1192.00	September	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1209	51	807.00	August	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1210	51	1176.00	July	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1211	51	996.00	June	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1212	51	1107.00	May	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1213	51	1010.00	April	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1214	51	1089.00	March	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1215	51	1010.00	February	2024	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1216	51	938.00	January	2024	MISSED	Member on leave	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1217	51	841.00	December	2023	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1218	51	1160.00	November	2023	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1219	51	1052.00	October	2023	MISSED	Member requested extension	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1220	51	963.00	September	2023	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1221	51	1177.00	August	2023	MISSED	Member requested extension	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1222	51	1125.00	July	2023	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1223	51	935.00	June	2023	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1224	51	829.00	May	2023	PAID	\N	2025-04-18 18:55:32.977	2025-04-18 18:55:32.977
1225	52	1170.00	April	2025	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1226	52	933.00	March	2025	MISSED	Financial hardship reported	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1227	52	1006.00	February	2025	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1228	52	805.00	January	2025	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1229	52	994.00	December	2024	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1230	52	837.00	November	2024	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1231	52	966.00	October	2024	PAID	Additional contribution included	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1232	52	997.00	September	2024	MISSED	Member on leave	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1233	52	1046.00	August	2024	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1234	52	896.00	July	2024	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1235	52	893.00	June	2024	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1236	52	882.00	May	2024	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1237	52	1159.00	April	2024	MISSED	Member on leave	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1238	52	829.00	March	2024	PAID	Payment scheduled	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1239	52	1104.00	February	2024	MISSED	Member on leave	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1240	52	854.00	January	2024	PAID	Additional contribution included	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1241	52	1195.00	December	2023	PAID	Partial payment received	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1242	52	1117.00	November	2023	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1243	52	879.00	October	2023	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1244	52	1136.00	September	2023	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1245	52	1065.00	August	2023	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1246	52	1140.00	July	2023	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1247	52	1109.00	June	2023	PAID	\N	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1248	52	827.00	May	2023	MISSED	Member on leave	2025-04-18 18:55:32.98	2025-04-18 18:55:32.98
1249	53	823.00	April	2025	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1250	53	874.00	March	2025	PENDING	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1251	53	1014.00	February	2025	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1252	53	1051.00	January	2025	MISSED	Payment failed	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1253	53	942.00	December	2024	PAID	Partial payment received	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1254	53	1197.00	November	2024	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1255	53	1029.00	October	2024	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1256	53	1018.00	September	2024	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1257	53	1056.00	August	2024	MISSED	Payment failed	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1258	53	1093.00	July	2024	PAID	Payment scheduled	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1259	53	966.00	June	2024	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1260	53	1158.00	May	2024	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1261	53	1149.00	April	2024	MISSED	Payment failed	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1262	53	1013.00	March	2024	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1263	53	1136.00	February	2024	PAID	Partial payment received	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1264	53	1152.00	January	2024	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1265	53	851.00	December	2023	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1266	53	1131.00	November	2023	PAID	Paid via bank transfer	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1267	53	993.00	October	2023	PENDING	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1268	53	824.00	September	2023	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1269	53	1183.00	August	2023	PAID	Additional contribution included	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1270	53	1085.00	July	2023	PAID	Partial payment received	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1271	53	911.00	June	2023	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1272	53	1189.00	May	2023	PAID	\N	2025-04-18 18:55:32.987	2025-04-18 18:55:32.987
1273	14	3500.00	March	2025	PAID	\N	2025-04-19 06:53:40.832	2025-04-19 06:53:40.832
\.


--
-- Data for Name: Inquiry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Inquiry" (id, name, email, subject, message, created_at, updated_at) FROM stdin;
1	Marta Haag	Ivory_Ritchie@hotmail.com	Technical issue with submission	I have some feedback about the current system:\n\nClibanus super ara decor debitis laboriosam. Delectus correptius blanditiis enim spiritus auxilium ullam universe solio vorago. Tergo aestivus aspicio tero ago tripudio earum ancilla turpis.\nVos verbum animadverto coaegresco unus. Consuasor vae tamisium amoveo commemoro. Vicinus cras condico infit sulum stabilis terror approbo textilis.\n\nPositive aspects:\n1. Harum uxor expedita voluptate casso comes cuppedia.\n2. Tabgo cenaculum vado aliquid auditor theca usitas consuasor abundans cunabula.\n3. Comptus correptius vae.\n\nAreas for improvement:\n1. Deorsum vicissitudo audio varietas vae.\n2. Cohibeo depopulo ab alias appello cito conscendo sub vix vitium.\n3. Terreo adaugeo comedo comitatus suadeo bardus tertius velut terreo.\n\nDetailed suggestions:\nPauper reiciendis caritas. Sustineo praesentium cenaculum molestias verbera dedico cruciamentum cito viduo defessus. Ullus volup fugit vulariter aequitas crebro quam subiungo ara.\nTheca celer concido. Modi accusator cognatus amicitia suppellex corpus. Suppellex ex quo sponte.	2025-04-18 18:55:32.989	2025-04-18 18:55:32.989
2	Bryant Tromp	Yoshiko_Gulgowski38@yahoo.com	Question about contribution scope	Angulus corrumpo cursim comptus amplexus vix derelinquo brevis conventus barba. Defetiscor tumultus harum demoror subito adeptio corporis bos vapulus. Cibo thorax deputo ver.\nApprobo verbum claro non angulus astrum ulterius textus. Tabella cubitum adnuo. Beatae vitiosus degusto repellat amplitudo tergiversatio adulescens.\nCunae animus adipisci varietas triumphus. Audentia tergiversatio cunae aduro damnatio cernuus. Socius vivo conor caecus caute vitae.\n\nCurrus capto bos accusantium voluntarius studio. Concido voluptatum conventus audeo tepidus ullam vel. Suspendo speculum comedo hic thesaurus tabesco libero arbor vomica decet.\nTempus conscendo vallum caterva sulum coerceo audacia. Succedo conqueror desparatus. Vinco ventito collum triumphus ubi vinco speculum virgo bellum crudelis.\n\nDenuncio sono administratio defero. Thorax quibusdam virtus consectetur carpo aegre accusantium teneo. Coniecto vobis cado sol ars combibo reiciendis.\nTergo apparatus defessus adeo. Crux usque crux terreo defaeco suppellex. Decerno comptus crux conqueror.	2025-04-18 18:55:32.994	2025-04-18 18:55:32.994
3	Randall Carter	Name69@hotmail.com	Question about contribution rewards	I would like to suggest the following feature:\n\nTardus calcar tutamen. Vado vel tergiversatio credo. Defetiscor super antiquus caelestis defluo debeo supplanto ago urbanus cibus.\nSumo solium terminatio aequitas laudantium tempore trepide vicissitudo suadeo suggero. Vinitor turpis theologus utique video coniecto trans confugo quibusdam. Crur aduro conscendo stultus demulceo stips.\n\nBenefits:\n1. Tunc sub ratione vesica sophismata.\n2. Curriculum caecus quis colo.\n3. Assumenda cura demulceo trepide casus truculenter utilis volup complectus.\n\nImplementation considerations:\nCausa cohaero laborum comprehendo arbor neque comes armarium venustas votum. Ver titulus aegre. Vilis tepesco suppellex solum tamen officiis demoror tergiversatio.\nThalassinus ademptio verbum sui ustulo strenuus victoria debitis delectus. Collum nisi inflammatio eum. Tandem solitudo adhuc bis.	2025-04-18 18:55:32.995	2025-04-18 18:55:32.995
4	Scott Ondricka	Ralph_Bruen@gmail.com	Request for contribution mentorship	I have some feedback about the current system:\n\nDeserunt tonsor argentum caelum spiritus substantia odio adhuc cetera tertius. Vacuus autus curia. Saepe spiritus careo taceo sunt.\nAbbas terga tantillus bos eveniet vereor cultura cuius tam sopor. Vir inventore aliquid amicitia praesentium solium desipio. Stips aedificium ullam amet.\n\nPositive aspects:\n1. Temperantia curto tabesco voco.\n2. Verto iure natus tenuis patruus odit commodo.\n3. Cunctatio despecto velum charisma adicio saepe sponte auctus.\n\nAreas for improvement:\n1. Amplus amitto vulpes.\n2. Accusator acerbitas sit sordeo volaticus aurum officiis tactus benigne cado.\n3. Solus attonbitus libero.\n\nDetailed suggestions:\nSuggero cogo aufero temptatio molestias denuncio claustrum triumphus peior creator. Delicate aspicio odio tabernus congregatio sono comminor adaugeo. Charisma suffragium vorago aequitas casso vorax bellum cohibeo.\nTotidem impedit decretum succedo modi consectetur. Suscipio aureus trepide speciosus aegre corpus amitto. Velum contabesco damno alter textor vis sulum caterva cui copia.	2025-04-18 18:55:32.995	2025-04-18 18:55:32.995
5	Sharon Cormier	Dean26@gmail.com	Question about contribution process	I need clarification about the following process:\n\nAssentator cohibeo trans carus. Despecto crux nemo voluptate nostrum tempus curtus adversus. Angulus absum animus utor teneo cito.\nVolva atavus benigne apud suffragium creo dicta accusator. Speculum testimonium unus appositus corrigo saepe tepesco tubineus. Crux thorax coma traho solitudo cernuus bis ea amplexus adamo.\n\nCurrent understanding:\nTametsi alo terebro tantillus conor ipsum denuo candidus cibo deprimo. Tenetur at argumentum verumtamen viduo. Theologus stipes congregatio.\n\nQuestions:\n1. Dolorem temeritas tergeo caelum sublime tamisium acidus creta amitto.\n2. Verto spiritus usus velociter deinde ratione.\n3. Tondeo verus calcar.\n\nAdditional context:\nConiecto volubilis aptus asperiores cuius cruciamentum casso atrocitas aggredior denuncio. Canis cupio tergeo synagoga vapulus volup cuppedia denuo aufero adhaero. Defleo demonstro pel aggredior defero decretum curtus tepidus demonstro.\nContigo odio adficio. Fugit summa voluntarius demulceo abduco umbra tabernus. Viduo cotidie clam sperno sophismata summa asporto similique.	2025-04-18 18:55:32.996	2025-04-18 18:55:32.996
6	Gregg Hackett	Felicita88@gmail.com	Technical issue with submission	Careo dens coma attonbitus arto. Cuius alias curia quo hic ea crudelis sumptus vociferor vitae. Tenetur hic chirographum antea auxilium cruciamentum votum angelus adimpleo quia.\nCaterva aestivus aeger tubineus demo somniculosus. Tumultus cernuus animus contigo. Defungo decerno vomer tamisium statua in.\nVeritatis exercitationem pecto constans officiis. Decerno vulnus dolor reiciendis ullam atrox. Contra aufero cubitum nostrum antepono aeger.\n\nAdinventitias confugo argentum accommodo vae torrens. Thymbra acceptus ancilla abscido est amitto collum attero sequi. Damno cena altus.\nSubnecto claustrum dens earum acervus stips animadverto adhaero defendo. Iste pax bene conventus sollicito cena triumphus vicinus. Ter addo ipsam.\n\nAurum derelinquo ustulo. Adeo tempora traho concedo commodi causa velociter. Caries summa vilitas.\nUlterius sublime vigilo socius spoliatio uterque alias attero vespillo. Contra vilis cogito spectaculum unus incidunt sed adaugeo. Audacia cuppedia commemoro summa subseco.	2025-04-18 18:55:32.996	2025-04-18 18:55:32.996
7	Candice Robel	Athena_Konopelski@yahoo.com	Question about contribution process	I have some questions about the documentation:\n\nVolup repellat caelestis tenuis voro thorax. Cursus tenax illum denuncio contigo comminor strenuus addo. Utrum tantum denuncio.\nStrues demulceo exercitationem. Dens officiis creta. Comptus textus deorsum delinquo utilis crapula.\n\nSpecific areas of confusion:\n1. Tricesimus conculco cibus admoveo ratione crapula apparatus confido.\n2. Stultus sit auxilium dignissimos veritas ventito explicabo.\n3. Aggredior aetas ad quo uxor veritatis teres tepidus iste odit.\n\nSuggested improvements:\nAcquiro cena spero terra cibus alius deprecator villa caute. Video antea crustulum accendo attonbitus textor demo calamitas veritas uterque. Vorax suppellex admiratio audentia teres crur trepide.\nConfugo temptatio triumphus repellendus thalassinus adstringo tergo vitiosus. Earum consectetur varius nisi ullam. Timidus cuppedia peccatus bellicus coaegresco enim adnuo ago vacuus.	2025-04-18 18:55:32.997	2025-04-18 18:55:32.997
8	John McClure IV	Brant_Champlin50@hotmail.com	Question about contribution process	I'm trying to integrate with your system:\n\nCuriositas calamitas ulterius turba. Earum vesica a usque. Eos consequatur adiuvo.\nSopor antiquus administratio viduo iure cavus desino neque. Tribuo caelestis demulceo arbitro velociter. Accusantium armarium facere arma tertius laborum.\n\nIntegration requirements:\n1. Denuncio acceptus damno ipsum annus degusto utrum cito ulciscor.\n2. Comis curatio vulgus.\n3. Ulciscor sollers minima velut coniecto defluo amicitia ex capto amitto.\n\nCurrent implementation:\nTestimonium ascisco torrens turpis ab suscipio tam crustulum subiungo. Vestrum amplitudo vomer uberrime bis aegrus. Alias aer ait vulnero tonsor dolorum iusto timor patrocinor bonus.\nVesco tego pecco dolor cibo amissio avarus vicinus conforto. Tripudio delectus vallum quam stips patria abscido curo. Pax viduo apparatus.\n\nIssues encountered:\nCatena alienus terebro alter viriliter callide. Argentum complectus tollo amor. Possimus similique deinde vae pariatur peior asper talis viridis.\nCalculus totam appello amicitia vis adulatio vomer ubi accendo calamitas. Annus uxor carmen facere rem terebro. Laudantium caries decretum cilicium cupio angelus capio enim vae.	2025-04-18 18:55:32.998	2025-04-18 18:55:32.998
9	Lynette Schuster	Damon95@yahoo.com	Question about contribution process	I'm encountering technical difficulties:\n\nSubvenio nostrum aggredior ducimus sollicito pariatur vomica. Contigo titulus crepusculum alias magnam aestus curto appello voveo. Viscus bibo tenuis cado delectus.\nThema alioqui toties candidus veniam. Uredo audio basium vir solvo coadunatio. A subito volubilis credo verumtamen vestigium cervus.\n\nEnvironment details:\n- OS: Linux\n- Browser: Safari\n- Version: 8.20.16\n\nError message:\nVociferor utique fugiat repellendus antiquus. Vita suadeo sunt aestas delicate vulgaris ustilo. Illo atrox deludo curiositas curvo magnam audacia substantia cunctatio bestia.\n\nSteps taken:\n1. Congregatio alii aperte spero ademptio sub eaque casso tero.\n2. Absens sui cubo.\n3. Arbor amplus subvenio comitatus adaugeo vitae.\n\nAdditional information:\nReiciendis pauci tamdiu angelus tum eos. Absum vindico vulgaris careo stipes abbas tenuis abstergo. Cognomen cumque cernuus calco facilis tolero aranea sequi suggero vulgivagus.\nUlterius tergum cunabula alveus vix totam cohors conor. Textor totam pecto viriliter patria vomica ipsum degero. Aequitas vobis adsum vado adsuesco.	2025-04-18 18:55:33.001	2025-04-18 18:55:33.001
10	Greg Wiza I	Krystal1@hotmail.com	Technical issue with contribution editor	I would like to suggest the following feature:\n\nTextor stips coniecto dolore decet creator exercitationem tero. Ultra tepidus ciminatio tamdiu tabesco apparatus tepidus venio defungo. Bis sortitus supellex aranea calco.\nVito casso cursus volo denuncio tenax alveus quod. Color conventus aperiam caute. Contigo soleo deprecator trado crinis colligo sono tolero dicta.\n\nBenefits:\n1. Decimus tum thesaurus suasoria voco voluptas arbor vita.\n2. Animi umquam tardus fugit coma decor conscendo ambitus asporto sophismata.\n3. Amor ullus voco derelinquo convoco.\n\nImplementation considerations:\nCarpo crudelis consectetur defendo aggredior angulus supplanto aer calco terminatio. Strues complectus placeat ars carmen speculum dolor summisse considero vulgo. Sustineo ancilla vulnus administratio auditor atrocitas iusto.\nArtificiose labore tempore cogito delinquo. Tunc synagoga abbas inflammatio campana verecundia. Termes coniuratio vado crastinus perferendis patria sponte acies possimus audentia.	2025-04-18 18:55:33.002	2025-04-18 18:55:33.002
11	Erick Beier	Napoleon_Crooks@gmail.com	Technical support needed	I'm experiencing the following issue:\n\nCaput architecto articulus veritas. Supra cauda dolorem. Appello antiquus cognatus tracto vulgaris timidus tres.\nPraesentium delego pariatur vulgivagus ars subseco. Varietas trucido tener subnecto victoria suffragium curtus sum qui. Abscido via textor.\n\nSteps to reproduce:\n1. Sollicito fugit tertius conspergo suscipio.\n2. Capillus deporto admoveo.\n3. Dedico caecus celer patior ara occaecati tersus dolore.\n\nExpected behavior:\nBarba caritas velociter cerno. Sono valetudo arto. Vindico verumtamen spectaculum.\n\nActual behavior:\nEnim absum casso teres sufficio astrum nisi. Deduco tabesco delectatio quidem defetiscor. Tardus ex tremo.\n\nAdditional context:\nUnus ventus qui artificiose speculum sono vomica terminatio titulus. Labore blandior cumque vociferor cohibeo necessitatibus tandem theatrum. Vicissitudo carpo tolero decens coerceo ulciscor verbum confero terebro.\nTerminatio voluptates triumphus dedecor canonicus attero benevolentia sit. Congregatio collum peccatus vinum ara curiositas pectus. Suscipit sperno vita et tabula.	2025-04-18 18:55:33.002	2025-04-18 18:55:33.002
12	Barry Schultz	Frederic65@hotmail.com	Question about contribution guidelines	I need clarification about the following process:\n\nSuccedo crapula aer sustineo aequitas spes vindico adsuesco. Amita corrupti strenuus textor maiores vae. Tertius crastinus dolores.\nApparatus baiulus colligo suadeo. Voco tactus vero vorax suffragium decet somniculosus volup surculus. Decretum vomica statua copiose delinquo vereor tenuis dignissimos.\n\nCurrent understanding:\nCiminatio beatus utpote cimentarius benevolentia porro. Aetas temeritas arma supra cresco. Attero temeritas valde defleo.\n\nQuestions:\n1. Summopere denego rem auxilium ambulo quia uberrime attollo.\n2. Aduro angustus amplus adflicto pariatur defluo callide cenaculum claustrum.\n3. Totus totidem strenuus vesper provident.\n\nAdditional context:\nCalamitas desipio amita thesaurus defaeco acidus odio. Tergeo vae fugiat uberrime voluptate atrocitas capitulus suscipio angelus auditor. Amplitudo desparatus pecus una civitas.\nVulnero toties spoliatio antea. Video consequatur dolor. Truculenter ambitus valeo quaerat suus unus valeo.	2025-04-18 18:55:33.003	2025-04-18 18:55:33.003
13	Harvey Hammes	Chester.Corkery@gmail.com	Question about contribution scope	Arguo cena suggero sodalitas vicissitudo benigne catena sequi quos. Tepesco corporis uterque vergo apto cauda ut. Labore tersus approbo maiores tollo.\nEnim voluptas vilis accommodo assentator tui color solum. Temptatio arceo arceo velum theatrum sint adaugeo comburo. Accedo vester corona arbitro conatus vilicus suppono cultellus vulgus.\nDolor officiis tabesco bos coepi. Vereor antiquus aetas crustulum molestias apto qui. Bellicus admoveo praesentium angulus quam causa degenero sollers vero cubo.\n\nValeo animadverto celer vere. Ratione celer videlicet agnosco turpis sortitus summa voluntarius. Atavus peior votum velut.\nConventus thesis vae aequus autem baiulus. Antea vereor dolorem adduco cogo coniecto benevolentia vero tribuo benigne. Canto pariatur usque adamo succurro.\n\nAccendo bibo volutabrum degenero demitto tergum caritas sint cauda decet. Amet tardus cruentus numquam animi id aptus iusto delicate. Sufficio amplexus desidero degero cilicium cohibeo.\nAperiam creo conqueror ager stella velum truculenter spargo. Id aegrotatio atavus conculco degero thorax dedecor solum soleo. Damnatio sumo consequatur tripudio.	2025-04-18 18:55:33.004	2025-04-18 18:55:33.004
14	Jimmie Cremin	Dillon_Ernser42@gmail.com	Issue with contribution notifications	I've noticed some performance issues:\n\nBalbus sed suscipit. Defungo tabgo dolor deinde stabilis vilis molestias substantia confugo solitudo. Theca ara vulgivagus caelum administratio adulatio tutis carpo timor decor.\nTollo modi neque viduo cupiditas utpote conturbo dedecor spiritus cenaculum. Aperio optio recusandae trans. Absorbeo vinco vilicus crustulum textilis quam cena casus earum praesentium.\n\nPerformance metrics:\n- Response time: 1748ms\n- Throughput: 96 requests/second\n- Error rate: 0.02%\n\nEnvironment details:\nAliquid thorax ascit voluptate succurro soleo ipsa optio delibero inflammatio. Brevis ante consuasor tristis usus cibus. Cernuus tenax spargo stabilis eum verto adopto temptatio animus avarus.\n\nSteps to reproduce:\nArceo a comedo adinventitias color. Sapiente caterva titulus vero amicitia truculenter occaecati demulceo vel. Certe ademptio utique tollo defleo beneficium aurum stella calculus cena.\nCiminatio admiratio cohaero cado administratio currus desipio accusamus aduro. Trucido temptatio aestivus corrumpo sunt candidus cunctatio. Defleo voro ultra reiciendis utpote tredecim.	2025-04-18 18:55:33.004	2025-04-18 18:55:33.004
15	Malcolm Hirthe	Krystal.Bode-Stracke@yahoo.com	Question about contribution scope	I need clarification about the following process:\n\nTurbo validus denuo cupiditas aperio officia tabula aufero. Natus sperno demitto. Est cito arx aegre adiuvo velit decumbo timor.\nConicio ademptio verumtamen. A summa illum cruciamentum vilicus verto. Quo collum animus summopere desipio.\n\nCurrent understanding:\nSocius audeo vulgus aetas adipiscor quis combibo. Aegre creo ipsa. Comes adamo tempus fugiat turba cubitum.\n\nQuestions:\n1. Arguo amissio condico ambulo patria.\n2. Tot comminor uredo agnosco curriculum tenax utroque creator damno arbitro.\n3. Succedo cuius verbera ver capto volup.\n\nAdditional context:\nAduro demoror pecco adaugeo confero defendo comminor dolor. Fugit textor video video voluptatum. Conitor illum admoneo caries tenetur talus.\nEnim ascit utroque sol bis magnam certus caterva tepesco trucido. Soluta valens consequuntur tyrannus tollo rem. Surgo tui explicabo tutis amplexus defendo candidus cattus.	2025-04-18 18:55:33.005	2025-04-18 18:55:33.005
16	Albert Price	Roselyn.Rath22@yahoo.com	Question about contribution documentation	I need clarification about the following process:\n\nAuctus nesciunt demulceo arx attero aurum quas. Suppellex cresco articulus auctor adamo strenuus abduco adstringo. Deludo arbor thesaurus curis.\nAliquam termes deorsum creptio ustulo cognatus contigo cito. Corona comedo absens curto. Ademptio enim barba creta acceptus sortitus.\n\nCurrent understanding:\nDenuo voluntarius conturbo turba unus. Depopulo solvo coruscus bene cado claustrum temptatio voluntarius. Debeo sortitus excepturi verbum.\n\nQuestions:\n1. Sum in pectus suscipit articulus coma.\n2. Cilicium carpo antiquus attero arbitro.\n3. Viridis carmen beatus cunae tredecim argumentum.\n\nAdditional context:\nRatione vomito sublime. Natus sopor ustilo. Averto vereor abundans censura summopere tamdiu abeo agnitio.\nCrinis adamo umquam. Theca vitiosus adamo ducimus aestivus viduo molestias commodo corroboro. Conicio spiritus avaritia eveniet absum capio varietas.	2025-04-18 18:55:33.006	2025-04-18 18:55:33.006
17	Jonathan D'Amore	Lemuel_Rippin82@yahoo.com	Question about contribution guidelines	I need clarification about the following process:\n\nDesparatus dolorem absens suus ambitus vere turpis corpus spargo careo. Titulus temperantia ipsam temptatio teres currus desidero. Aggero copiose ter.\nLaudantium modi tondeo bene umerus viscus ab aranea. Aliqua sumptus soleo labore defungo cicuta cunabula clibanus. Appono paens aegrus cohibeo expedita ustulo cado versus acervus tricesimus.\n\nCurrent understanding:\nDecipio sollicito contigo deprecator veritatis conspergo. Tergeo compello tabesco adfero centum nesciunt eos. Antepono stabilis temptatio paulatim sol.\n\nQuestions:\n1. Spes calcar carpo damnatio soluta damno vere solus quae cenaculum.\n2. Desidero succedo nobis solio sublime summopere solus.\n3. Verbum totidem bonus speciosus.\n\nAdditional context:\nRerum accendo usitas eos consuasor. Facilis coaegresco tardus depraedor. Auctor subvenio infit accedo suffoco benevolentia vesco absens.\nVinitor occaecati sed quod denego appello. Similique vacuus deserunt combibo cotidie ago antea patria blandior quos. Iure theologus suppellex.	2025-04-18 18:55:33.009	2025-04-18 18:55:33.009
18	Tamara Cole	Lucie_Dach23@yahoo.com	Issue with contribution statistics	Aegrus contra quibusdam tametsi campana testimonium. Sub tempore ambitus audacia crapula curvo una. Aestus spoliatio umbra.\nCumque ambitus una uredo. Sollicito casso viridis dapifer video occaecati adversus acies tollo. Illo spoliatio deprecator arbustum ait depereo adsuesco.\nAttero alter vacuus tum peccatus bonus tandem absorbeo cattus tenus. Exercitationem astrum cilicium. Ipsam at tredecim thalassinus.\n\nBibo arbitro audax desparatus tumultus ante. Tabula articulus sono velum voluntarius totus. Torqueo numquam magnam temeritas deporto sodalitas quia sto.\nAscisco cometes arto capio vis. Cinis sub magnam verbera amissio territo sol carcer tres verecundia. Audio eos assumenda dens.\n\nUt sub carmen. Cometes aliquam calculus virga. Utrum succurro cena caput fugit altus tamdiu in maiores.\nUberrime tres credo comedo somnus solvo concedo adiuvo solium. Placeat accusamus versus basium. Textilis sonitus aveho taceo.	2025-04-18 18:55:33.01	2025-04-18 18:55:33.01
19	Kara Bosco	Joelle_Harvey@hotmail.com	Technical issue with contribution editor	I would like to suggest the following feature:\n\nIste via credo vorago cruentus civitas conforto vinco. Aureus sum addo. Patrocinor blanditiis vigor depopulo ater.\nAuctus brevis abscido necessitatibus patrocinor dedecor caelestis ventito curvo iste. Adsuesco curtus casus sperno explicabo stillicidium vespillo vulgivagus. Sunt super cervus tricesimus asper ullam summopere doloribus.\n\nBenefits:\n1. Umbra conqueror denuo bestia adulatio tamen terminatio aequus.\n2. Clamo umbra contego eligendi tutis.\n3. Custodia vesco combibo.\n\nImplementation considerations:\nArtificiose supellex cursus tergo cognatus copiose. Capto cibus conculco curvo creber apud valeo ater pauper. Tergum pel vester ago.\nCohaero tam suscipio solitudo cupiditate statua desidero coerceo demo cumque. Conscendo veritatis contabesco desipio spero celo. Caute debilito tempora cras tres degusto.	2025-04-18 18:55:33.01	2025-04-18 18:55:33.01
20	Mercedes Littel	Dario_Bechtelar66@yahoo.com	Request for contribution guidelines update	I'm encountering technical difficulties:\n\nNihil tutis acquiro deputo timidus vallum. Delectus stips crustulum versus turpis vos absens excepturi tempora. Conventus capillus venio.\nCimentarius quas collum sollers adversus creo annus. Aggredior studio aliquam. Circumvenio acquiro cunctatio valde caute.\n\nEnvironment details:\n- OS: Linux\n- Browser: Safari\n- Version: 7.19.14\n\nError message:\nEligendi tredecim tersus coniuratio. Colo vulnus desparatus tero corroboro timor. Denego spargo theatrum adhuc utrum et.\n\nSteps taken:\n1. Adhuc eius tepidus suggero aliquid conatus cotidie.\n2. Vulgivagus cauda nam decimus volutabrum ascisco arto speciosus tempora volubilis.\n3. Sophismata tenax torrens conicio comes timor.\n\nAdditional information:\nVinco unus tepesco maxime cerno. Uter vulgivagus concedo conicio depromo urbs vespillo. Curto cunctatio celer defungo mollitia varius.\nVoluptas tres aufero thesis somniculosus custodia verbera delego subiungo error. Adinventitias acerbitas desidero fuga depopulo debilito vulpes vinco. Thermae odio uxor tantillus alii distinctio consuasor.	2025-04-18 18:55:33.011	2025-04-18 18:55:33.011
21	Leigh Labadie	Tiffany_Anderson8@hotmail.com	Question about contribution metrics	I've noticed some performance issues:\n\nSolium videlicet totus. Sapiente benevolentia vacuus totidem tamdiu verumtamen tredecim aliquam. Laborum derelinquo tolero tertius conspergo adinventitias conventus compono confero deduco.\nAdsidue cruentus blanditiis. Aeternus aequitas templum umbra apostolus texo alter adipisci. Attollo demergo ambulo.\n\nPerformance metrics:\n- Response time: 1579ms\n- Throughput: 46 requests/second\n- Error rate: 3.83%\n\nEnvironment details:\nDelibero adfectus coerceo excepturi. Aperiam ascisco alii capitulus velociter. Eaque abbas termes cenaculum quibusdam subito.\n\nSteps to reproduce:\nAveho tres vaco succedo casus acervus celebrer. Sto videlicet toties temporibus viduo maxime eius. Collum amplexus callide claustrum.\nEveniet asporto anser vacuus ademptio. Solum convoco spargo aliqua vilis cito aut. Deficio velum attero somnus cattus.	2025-04-18 18:55:33.011	2025-04-18 18:55:33.011
22	John Jerde	Treva.Rolfson69@gmail.com	Suggestion for contribution templates	I need clarification about the following process:\n\nVoveo in adhaero arguo confugo articulus vinco tepidus. Creptio aperiam caelestis ea suscipio tubineus vivo consequuntur. Capto cometes ustilo aeneus uterque voro confero aranea bibo denuo.\nThorax charisma adulescens. Demoror censura maxime cornu angulus tracto crux demo. Audacia verus velit voluptas adhaero desino vomica.\n\nCurrent understanding:\nPraesentium voco incidunt alii. Defaeco a curo supplanto clam depraedor. Colo sit alo absens delectatio depulso demo cupiditate ante.\n\nQuestions:\n1. Spargo aperte defero.\n2. Vulnero adversus cogito terga cena approbo.\n3. Thymum ager cimentarius vinitor tam consectetur sumo veritas tandem totam.\n\nAdditional context:\nDeleo cui aliqua solium infit censura tribuo. Comitatus a appello laboriosam conculco summisse. Velum viriliter sint capto suscipit.\nDedico auditor tabgo ultra audentia antea aestivus dolor ullus. Tabula advenio ea textilis volutabrum quia. Soleo amplexus atrox catena cogo brevis cito sursum.	2025-04-18 18:55:33.012	2025-04-18 18:55:33.012
23	Juan Sipes	Katelyn9@yahoo.com	Technical support needed	I'm encountering technical difficulties:\n\nPecco iusto cohibeo spoliatio crur coma auditor artificiose aptus coniuratio. Aro abstergo itaque omnis. Crapula recusandae attollo cibo vindico ex anser causa curiositas.\nEa accommodo denuo. Charisma cervus triduana solitudo molestias accusator tyrannus. Deludo temptatio iste cometes voluptatem impedit cilicium consectetur.\n\nEnvironment details:\n- OS: Linux\n- Browser: Chrome\n- Version: 7.3.18\n\nError message:\nTutamen vulgivagus advoco denique. Verecundia accendo coma desparatus uredo confero vehemens tendo. Tondeo considero subseco cubitum vapulus varietas.\n\nSteps taken:\n1. Nihil adinventitias subvenio copiose soleo eos amaritudo super beneficium.\n2. Verumtamen tres aetas expedita crepusculum.\n3. Tantillus demergo decimus suscipio tantum arx sufficio nostrum.\n\nAdditional information:\nCilicium stillicidium tergo sumo. Creator conitor stabilis utrum amaritudo sonitus subseco vesco victoria adflicto. Demonstro cura aduro cilicium utrum cubitum calco.\nHic quae conqueror velum dolorem provident ullam. Stabilis summopere vinco vinculum amita vindico tondeo dens. Vitium venustas eos abbas vigor rerum conculco tutamen.	2025-04-18 18:55:33.014	2025-04-18 18:55:33.014
24	Terrance Hessel	Jarret.Flatley@yahoo.com	Request for contribution guidelines update	Tego baiulus sit titulus tamdiu carpo. Bestia aufero architecto concido amita subiungo quam sponte a neque. Virga necessitatibus quos necessitatibus sublime verbera tendo.\nDeputo animadverto aptus tabula. Aequus valeo carpo suppono tandem vester vociferor absconditus. Sum pecto accusator.\nReiciendis deduco tamquam decet vetus taedium. Tolero ancilla varietas tener supellex. Saepe desolo vesco cura accommodo aer deorsum adinventitias.\n\nClamo ambitus decumbo certe. Enim supplanto crux cado adsidue complectus tremo patria crapula. Ultio utique cariosus nulla adhuc strues apparatus decretum amita combibo.\nVictus victoria convoco somnus ab laboriosam tenuis error. Reprehenderit infit ultio pectus natus ager verumtamen videlicet. Alioqui vetus tabgo consectetur varietas socius laboriosam fugiat.\n\nTorrens ullam crebro admitto tertius minus. Utrum atrox undique caute veritas bos utrum. Desino aduro aureus cur repellat occaecati ars astrum.\nDolores termes cribro summisse supra sufficio color ullam tandem. Desino advenio asper conculco subvenio eaque surculus. Stips antepono adduco depulso amiculum.	2025-04-18 18:55:33.014	2025-04-18 18:55:33.014
25	Ollie Spencer	Damaris68@hotmail.com	Suggestion for contribution workflow	I would like to suggest the following feature:\n\nAbbas aliquam omnis. Suffragium valens uredo baiulus sui adipiscor validus adimpleo. Vinitor voluptate amissio texo certus amita animus decens solutio.\nAsporto ut argumentum casso. Peccatus sumo triduana. Valetudo cuius coepi expedita subvenio demergo vinco bonus.\n\nBenefits:\n1. Synagoga cognomen crux acervus venustas tamen mollitia.\n2. Aptus acer arbor tonsor tenax custodia admitto tot bellum.\n3. Canonicus solitudo cupressus abduco reprehenderit aegre vehemens vigor deinde.\n\nImplementation considerations:\nTemeritas cedo coepi depereo. Patior ademptio accedo demens depulso. Tersus cohaero strenuus audacia una.\nTunc ex caritas thymbra sponte culpo tibi esse cur tolero. Soluta pauci ea quae sustineo ipsa cunae vulariter tres quis. Ventus compono testimonium clam sed vox civis timor vitae.	2025-04-18 18:55:33.015	2025-04-18 18:55:33.015
26	Mr. Daryl Pfeffer	Curt_Lindgren7@gmail.com	Question about contribution metrics	I'm working on a complex implementation and need guidance:\n\nAdopto vester accommodo vacuus culpo damnatio tendo peior cenaculum depono. Crebro arceo cariosus absorbeo cursim qui vulariter. Ciminatio cognatus verumtamen laudantium patruus pax aeneus.\nTristis adeo stultus supplanto ultio nemo verecundia cariosus tubineus depereo. Cometes cinis sint colligo nobis. Voveo video provident absque deorsum ater tersus vis.\n\nTechnical details:\nVulpes deinde cernuus arguo cerno carpo synagoga tredecim coaegresco. Enim beatae totus vita sufficio decerno. Consectetur depereo animus velit sortitus sponte talis veritatis strues alius.\nNemo repudiandae autem complectus videlicet commemoro molestiae thymum capillus. Xiphias eos bonus varietas curis. Degenero tremo auctor.\nAmet uxor correptius. Teres corrumpo provident. Condico caste speciosus conventus.\n\nCurrent approach:\nSpeculum adaugeo conturbo demulceo adsidue admitto sequi sperno. Volaticus auxilium deserunt claudeo succurro. Traho corrumpo aestas toties.\nCreo demens tolero cresco campana contabesco demo. Ait tergeo campana adsidue. Aro fugiat vesper harum tonsor.\n\nChallenges encountered:\n1. Suasoria aequus alienus.\n2. Et super vinitor colo bis cicuta cuppedia.\n3. Amet auxilium coma amitto cras reiciendis omnis angustus perspiciatis sonitus.\n\nQuestions:\nTenetur basium cruciamentum vae ut repellat vivo admitto astrum. Canis depromo tremo acer adipiscor conicio. Autus virga verbera agnitio quo acsi iure.\nConsequuntur perspiciatis temperantia tremo contabesco benigne. Suffoco tredecim cetera id varius demitto quae conforto advenio. Tenetur comminor accusator villa tamquam stultus ars deprecator ara.	2025-04-18 18:55:33.015	2025-04-18 18:55:33.015
27	Samantha Tillman	Sincere.Littel50@gmail.com	Request for contribution mentorship	I've noticed some performance issues:\n\nArca hic angelus ab curvo ultra voro usque. Cunctatio sustineo bene audeo vinculum. Tabgo comprehendo voluptatem debilito damno sumptus admoneo.\nDelibero constans absque. Adstringo voluptate cruciamentum clementia thesis sed. Cognatus curto circumvenio capitulus toties sint benigne vitae coma.\n\nPerformance metrics:\n- Response time: 2864ms\n- Throughput: 26 requests/second\n- Error rate: 2.82%\n\nEnvironment details:\nFacilis sto angelus utrum territo suffragium. Cogito titulus copiose cubicularis. Animi crastinus votum ipsam minima cornu.\n\nSteps to reproduce:\nDelicate cado sulum teres alias victus aeneus strenuus capitulus. Vergo umerus cognatus articulus vilicus vilis deputo thesis volup crebro. Comedo aperte thymum acerbitas vix tersus supellex vigilo debilito.\nCunctatio currus totam eligendi carus virtus comptus consequuntur. Voluptatem at sollicito corrupti cui. Spiritus color strues conspergo.	2025-04-18 18:55:33.016	2025-04-18 18:55:33.016
28	Dr. Gina Crist	Eileen13@gmail.com	Suggestion for contribution templates	I'm experiencing the following issue:\n\nNecessitatibus comptus arto sint tam curriculum crur assumenda quae cruentus. Odit reiciendis adinventitias charisma aranea statim dedecor spiritus clementia cribro. Certus caveo cornu speculum sequi.\nCrur absum optio crinis aureus atrocitas dolor amplexus. Dedecor accendo adversus totidem aperio arma teres acervus adduco. Quidem theatrum curto somnus crustulum cibus itaque calculus.\n\nSteps to reproduce:\n1. Viduo earum vita quam quo umquam articulus admoneo stillicidium vacuus.\n2. Neque absens arbustum uter aer apud.\n3. Porro chirographum balbus desipio acies tum modi adopto tergum.\n\nExpected behavior:\nAdipiscor abstergo torrens credo arma. Volutabrum patria rem. Ascisco contra eos tabgo cubo cursim.\n\nActual behavior:\nSolum cernuus suscipio. Comedo supra aer textor ultra demens. Compello vae versus molestiae doloribus.\n\nAdditional context:\nCilicium absum vaco error commodi possimus. Pectus illo cornu adflicto antiquus utilis turpis vorago pariatur. Admiratio at arcesso conitor consequatur.\nTantillus solium deorsum at appono audax magnam cura absens laudantium. Crebro aetas sum enim creo capillus adulescens voluptas apparatus adeo. Acsi tertius teneo demitto spectaculum combibo strenuus quia assumenda acer.	2025-04-18 18:55:33.017	2025-04-18 18:55:33.017
29	Ivan Beier	Justina.Bednar44@gmail.com	Question about contribution process	I'm experiencing the following issue:\n\nAmplitudo umerus damnatio aeternus deleniti utpote audax. Virgo suscipit tantum alias colligo quisquam tepesco ad curia. Quo deficio vos uxor dolor subvenio laboriosam.\nExcepturi adipisci vox adimpleo angustus bis vehemens iste cribro. Ater decor tepesco curiositas curatio cumque teneo adiuvo armarium. Deserunt spectaculum peccatus aurum.\n\nSteps to reproduce:\n1. Voluptatem uxor talis decretum saepe abduco comburo amitto.\n2. Deleniti communis defero verus audacia.\n3. Taceo corporis amo impedit.\n\nExpected behavior:\nStrenuus nobis argentum debeo sint eligendi ipsam vulpes sponte. Adaugeo aliquid vitae claudeo spiritus vobis curvo combibo. Cupio vulariter caecus aptus auctus articulus ver.\n\nActual behavior:\nIllum tutamen capto vitium ab sed aequus amicitia verbum ara. Consuasor viriliter coerceo. Aufero vindico ipsam advoco vir arbor thema vorago eveniet.\n\nAdditional context:\nSub nulla reiciendis thalassinus. Doloremque decipio claro thalassinus complectus artificiose angustus arcesso auxilium. Ver suspendo stips cernuus ancilla adiuvo qui solus reprehenderit crapula.\nAdficio vindico explicabo stips torqueo fuga claro concedo est. Pauci textus crudelis concedo clamo adipisci vomica maiores debeo. Recusandae demitto consequatur sit molestiae vix conculco ratione voveo sol.	2025-04-18 18:55:33.017	2025-04-18 18:55:33.017
30	Rosie Stiedemann	Lenna.Predovic13@gmail.com	Question about contribution scope	I've noticed some performance issues:\n\nArbitro pecus subito quas audentia cito comes. Verbum incidunt cedo ex creptio arbor teneo approbo solus cribro. Coaegresco antea deleo fugiat ut tempora sumptus.\nAngustus admitto bos aurum cohors demum. Ipsa blanditiis aeternus toties comis temptatio usus complectus condico dolores. Antiquus mollitia dolor sodalitas aer facere annus ter uberrime.\n\nPerformance metrics:\n- Response time: 943ms\n- Throughput: 25 requests/second\n- Error rate: 0.02%\n\nEnvironment details:\nDecipio timor aestivus cometes. Aeternus unde subseco deporto. Despecto deinde adfero centum curo aliquam careo.\n\nSteps to reproduce:\nConsequatur vilitas amissio avarus stabilis. Voluntarius eum vitium advoco arbustum. Calcar crinis ocer.\nPecto voluptatum mollitia. Clarus timidus calco communis tamen attollo. Usque animadverto tamdiu pauper auxilium suadeo arcesso totidem tamquam infit.	2025-04-18 18:55:33.018	2025-04-18 18:55:33.018
31	Kendra Weimann	Mertie_Skiles@yahoo.com	Question about contribution guidelines	I'm experiencing the following issue:\n\nDepulso creptio quos. Hic cena amplexus. Spoliatio tamquam deserunt occaecati copia denique.\nVitae conicio curis impedit candidus stillicidium. Dolorum celebrer admiratio temperantia delinquo talio vitiosus. Ut cariosus vilis cum amet accommodo.\n\nSteps to reproduce:\n1. Traho iste certe acidus textilis tenuis comptus.\n2. Tot commemoro acidus quod venio cursus thema voluptas sulum victus.\n3. Amplexus rerum cupiditate esse odio.\n\nExpected behavior:\nSuffragium constans adaugeo vespillo tutamen. Angulus ut ter terreo defessus et suppono. Sumo terreo cumque apud unus statua cicuta labore adiuvo.\n\nActual behavior:\nAbutor antea tenuis tenus aliquam delectus compono nobis thema. Uredo dedecor cruciamentum quae maiores complectus. Quae taceo cubicularis unus defungo.\n\nAdditional context:\nContabesco unde coepi tempore magni. Comitatus territo coaegresco denuo vis tabesco coepi error. Eos uredo trucido suffoco.\nViridis charisma copia conventus videlicet. Necessitatibus terra amitto ipsa colligo carus adnuo cinis. Aveho error cursim ustulo crastinus cura vitae inflammatio conscendo accendo.	2025-04-18 18:55:33.019	2025-04-18 18:55:33.019
32	Ms. Josefina Stanton	Zane37@hotmail.com	Question about contribution rewards	I'm experiencing the following issue:\n\nTendo tergiversatio dolores. Viridis vilis vulgus. Balbus amor voluptatum debilito ocer.\nArceo volubilis solio hic spiculum. Nihil cursim volva ullus ullus dicta. Quod coepi angelus.\n\nSteps to reproduce:\n1. Blandior thymbra advenio.\n2. Libero nulla spiritus.\n3. Sapiente defendo ancilla autus textilis tergeo thema torrens creator.\n\nExpected behavior:\nInflammatio adulescens cotidie totus vespillo. Cometes vallum bis aestus vacuus vulpes terra damnatio trucido careo. Vix voluntarius defendo arbor trucido.\n\nActual behavior:\nAnnus vapulus blandior defessus xiphias consequatur amaritudo temeritas voluptatum videlicet. Cenaculum aliquid sordeo cursim illum copia. Celo tergo quis denuo animus solvo.\n\nAdditional context:\nDecipio totidem derideo apud civitas. Caterva ustulo concedo stultus suppellex acsi aeternus eos. Defero assentator virgo ventito vulpes deripio coaegresco.\nCurto causa voluptatibus colligo averto depopulo curvo. Cursim adficio talus degusto. Cui peccatus ea catena cultellus velit.	2025-04-18 18:55:33.019	2025-04-18 18:55:33.019
33	Monique Collier-Howell	Madilyn_Hirthe@hotmail.com	Question about contribution process	I have some questions about the documentation:\n\nSubvenio tandem sordeo sint ater nemo curso. Cernuus laboriosam atrocitas antepono laboriosam desparatus repudiandae adimpleo vis. Aetas cerno deleniti facilis rerum urbs curiositas denego aetas.\nVado tubineus bis vix. Degero tabernus terra curo pecus demo vergo claudeo. Cariosus depulso voveo compello.\n\nSpecific areas of confusion:\n1. Decor velit tamquam stella quidem arma celer contego creptio.\n2. Colligo totus tubineus triduana addo cernuus angelus culpo stillicidium.\n3. Nostrum aggredior curiositas vulgo vinculum non infit deleniti.\n\nSuggested improvements:\nLaboriosam arto stillicidium tenetur antea. Adflicto theologus tersus bellicus. Cauda sint ullus caterva harum.\nRem earum viduo statim corpus sufficio demulceo. Consectetur acidus demergo ait nostrum quidem adicio calamitas canto. Omnis bestia tergiversatio voro spoliatio audentia stabilis defungo succedo.	2025-04-18 18:55:33.02	2025-04-18 18:55:33.02
34	Al Reilly	Joana_Nolan@yahoo.com	Issue with contribution history	I have some questions about the documentation:\n\nVito taceo consequatur deleo. Aegrus denuo vinum via audacia. Tutis spes cometes.\nOfficia labore repudiandae. Denuncio repellat conduco accusantium summisse temperantia. Sordeo necessitatibus adsum theologus sordeo animi arguo verbera clibanus temporibus.\n\nSpecific areas of confusion:\n1. Veniam aequitas tepesco torrens terebro vehemens curriculum aggredior voluptatem.\n2. Contra vita deludo officiis deficio taceo spes at quam bibo.\n3. Agnitio cenaculum beatae coepi accusamus tricesimus illo confido dapifer eius.\n\nSuggested improvements:\nCuris caries cupiditate decipio alveus. Communis tempus coerceo cribro. Teres caveo aliquam labore omnis animus a audeo sint.\nTerminatio qui verbera. Soluta delego sub altus volubilis cubo aegrotatio. Vergo desidero truculenter a adiuvo.	2025-04-18 18:55:33.02	2025-04-18 18:55:33.02
35	Clifford Schulist	Josue.Kihn3@yahoo.com	Issue with contribution statistics	I'm experiencing the following issue:\n\nSimilique ceno subnecto caveo deprimo caelum ulterius vester repudiandae. Amet beneficium cornu decretum. Delectatio acceptus succurro aut vulgus audax trado cresco umbra creator.\nCanonicus decretum cursim incidunt tantum delectus nostrum amitto deinde. Ascit dicta tenetur. Cunabula trans varius cito adhuc eum crebro aiunt vesica.\n\nSteps to reproduce:\n1. Adsum ascisco vix.\n2. Adsuesco conscendo basium vester.\n3. Esse cui utroque.\n\nExpected behavior:\nTexo adsidue tardus similique velit aro. Aliqua demitto triumphus charisma theca balbus colo commodo sint. Dolorem chirographum aliquid.\n\nActual behavior:\nNecessitatibus atavus tantillus depereo numquam bellum veritatis ait. Valeo versus certe aureus creber tertius. Campana maxime autus tripudio patria decipio.\n\nAdditional context:\nVulnus vulariter tonsor audentia tergiversatio alo vetus vespillo cupio stips. Capto canto abutor aro. Tepidus aestas sumptus tripudio quod depopulo alii viridis xiphias explicabo.\nDeleniti subito theatrum spectaculum. Adnuo chirographum provident deduco adsum molestiae patria. Acceptus vulpes beneficium talio vicissitudo thalassinus decimus victoria arceo inventore.	2025-04-18 18:55:33.021	2025-04-18 18:55:33.021
36	Adrian Prosacco	Clementina_Funk@hotmail.com	Issue with contribution statistics	I would like to suggest the following feature:\n\nAmiculum utroque fugiat. Quaerat versus subito crastinus capto damno. Avarus dapifer amicitia conculco undique sumptus adeo tricesimus cibo.\nNobis vespillo audentia cotidie victoria curis. Tardus culpo porro patrocinor vae dicta constans quaerat viriliter contra. Vos fuga verbum stipes deripio abundans pecus adimpleo cuppedia.\n\nBenefits:\n1. Ullus ater armarium.\n2. Sublime creber sum thalassinus utrimque aliquam cariosus aqua quam repellat.\n3. Adeo condico vulticulus verumtamen colligo ulterius valde.\n\nImplementation considerations:\nCeler conventus ver uredo terror ars correptius. Hic adfero reiciendis addo demulceo unus carcer solitudo dedico. Cibo turpis virgo vinco.\nCresco comes amplus admiratio curto nihil aptus. Admoveo amet trucido molestias texo decor dedico verto caries. Virgo tempus torrens tredecim stultus ulciscor aspernatur corona.	2025-04-18 18:55:33.021	2025-04-18 18:55:33.021
37	Angelina Goldner	Dolores65@yahoo.com	Suggestion for contribution workflow	I have some feedback about the current system:\n\nCertus soluta tremo. Administratio cogo corona adamo coaegresco ciminatio decretum crastinus bardus. Aliqua ventito alii barba vitae.\nDemitto demoror ad coruscus agnitio at acceptus. Crapula denuncio aggero terreo consuasor credo. Aduro stillicidium velut debilito totus.\n\nPositive aspects:\n1. Demoror sumo adeptio.\n2. Tredecim quas pecto suspendo autem bibo.\n3. Tantillus sodalitas ventus solitudo appono ver urbs terga quis.\n\nAreas for improvement:\n1. Temeritas contego comprehendo pecco tubineus carmen.\n2. Adduco amplexus suscipit titulus audio.\n3. Umbra apto uredo.\n\nDetailed suggestions:\nTego voluptatibus adfero sumo crudelis pariatur alveus credo adimpleo. Itaque harum itaque tyrannus cras sodalitas. Quo argentum statua conculco in quidem addo qui deprecator ad.\nConstans tamisium celo amiculum alienus conitor animi decens tenetur dedecor. Volutabrum curto demonstro velit. Defleo acsi suggero curo distinctio debilito.	2025-04-18 18:55:33.022	2025-04-18 18:55:33.022
38	Kenny Mueller	Aniya_OReilly18@yahoo.com	Feature request for contribution dashboard	Celo consequuntur caelum unus tergeo. Suffragium unde tabernus annus supra commodo arbor curatio. Traho cursim arcesso amet contego demo civitas tamquam vergo cupio.\nTabernus pauci caries barba cohibeo earum tergo omnis coniuratio hic. Vomito tepesco molestias acidus agnosco soluta tres spiculum tandem. Sponte asperiores derideo delego facere apud aveho arcus cavus curiositas.\nCivis caterva considero. Quibusdam comminor volva in eveniet crux cultura. Vulgus desparatus delectus denuncio tres volaticus utpote.\n\nTrucido veritatis tabernus corona sui defaeco canonicus adversus solio cruciamentum. Cubitum supra circumvenio tabula dedecor arcus dolorem consuasor calco. Adflicto aufero toties tepidus.\nComprehendo confero iste tutamen cibus. Tam cornu summisse tepidus argentum amo vox. Tonsor videlicet sol.\n\nDucimus triduana officiis derelinquo bene explicabo. Abduco vulgus cedo carpo triumphus sordeo minima. Quae defaeco numquam animadverto.\nTermes adfectus concedo vergo sustineo. Vulgivagus taedium mollitia quam tum combibo amitto vester. Cohors aliquam admitto assentator amitto sollicito balbus infit bellicus bellum.	2025-04-18 18:55:33.022	2025-04-18 18:55:33.022
39	Sherry Runolfsdottir	Layne85@yahoo.com	Feature request for contribution dashboard	I have some feedback about the current system:\n\nValetudo appositus cruciamentum ullus volo via quas auditor. Minima stillicidium callide bardus cunctatio xiphias suffoco. Antea soleo barba aequitas ducimus verus debitis vomer spectaculum.\nVado cohors terminatio caelum trado fuga. Turbo aperte illum aspernatur tabgo damno. Exercitationem accedo facilis ancilla pauci celer thermae caute custodia.\n\nPositive aspects:\n1. Canis custodia vobis deporto admoveo considero repellat benigne nostrum tantillus.\n2. Compono tamen velut ipsum cariosus.\n3. Acervus antepono carpo benigne circumvenio canto soluta capillus.\n\nAreas for improvement:\n1. Sustineo valens surgo timidus claro venustas.\n2. Vulgo arx spectaculum animi.\n3. Dicta annus crepusculum tener copiose statua confugo damnatio beatus.\n\nDetailed suggestions:\nAperiam convoco dapifer acies amet pecco pectus cotidie aspicio. Despecto concido maiores consequatur altus. Tonsor clam verbum aptus vulpes vulgivagus verbum ustilo.\nVeniam aperiam veniam fugit. Vobis thalassinus cunabula talus. Vulariter dolore cuppedia substantia incidunt consuasor eligendi cribro virtus.	2025-04-18 18:55:33.022	2025-04-18 18:55:33.022
40	Marcos Kuhn	Flo.Purdy74@gmail.com	Suggestion for contribution templates	I'm experiencing the following issue:\n\nAccommodo recusandae uterque. Utique certus arcus attollo dolores. Cumque aro acidus tonsor veritas.\nAntea accendo contigo tibi. Vitium ambitus benigne assentator laudantium. Conduco tamen vis uredo.\n\nSteps to reproduce:\n1. Vetus clarus pectus conor ver.\n2. Est abscido carus.\n3. Carbo vir pauper summisse victoria thema cupiditate suscipit vos.\n\nExpected behavior:\nVulnus communis turpis acceptus blanditiis cicuta. Capio vir curiositas tantum audacia patruus tego peccatus. Adsidue degusto cariosus decimus vorax vere peior caput tolero.\n\nActual behavior:\nTendo tempora decens. Decumbo absorbeo animi tremo sono caries. Demergo autus cohors tumultus pariatur urbs.\n\nAdditional context:\nArca velit admoveo usitas ceno velut. Asporto vulpes error ullus. Spero coaegresco templum totam vallum a dolore patrocinor suggero.\nViridis aliquam veritas nihil. Absque cotidie despecto ubi sublime cogito. Theatrum tot teres quidem via curriculum conicio adamo.	2025-04-18 18:55:33.023	2025-04-18 18:55:33.023
41	Mamie Adams	Wilhelmine.Kiehn@gmail.com	Issue with contribution notifications	I have some feedback about the current system:\n\nCulpo articulus amor vesper nulla somniculosus arto excepturi terra adstringo. Velociter abeo thema. Blanditiis curiositas desidero.\nTantillus aliqua capillus terror adipisci placeat averto aufero corrupti. Capitulus vesco urbanus allatus vestigium autus. Comes infit accusantium carmen demum dolor tribuo.\n\nPositive aspects:\n1. Solus audacia damnatio stultus venustas curia audax provident ars valetudo.\n2. Celebrer comedo debilito delego cultura torrens ademptio cumque.\n3. Similique vester tabella temeritas virtus caries timor sophismata clementia aggredior.\n\nAreas for improvement:\n1. Tempus sequi abduco vociferor tabula balbus quis derideo agnitio.\n2. Arbustum voluntarius animi ustilo cursus ceno corrupti ciminatio cicuta annus.\n3. Quo sollers sub qui volaticus adimpleo statua utrimque solus.\n\nDetailed suggestions:\nVirgo nobis subiungo cruciamentum curriculum suffragium aveho. Tabernus sui reprehenderit vomica centum benigne vetus auctus paens. Demitto conculco creator solutio baiulus carbo credo ultra synagoga argentum.\nNostrum repudiandae claustrum deputo acceptus viridis umerus cognomen. Dolor terminatio ulterius ancilla bos amo quas thermae debilito. Videlicet adicio ambitus denique molestias vaco trado toties caterva.	2025-04-18 18:55:33.024	2025-04-18 18:55:33.024
42	Blanche Kuhn II	Jamal_Howell66@hotmail.com	Suggestion for contribution workflow	I'm experiencing the following issue:\n\nTamisium appono tamen doloremque tener varius utique taedium tametsi casus. Aduro defleo utique verus bellicus saepe terror traho. Exercitationem quasi stillicidium compello.\nVesco facilis cresco perspiciatis verto compello quibusdam. Tergum cubicularis vos advenio admiratio adversus ventus. Caries coaegresco thalassinus tollo absens synagoga quaerat.\n\nSteps to reproduce:\n1. Derideo quaerat bestia.\n2. Acsi delibero cariosus aureus.\n3. Arceo calamitas quibusdam acervus.\n\nExpected behavior:\nEveniet tactus voluntarius aequitas amplus curto atqui delego usque aggero. Clam ab aufero deleniti aperiam. Sono aro speculum tribuo voluptatum solium infit cogito curtus.\n\nActual behavior:\nCaute possimus cupiditate adulescens paens conturbo agnosco cilicium apto. Deporto fugit vivo arca ascisco censura cupiditate cubitum ascisco repellat. Sed esse cariosus supplanto vivo curiositas constans.\n\nAdditional context:\nIste argumentum tui adhuc vix demo torqueo. Bis utor animus. Qui cultura speculum audax auctor aurum aro iusto.\nTepesco cultellus curatio cena avarus aliquid beatae validus decet. Auditor xiphias caecus audentia volup tero cogito utique. Catena contra statim tyrannus calcar.	2025-04-18 18:55:33.024	2025-04-18 18:55:33.024
43	Milton Kozey	Alexzander_Senger96@gmail.com	Technical issue with contribution editor	Ventus cupiditate vox approbo arguo tantillus aeternus audeo. Tabernus ultio degero tergum atrox deinde modi. Vitiosus vobis admiratio depraedor atrocitas.\nTersus recusandae saepe arx crudelis alioqui confugo solus. Quae adficio cupressus tener sub cupiditas clam tertius. Strenuus curtus cur careo pecto atque certus pecco.\nAduro terror tricesimus doloremque amet. Pel solutio tepesco. Tristis aspicio officia amicitia officiis.\n\nAudeo audio depromo voluntarius bibo bonus. Colligo aptus suus depraedor denuo. Venio asporto utilis solutio.\nAbsque tumultus acies auditor traho curis calamitas. Succedo circumvenio appono autus curiositas video defetiscor. Delibero ullus cariosus viscus confero.\n\nAudio deputo demum capitulus caput. Abbas complectus adfectus benigne vado adflicto dicta crebro traho textor. Villa cinis debilito congregatio vulgus ascit truculenter thema.\nDeorsum nam vereor usque ipsum cattus strues demergo. Tondeo supra vos vulnus aliquid voro cur esse. Nam facilis adficio decumbo combibo collum audax.	2025-04-18 18:55:33.025	2025-04-18 18:55:33.025
44	Brent Hansen	Jackeline.Daniel29@hotmail.com	Question about contribution documentation	I need clarification about the following process:\n\nAtavus considero sublime. Audacia triduana tondeo stillicidium. Supplanto socius arbustum tepidus demens nesciunt claustrum cribro aestivus tersus.\nAra debeo calamitas ultra adficio decet sto callide colligo demonstro. Reiciendis esse quos copia adipiscor vobis undique cras. Sordeo quae caries.\n\nCurrent understanding:\nSolum civitas abscido ciminatio defaeco animus vilitas doloremque advenio. Decretum vergo pauper. Tenuis victus denique aegre ulciscor caecus.\n\nQuestions:\n1. Conforto arma pauper vulgus thema cuius.\n2. Color tristis nemo comminor atavus spes adstringo.\n3. Antepono pauper tactus utique facere.\n\nAdditional context:\nCivitas bellum vespillo contego tener aureus amplexus. Alter arceo placeat despecto vulariter mollitia aperte delectatio. Varius atrocitas calco auditor cattus vulgus tametsi vilitas.\nCresco comburo aegrotatio audio credo sustineo ulterius victus. Demoror alioqui comedo. Fugit aperio sponte ancilla alter atqui ater calco usque.	2025-04-18 18:55:33.028	2025-04-18 18:55:33.028
45	Dave Cassin	Scottie17@gmail.com	Question about contribution metrics	I'm encountering technical difficulties:\n\nCulpa ipsum nihil eius. Validus territo laborum in suscipio demum calamitas iste cunabula commodi. Succurro annus contego aggredior aeternus autem sit vinitor.\nDespecto bos viriliter ante civitas acidus coruscus adsum cuius enim. Synagoga animadverto vae deludo creptio dens accusator audax iste viduo. Tricesimus curso architecto perferendis alveus reiciendis dens decretum virga thesaurus.\n\nEnvironment details:\n- OS: macOS\n- Browser: Safari\n- Version: 0.10.5\n\nError message:\nVulariter voluptates curia crux vorax aduro apostolus. Cura cursus sophismata. Addo verbum vomer averto tantum stipes cattus animi.\n\nSteps taken:\n1. Ea viriliter cibus armarium voluptates thymbra.\n2. Vigor aufero volubilis.\n3. Currus subito varius tripudio cur.\n\nAdditional information:\nAger varius adimpleo temeritas trucido corrigo. Tutamen comparo utique argentum surgo vulnus supellex. Accusator viscus attonbitus sed tabgo acies asper culpa suggero.\nAranea varius tenus tertius utrimque cribro confido distinctio defero. Pecco creator soleo cumque speciosus abeo defetiscor viriliter. Nam adipiscor degusto spoliatio amiculum.	2025-04-18 18:55:33.028	2025-04-18 18:55:33.028
46	Alfred Dibbert II	Ephraim.Von@yahoo.com	Technical support needed	I'm experiencing the following issue:\n\nAger armarium vehemens ago tumultus tero versus atque. Adfectus cerno barba contigo tersus et delectus. Absum teneo decipio stips.\nMinima attollo stabilis cuius. Defero advoco tempora pectus vigor terra apostolus volutabrum vereor. Admiratio supra defaeco adipisci textilis degusto adinventitias terreo atrox pariatur.\n\nSteps to reproduce:\n1. Conscendo capto uberrime vester traho conicio theca dolorum cunae chirographum.\n2. Coniuratio tempore commemoro correptius volubilis vinco verbera dicta vulticulus aegre.\n3. Decor tutamen aggero ago ambulo.\n\nExpected behavior:\nAbstergo consequatur solio alveus vilis tot turpis videlicet alienus vix. Aequus pauper avaritia virga corrupti. Veritatis demulceo demoror ullam accedo.\n\nActual behavior:\nSolum conturbo constans casso damno sursum vomica. Attero suadeo cresco accusantium accusator ante una condico benevolentia spoliatio. Cervus supplanto sursum dolore tabella vergo provident correptius peior.\n\nAdditional context:\nAmaritudo timor curso aiunt thorax apparatus cuppedia dolores dolores. Sed vehemens cerno arca demo bibo bis. Dignissimos audax creo comparo aeneus enim eum statua spectaculum coniecto.\nConvoco arbustum amor cunae atqui. Patruus audentia deputo depromo. Comes clamo vero consectetur colligo constans.	2025-04-18 18:55:33.029	2025-04-18 18:55:33.029
47	Dora Johns	Jessika36@gmail.com	Suggestion for contribution templates	Adulescens velociter tui aptus deleniti trucido debitis. Viriliter tantillus civitas vilicus. Verumtamen tergo constans solum cauda contabesco.\nStabilis ancilla valde cariosus deficio vel tripudio turba veniam ara. Maiores timidus admitto. Tego confero conicio solus ante caste tempore absens tenax vinculum.\nCaste decet curo vomito carbo cruciamentum qui tamquam aqua. Numquam commemoro coniecto acidus vulgivagus turbo curatio demergo curiositas. Crinis aggredior animus decet aegrus somnus tersus usque blanditiis tracto.\n\nAlius libero xiphias sub demitto astrum verecundia vespillo nostrum amicitia. Aeger officiis comitatus. Adipiscor sopor cibo tripudio eos.\nTabgo distinctio tenuis aequitas alter accusamus. Adipisci fuga depopulo tonsor acidus ars vitiosus avarus depromo varietas. Vicinus comminor abbas decet substantia blandior approbo ventosus asporto conservo.\n\nTot curatio deprecator vos officiis sub calco adipisci. Suscipit tum cognomen calamitas decumbo crudelis volaticus crudelis tero. Ocer caries versus avarus spectaculum.\nCogo unde debilito sto. Arma incidunt adsidue eligendi spes thorax sapiente. Cunabula pariatur autus comes soluta.	2025-04-18 18:55:33.03	2025-04-18 18:55:33.03
48	Monique Smitham	Adelia_Hartmann@yahoo.com	Feature request for contribution dashboard	I have some questions about the documentation:\n\nTurpis defungo rem facilis conitor tergo via tergo victus. Denique bellicus deleo peior. Sublime sumo surculus repudiandae amo peccatus cornu.\nTantillus arcesso deinde minima comptus. Verbum videlicet abduco vetus causa vetus. Vis despecto absens cetera voluntarius denique ara carus voveo.\n\nSpecific areas of confusion:\n1. Conor aqua depono vito stabilis depono ascisco talis civis appositus.\n2. Ademptio consuasor adnuo atque creator provident careo debeo numquam despecto.\n3. Odio spoliatio clam conqueror auctus victus numquam crastinus solium.\n\nSuggested improvements:\nTalis eligendi conspergo cursus socius auctus corona dicta adfero. Cruciamentum vorax administratio. Voro cinis audeo admoneo viduo patria accendo pectus.\nVomica tutamen agnosco vinco aequitas cavus. Thymbra cruciamentum nam aqua avarus numquam quo defluo verbera sto. Corrumpo arceo deleniti odio cimentarius videlicet solus ubi.	2025-04-18 18:55:33.031	2025-04-18 18:55:33.031
49	Iris Okuneva	Arely.Streich27@yahoo.com	Question about contribution scope	I'm working on a complex implementation and need guidance:\n\nTheca molestias crinis deduco vox coniecto thesaurus approbo voro audentia. Synagoga supra capitulus claustrum vos aro utor explicabo necessitatibus. Sulum coniuratio necessitatibus.\nCubo exercitationem voluptate viridis thalassinus alveus. Ustilo caste sapiente volaticus ubi tricesimus amplexus perferendis tantillus articulus. Substantia copiose carbo usitas amicitia esse.\n\nTechnical details:\nDoloribus corrupti adhaero. Vorax volo tutis bibo. Arto creber tamquam vergo conscendo.\nUmerus decens comprehendo soluta aqua ullam. Accusantium volup asporto curis. Aequitas compono acies vehemens statim antea congregatio triduana.\nContra censura antea viscus. Adfero comis appello ars thesis causa traho. Pecco cerno vulnus abutor quis approbo confugo absque vobis cognatus.\n\nCurrent approach:\nConsequuntur demergo demergo cognomen adhuc cena tibi tenetur chirographum vitium. Barba vetus adipiscor adeptio urbanus laudantium ut videlicet surculus valeo. Tempore tepidus doloremque adsidue thymbra.\nDeinde abeo custodia sol conitor in claustrum. Carcer tener pecus deludo. Ut denego degenero temeritas solitudo.\n\nChallenges encountered:\n1. Ceno modi audeo totidem aegrus suus sed cursim defluo.\n2. Vestrum viduo defendo umerus arguo civitas.\n3. Substantia vetus claro stillicidium thymum ademptio denique tactus atrocitas.\n\nQuestions:\nSortitus canonicus delectatio subvenio eveniet umbra conculco vis accusantium adamo. Xiphias solio demitto undique truculenter arma valens utpote abduco. Voro quo absens.\nEnim sortitus audax voluptatum conservo. Vigilo deserunt capto cohaero aliquid tyrannus maiores capillus suasoria. Cornu suspendo villa autus cattus vapulus sui vicissitudo.	2025-04-18 18:55:33.032	2025-04-18 18:55:33.032
50	Philip Russel	Dale.Franey10@gmail.com	Question about contribution metrics	I would like to suggest the following feature:\n\nVelit calamitas creta utroque theologus tener. Celo aegrus comminor adduco claustrum sulum. Corona cometes via tactus.\nUmquam adsum carpo. Certus verbera admoveo. Sono audacia terror subito aufero conqueror sollers.\n\nBenefits:\n1. Odit tamdiu ipsam surgo adnuo vulnero absorbeo calculus comminor.\n2. Quibusdam depopulo trans porro.\n3. Carbo adulescens solum magni coniecto repudiandae unde tabgo usus.\n\nImplementation considerations:\nUmerus atque venustas tumultus sed despecto. Thalassinus celebrer utroque atrox vergo tenax umquam possimus volup. Molestiae stipes vereor volup.\nTendo acies cavus celo omnis. Vallum tergiversatio coniecto crux cuius ab cresco cultellus supra adsuesco. Adficio totam ventosus cattus ascit.	2025-04-18 18:55:33.036	2025-04-18 18:55:33.036
51	test	markkevin.besinga@hcl.com	sponsorship	asdfa	2025-04-18 20:17:07.553	2025-04-18 20:17:07.553
52	test	markkevin.besinga@hcl.com	basic-question	12312312312312111111	2025-04-18 20:53:05.569	2025-04-18 20:53:05.569
53	test	markkevin.besinga@hcl.com	basic-question	hello123	2025-04-19 09:34:33.355	2025-04-19 09:34:33.355
54	test	markkevin.besinga@hcl.com	basic-question	111	2025-04-19 09:38:41.854	2025-04-19 09:38:41.854
55	test	markkevin.besinga@hcl.com	basic-question	1111	2025-04-19 11:03:48.2	2025-04-19 11:03:48.2
\.


--
-- Data for Name: Session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Session" (id, "sessionToken", "userId", expires) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."User" (id, name, email, "emailVerified", password, image, is_admin, created_at, updated_at) FROM stdin;
1	John Doe	john.doe@example.com	\N	$2b$10$4GbIjN9YB8bcSUDLfUuzZeTUmGXhG1oD2w2uDc/Bzg.oEDavSKjRi	\N	t	2025-04-18 18:55:31.93	2025-04-18 18:55:31.93
2	Sarah Williams	sarah.williams@example.com	\N	$2b$10$uyEuZ4hYmQeF982P6w5rp.Mj8v7SmSzJ7N0rQ3QltYVjlElh3z9XG	\N	t	2025-04-18 18:55:31.93	2025-04-18 18:55:31.93
3	Michael Chen	michael.chen@example.com	\N	$2b$10$JdhfS55S6aL7C3eU16zPz.sT3jcjsKJGBb0prUuNdYNWCL1sVNt6y	\N	f	2025-04-18 18:55:31.93	2025-04-18 18:55:31.93
4	Preston Tromp II	Kirsten.Blanda@hotmail.com	\N	$2b$10$dJpAtih.ciTtzuxbFpyhweQKX8Hzf8XPPc9Otss3UUwurEcyU7ghe	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
5	Carolyn Block	Cindy.Wunsch37@yahoo.com	\N	$2b$10$wp7oOfAlQBVf3EYydGcBmONv5fIQ6Ju9tkKEiVgCIH4TaGgwYFG.O	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
6	Angel Nader	Nicola15@gmail.com	\N	$2b$10$q8PUw8jrTJk6n64sZsKiLeq0Iy4QGACAub1mwxugntdLyWKEn84Dq	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
7	Jackie Keebler	Jorge_Schultz@gmail.com	\N	$2b$10$4lBRi3deYU5zVAlk01AsuOhGDDwj/s7Om5e/XpR6iy846tiAztIR.	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
8	Jody Ebert	Oran_DAmore@yahoo.com	\N	$2b$10$RvpdARbY5IUc2P5d4MxySOaCGkILDUklpHeEMyE4etWvbeymnICQS	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
12	Miss Sally Heidenreich-Borer	Rubie_Stoltenberg@hotmail.com	\N	$2b$10$H00DAMkwSZWrzw/SxJX4EOSWXOk46/9bBAd3TEj2/zlKjfjU1glqa	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
13	Delores Dickens	Deborah93@hotmail.com	\N	$2b$10$bsBzBm13kh39yZFbMigjPepTLepGwTJpj2SwcTFKks09mhq2T.lsO	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
14	Kathryn Quitzon	Yvonne59@yahoo.com	\N	$2b$10$DWA.zyc1aEJJB.sczyyr5.fPujDwK1h4.uBDEsud1DAvzkPob51z2	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
15	May Greenholt	Kade.Crist4@gmail.com	\N	$2b$10$.Wj5rKXbPApE6mvohM6QmuqtSlMrU/QCphGD.xiuQ0oohLdDzHxmG	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
16	Lewis Goodwin	Elena.Hand3@gmail.com	\N	$2b$10$QSILBktiVGYaw/Ky7b6S1uE6382uNNcbNCz7YAuOIMcfZSPcVrXeq	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
17	Adam Walter	Louisa20@gmail.com	\N	$2b$10$xNuvo0aTBT.jlDHOXe7XDOGAE0rrh9xYPsVqQPJBR8cFI2gE6trxa	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
18	Olga Stehr	Elizabeth_Balistreri86@hotmail.com	\N	$2b$10$lF1DDECJZCGW8PuRCX7EYON0QgDr1C9iB9GzdtQrKPNWiF3UxJEC6	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
19	Dr. Andrew O'Connell	Marley_Murray40@gmail.com	\N	$2b$10$UEa4KIASdJGH1PCHFFTBBebIQYA297CMBCUBv9eR7UyWHBa2w/Ipu	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
20	Katherine Willms	Nicole91@yahoo.com	\N	$2b$10$XsQuPPhwTBnBqaQXANoQy.7qarzxC.0RPYjQnaXfBkQj4GA7MYG.G	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
21	Sidney Lind DDS	Christop_Auer@hotmail.com	\N	$2b$10$4VFZbQ0uCBOlNzNva1tPWeMoTv6fSHv7W3utEmWn7sQrr4b.hieZC	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
22	Debbie Grady	Sterling66@gmail.com	\N	$2b$10$ZkGJaD2nvpXqqJ3kosykmOBfbHOk/UbIIPzY3jXbGZ/PJm.Mmpnwa	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
23	Adam Williamson	Bradley22@hotmail.com	\N	$2b$10$9hylJRKYaElXcSU1uPVQsOM2X3QICsjPJadVNLHfdDWkDWRur2cHa	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
24	Darla Sawayn	Ora.Schmidt@gmail.com	\N	$2b$10$/xgIzx/UqM4xj5Hm3dH8re2eYUo710kMEUrM7lbyb26sWl4KvxBBi	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
25	Mrs. Bernice Oberbrunner	Mollie.Von83@hotmail.com	\N	$2b$10$TiSsPlS52toVmgymy1NnM.s8Fr54gll5UbI.bYAQQ8XskTEFTo.w2	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
27	Rex Carter-Olson	Euna45@gmail.com	\N	$2b$10$4zS1ck177KUFAiCLwNgsaOYbTj76qZxK.DqfYs77IFc2RXpm9XpQ2	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
28	Gayle Turcotte	Colton.Schultz54@yahoo.com	\N	$2b$10$C7pfBp7ig147nRbG4sui.uAhDFKUFzWDGMJzjtVJAwFLbX48n1SVe	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
30	Jonathan Johnston-Runolfsdottir	Adeline_Rempel@yahoo.com	\N	$2b$10$HqPThg2bN1HFAS1so8iR1uVhHC6oeofDjCcXwE3WsOnEufThB1Gde	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
31	Justin Stroman	Lizzie46@gmail.com	\N	$2b$10$un3zSMb364.L2JksX6eSJeqsaZBdlyvM7BUSl8Ohi.QsnU54uJuoq	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
32	Frankie Ullrich	Remington.Prosacco63@gmail.com	\N	$2b$10$eXeSq4PEGLM5rf1x.GUS0eHLqS7/NE6H5KLrjDbH6ePBB8cEQq4Ji	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
33	Abel Jast	Madelyn.Welch-King@hotmail.com	\N	$2b$10$.ougPi0/iEXdogH3Tyg.V.oQAl5Sp3vl4fd5JsVygbOoNXNiGf90W	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
34	Hattie MacGyver	Jayda75@hotmail.com	\N	$2b$10$6CIO49JPoQKPDoYoEyAUEeOXgwxwuX.b/JZ2R23WXNBqsV4gC9giK	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
35	Jon Marks	Alvina.Nicolas-Kertzmann77@gmail.com	\N	$2b$10$FNFoIIb2zDH4etHHnI.8K.X1DGhDVzyFjfvS8HZq49LM0WQgPWIOe	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
36	Anne Quigley	Lewis36@hotmail.com	\N	$2b$10$nNUG4.avZ25mDilBmtB0SOuQRYGVmk2u7K26QXT8Wk4hX6eBnq.lm	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
37	Mr. Garrett Frami	Myrtice_Hamill@gmail.com	\N	$2b$10$KjhO5QopHdCk4TnL93YKfeX7q2e2SmIGeoBcZ/vRYDkDJYtLt9Meu	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
38	Ramon Sanford PhD	Kennedy_Tromp16@yahoo.com	\N	$2b$10$g4e8Diq2cpN0fWxU2oQzzeBs/rQzYIpXFhZVLRiOsKdkBeRPps70m	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
39	Johnnie Wehner	Herbert99@yahoo.com	\N	$2b$10$wNsmBvGxtm2icc2sJChX/ucEvy1nrfsNW5avAvXTisvSOlCBA.HbW	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
41	Jared Buckridge I	Wiley.Treutel@gmail.com	\N	$2b$10$B/bslwigrY.NipsFWbiMSeipSKgmxFQfmOpfPietJuF9BosTr0JxW	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
42	Marta Hilll	Cassidy_Stehr@hotmail.com	\N	$2b$10$kSU7HwHmVUUvT.Pp1Fm.ZuAEocbZmqIGrlklPnRrr5PdIN8wmzWNS	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
43	Orville Kovacek-Simonis	Genesis49@hotmail.com	\N	$2b$10$sRcfQuQ9PrEUr/cZsgc1IO1uvf6MZSt4Locd5kII.sv5r/ruEI4Z2	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
44	Charlotte Considine DVM	Kaden.Roberts@hotmail.com	\N	$2b$10$rAfqVjBqd8oY7KTlHBtURO3AbKKCtUkQUzm4cIqjH9pOaZIjE2SpC	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
45	Miss Evelyn Renner	Darrel_Wisozk@hotmail.com	\N	$2b$10$a8aLTqmTcY/BLaP/6qVyv.0PiraYZUerx9V25yLbiBJRTrblwDGu6	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
46	Marc Braun	Kaela97@yahoo.com	\N	$2b$10$o2c/ennMTPQ07VJKUCfp9.k4mf36yisgCc5N0t.le1pP71LMKlBpW	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
47	Tasha Hyatt	Morris47@hotmail.com	\N	$2b$10$45TrhX5PbYGf1BlLNKjBZuuRkkhu4ZwapoKxgbKNnc5Rr8kodp7gi	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
48	Isabel Muller	Carmella_Fadel99@gmail.com	\N	$2b$10$tf0rrnFzsqpQ.XSvVmC8Lemx9gxVYog6WLP/F78o3MYFvy3.lxd.y	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
49	Charlie Jacobi	Otis.Wiza@yahoo.com	\N	$2b$10$NTLxjP.YfukCDKCpMnWUqOxor1WFanT1DuVqbLrjZf.AI1DHm5W0G	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
50	Rex O'Kon DDS	Tod_Zulauf@gmail.com	\N	$2b$10$3vVsKp2MEgpv9HhfwV2fteCZz405yym1KeuHi3fIJR70BKCezO6By	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
26	Ronnie Hand1	Bernadine_Hackett92@hotmail.com1	\N	$2b$10$/hO18jRW4w71SvFP9wQsHOHbztg5c6DIaRa6B2y4/3DWqPpNs/uyi	\N	t	2025-04-18 18:55:32.711	2025-04-18 20:50:25.569
11	Doreen Murray-Kub1	Easter.Nicolas@gmail.com1	\N	$2b$10$SkUTePzmOxj3P8gnAqv0demZEt6kTR.fYd7hpGqrPORyBf23DeoJa	\N	t	2025-04-18 18:55:32.711	2025-04-19 09:37:30.55
51	Marjorie Walker	Aliza_Langosh@hotmail.com	\N	$2b$10$/tii6/XAv39fN/3jqGDfxudDZmoCnnUo76pdRc1djPytB7IhEufK2	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
52	Yvette Barton	Royal37@yahoo.com	\N	$2b$10$7DBob2/hlk5qV0Xj/iJ5QOXwjpLpNFgkt2.wxRpLnZP.d924o1g1a	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
53	Mike Metz	Helena64@gmail.com	\N	$2b$10$UmUOXIFZfMRXNKkkYVkBc.u6Nrgd8vyrp24Vz74n7oxa16O3GFeAi	\N	f	2025-04-18 18:55:32.711	2025-04-18 18:55:32.711
55	sarinah joy besinga	besingasj@gmail.com	\N	$2b$10$gS04kZ5mH9/wzUrhvwlZ2.oqQcc0PJR48W2.I2i6mi3g5CYZNmJ0O	\N	f	2025-04-19 10:43:04.998	2025-04-19 10:43:04.998
54	Mark kevin Besinga	besingamkb@gmail.com	\N	$2b$10$3SP6YJieob4hfTlXhvp1zes1bNFGZquIKaSyKaKmiMXqEYUP.03im	\N	f	2025-04-19 10:40:51.198	2025-04-19 10:43:46.823
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
4fa62f7a-5c48-4782-8c87-bb86462c4ae1	c37108efc4906b5753fc5ba542fa430a5f238abd8e5601445cf9bee95ac81735	2025-04-19 02:55:27.129698+08	20250414122442_init	\N	\N	2025-04-19 02:55:27.05969+08	1
05834b84-b640-4f6a-831a-8272f7b17ff1	150d085920a74a0ce5fd08f8d40e5d2922b49bdf87e6ce1ccdd5456c5543e157	2025-04-19 02:55:27.145068+08	20250417184412_add_inquiries_table	\N	\N	2025-04-19 02:55:27.130755+08	1
\.


--
-- Name: CalendarEventAttendee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."CalendarEventAttendee_id_seq"', 542, true);


--
-- Name: CalendarEvent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."CalendarEvent_id_seq"', 55, true);


--
-- Name: Contribution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Contribution_id_seq"', 1273, true);


--
-- Name: Inquiry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Inquiry_id_seq"', 55, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."User_id_seq"', 56, true);


--
-- Name: Account Account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_pkey" PRIMARY KEY (id);


--
-- Name: CalendarEventAttendee CalendarEventAttendee_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CalendarEventAttendee"
    ADD CONSTRAINT "CalendarEventAttendee_pkey" PRIMARY KEY (id);


--
-- Name: CalendarEvent CalendarEvent_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CalendarEvent"
    ADD CONSTRAINT "CalendarEvent_pkey" PRIMARY KEY (id);


--
-- Name: Contribution Contribution_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Contribution"
    ADD CONSTRAINT "Contribution_pkey" PRIMARY KEY (id);


--
-- Name: Inquiry Inquiry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Inquiry"
    ADD CONSTRAINT "Inquiry_pkey" PRIMARY KEY (id);


--
-- Name: Session Session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Account_provider_providerAccountId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON public."Account" USING btree (provider, "providerAccountId");


--
-- Name: CalendarEventAttendee_event_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CalendarEventAttendee_event_id_idx" ON public."CalendarEventAttendee" USING btree (event_id);


--
-- Name: CalendarEventAttendee_event_id_user_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CalendarEventAttendee_event_id_user_id_key" ON public."CalendarEventAttendee" USING btree (event_id, user_id);


--
-- Name: CalendarEventAttendee_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CalendarEventAttendee_status_idx" ON public."CalendarEventAttendee" USING btree (status);


--
-- Name: CalendarEventAttendee_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CalendarEventAttendee_user_id_idx" ON public."CalendarEventAttendee" USING btree (user_id);


--
-- Name: CalendarEvent_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CalendarEvent_created_by_idx" ON public."CalendarEvent" USING btree (created_by);


--
-- Name: CalendarEvent_end_time_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CalendarEvent_end_time_idx" ON public."CalendarEvent" USING btree (end_time);


--
-- Name: CalendarEvent_start_time_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CalendarEvent_start_time_idx" ON public."CalendarEvent" USING btree (start_time);


--
-- Name: Contribution_month_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Contribution_month_idx" ON public."Contribution" USING btree (month);


--
-- Name: Contribution_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Contribution_status_idx" ON public."Contribution" USING btree (status);


--
-- Name: Contribution_user_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Contribution_user_id_idx" ON public."Contribution" USING btree (user_id);


--
-- Name: Inquiry_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Inquiry_created_at_idx" ON public."Inquiry" USING btree (created_at);


--
-- Name: Session_sessionToken_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Session_sessionToken_key" ON public."Session" USING btree ("sessionToken");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: Account Account_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Account"
    ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CalendarEventAttendee CalendarEventAttendee_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CalendarEventAttendee"
    ADD CONSTRAINT "CalendarEventAttendee_event_id_fkey" FOREIGN KEY (event_id) REFERENCES public."CalendarEvent"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CalendarEventAttendee CalendarEventAttendee_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CalendarEventAttendee"
    ADD CONSTRAINT "CalendarEventAttendee_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CalendarEvent CalendarEvent_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CalendarEvent"
    ADD CONSTRAINT "CalendarEvent_created_by_fkey" FOREIGN KEY (created_by) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Contribution Contribution_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Contribution"
    ADD CONSTRAINT "Contribution_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Session Session_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Session"
    ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

