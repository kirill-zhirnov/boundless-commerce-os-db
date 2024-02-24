--
-- PostgreSQL database dump
--

-- Dumped from database version 13.14 (Debian 13.14-1.pgdg120+2)
-- Dumped by pg_dump version 13.1

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
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: shipping_city_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.shipping_city_type AS ENUM (
    'courier',
    'self-pick-up'
);


--
-- Name: shipping_option_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.shipping_option_type AS ENUM (
    'edostProvider'
);


--
-- Name: shipping_tariff_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.shipping_tariff_type AS ENUM (
    'warehouse-warehouse',
    'warehouse-door',
    'door-warehouse',
    'door-door'
);


--
-- Name: area_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.area_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into area_text (area_id, lang_id)
		select
			new.area_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: background_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.background_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into background_text (background_id, lang_id)
		select
			new.background_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


--
-- Name: city_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.city_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

	begin
		insert into city_text (city_id, lang_id)
		select
			new.city_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: country_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.country_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into country_text (country_id, lang_id)
		select
			new.country_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: payment_gateway_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.payment_gateway_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into payment_gateway_text (payment_gateway_id, lang_id)
		select
			NEW.payment_gateway_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: region_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.region_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into region_text (region_id, lang_id)
		select
			new.region_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: shipping_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.shipping_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into shipping_text (shipping_id, lang_id)
		select
			NEW.shipping_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: shipping_option_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.shipping_option_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into shipping_option_text
			(option_id, lang_id)
		select
			new.option_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


--
-- Name: shipping_pickup_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.shipping_pickup_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__city_qty integer; 
	begin
		insert into shipping_pickup_text (point_id, lang_id)
		select
			NEW.point_id,
			lang_id
		from
			lang;


		select 
			count(*) into __city_qty 
		from 
			shipping_city 
		where 
			shipping_id = new.shipping_id 
			and city_id = new.city_id
			and 'self-pick-up' = ANY (type)
		;

		if __city_qty = 0 then
			insert into shipping_city 
				(shipping_id, city_id, type)
			values
				(new.shipping_id, new.city_id, '{self-pick-up}')
			on conflict (shipping_id, city_id)
			do update
			set
				type = array_append(coalesce(shipping_city.type, '{}'::shipping_city_type[]), 'self-pick-up')
			;
				
		end if;
		
		return NEW;
	end;
$$;


--
-- Name: shipping_tariff_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.shipping_tariff_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ begin insert into shipping_tariff_text (tariff_id, lang_id) select new.tariff_id, lang_id from lang; return new; end; $$;


--
-- Name: shipping_zip_city_courier(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.shipping_zip_city_courier() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__zip_courier_qty integer;
		__city_id integer;
		__city_qty integer; 
	begin
		select city_id into __city_id from zip where zip_id = new.zip_id;
		
		select 
			count(*) into __zip_courier_qty
		from 
			shipping_zip
			inner join zip using(zip_id)			
		where 
			shipping_id  = new.shipping_id
			and courier is true
			and city_id = __city_id
		;

		select
			count(*)
			into __city_qty
		from
			shipping_city
		where
			shipping_id = new.shipping_id
			and city_id = __city_id
			and 'courier' = ANY (type)
		;


		if __zip_courier_qty > 0 then
			if __city_qty = 0 then
				insert into shipping_city 
					(shipping_id, city_id, type)
				values
					(new.shipping_id, __city_id, '{courier}')
					on conflict (shipping_id, city_id)
					do update
					set
						type = array_append(coalesce(shipping_city.type, '{}'::shipping_city_type[]), 'courier')
				;
			end if;
		else
			if __city_qty > 0 then
				update
					shipping_city
				set
					type = array_remove(coalesce(shipping_city.type, '{}'::shipping_city_type[]), 'courier')
				where
					shipping_id = new.shipping_id
					and city_id = __city_id
				;
			end if;
		end if;
		
		return NEW;
	end;
$$;


--
-- Name: theme_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.theme_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into theme_text (theme_id, lang_id)
		select
			new.theme_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: action_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.action_log (
    action_id bigint NOT NULL,
    type character varying(255),
    object_type character varying(255),
    object_id character varying(255),
    subject_type character varying(255),
    subject_id character varying(255),
    reason character varying(255),
    action_data json,
    action_text text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    "from" text,
    "to" text
);


--
-- Name: action_log_action_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.action_log_action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_log_action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.action_log_action_id_seq OWNED BY public.action_log.action_id;


--
-- Name: adonis_schema; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adonis_schema (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone DEFAULT now()
);


--
-- Name: adonis_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.adonis_schema_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: adonis_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.adonis_schema_id_seq OWNED BY public.adonis_schema.id;


--
-- Name: area; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area (
    area_id integer NOT NULL,
    region_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    kladr_id character varying(19),
    fias_id character varying(36)
);


--
-- Name: area_area_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.area_area_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: area_area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.area_area_id_seq OWNED BY public.area.area_id;


--
-- Name: area_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.area_text (
    area_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    pure_title public.citext
);


--
-- Name: background; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.background (
    background_id integer NOT NULL,
    img character varying(255) NOT NULL,
    preview character varying(255) NOT NULL,
    sort integer NOT NULL,
    css jsonb
);


--
-- Name: background_background_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.background_background_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: background_background_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.background_background_id_seq OWNED BY public.background.background_id;


--
-- Name: background_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.background_text (
    background_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text
);


--
-- Name: city; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    country_id integer NOT NULL,
    region_id integer,
    area_id integer,
    vk_id bigint,
    is_important boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    vk_no_region boolean,
    kladr_id character varying(19),
    fias_id character varying(36),
    geo point
);


--
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.city_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;


--
-- Name: city_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.city_text (
    city_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text,
    pure_title public.citext
);


--
-- Name: country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.country (
    country_id integer NOT NULL,
    code character varying(2),
    vk_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: country_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.country_country_id_seq OWNED BY public.country.country_id;


--
-- Name: country_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.country_text (
    country_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text
);


--
-- Name: delivery_server_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_server_user (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    password character varying(60) NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: delivery_server_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_server_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_server_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_server_user_id_seq OWNED BY public.delivery_server_user.id;


--
-- Name: edost_region; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.edost_region (
    edost_region_id integer NOT NULL,
    region_id integer NOT NULL,
    title character varying(255)
);


--
-- Name: edost_region_edost_region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.edost_region_edost_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: edost_region_edost_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.edost_region_edost_region_id_seq OWNED BY public.edost_region.edost_region_id;


--
-- Name: lang; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lang (
    lang_id integer NOT NULL,
    code character varying(2),
    is_backend boolean DEFAULT true NOT NULL
);


--
-- Name: lang_lang_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lang_lang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lang_lang_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lang_lang_id_seq OWNED BY public.lang.lang_id;


--
-- Name: payment_gateway; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_gateway (
    payment_gateway_id integer NOT NULL,
    alias character varying(20),
    settings jsonb,
    sort integer NOT NULL
);


--
-- Name: payment_gateway_payment_gateway_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_gateway_payment_gateway_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_gateway_payment_gateway_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_gateway_payment_gateway_id_seq OWNED BY public.payment_gateway.payment_gateway_id;


--
-- Name: payment_gateway_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_gateway_text (
    payment_gateway_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(100),
    description text
);


--
-- Name: shipping_pickup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_pickup (
    point_id integer NOT NULL,
    shipping_id integer NOT NULL,
    city_id integer NOT NULL,
    local_id character varying(255),
    coordinate point,
    possibility_to_pay_for_order boolean,
    deleted_at timestamp with time zone
);


--
-- Name: pickup_point_point_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pickup_point_point_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pickup_point_point_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pickup_point_point_id_seq OWNED BY public.shipping_pickup.point_id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.region (
    region_id integer NOT NULL,
    country_id integer,
    vk_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    kladr_id character varying(19),
    fias_id character varying(36)
);


--
-- Name: region_region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.region_region_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: region_region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.region_region_id_seq OWNED BY public.region.region_id;


--
-- Name: region_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.region_text (
    region_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    pure_title public.citext
);


--
-- Name: shipping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping (
    shipping_id integer NOT NULL,
    alias character varying(20) NOT NULL,
    settings jsonb,
    only_calculation boolean DEFAULT false NOT NULL
);


--
-- Name: shipping_city; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_city (
    shipping_id integer NOT NULL,
    city_id integer NOT NULL,
    type public.shipping_city_type[],
    local_id character varying(255),
    local_city_title character varying(255)
);


--
-- Name: shipping_country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_country (
    shipping_id integer NOT NULL,
    country_id integer NOT NULL,
    local_id character varying(255)
);


--
-- Name: shipping_option; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_option (
    option_id integer NOT NULL,
    shipping_id integer NOT NULL,
    type public.shipping_option_type,
    alias character varying(20),
    created_at timestamp with time zone DEFAULT now(),
    deleted_at timestamp with time zone
);


--
-- Name: shipping_option_option_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shipping_option_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shipping_option_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shipping_option_option_id_seq OWNED BY public.shipping_option.option_id;


--
-- Name: shipping_option_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_option_text (
    option_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(100)
);


--
-- Name: shipping_pickup_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_pickup_text (
    point_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text,
    address text,
    phone character varying(100),
    work_schedule text
);


--
-- Name: shipping_shipping_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shipping_shipping_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shipping_shipping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shipping_shipping_id_seq OWNED BY public.shipping.shipping_id;


--
-- Name: shipping_tariff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_tariff (
    tariff_id integer NOT NULL,
    shipping_id integer NOT NULL,
    local_id integer NOT NULL,
    type public.shipping_tariff_type,
    service_group character varying(20),
    postomat boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    deleted_at timestamp with time zone
);


--
-- Name: shipping_tariff_tariff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shipping_tariff_tariff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shipping_tariff_tariff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shipping_tariff_tariff_id_seq OWNED BY public.shipping_tariff.tariff_id;


--
-- Name: shipping_tariff_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_tariff_text (
    tariff_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(255)
);


--
-- Name: shipping_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_text (
    shipping_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(100)
);


--
-- Name: shipping_zip; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_zip (
    shipping_id integer NOT NULL,
    zip_id integer NOT NULL,
    courier boolean NOT NULL
);


--
-- Name: sms_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sms_provider (
    provider_id integer NOT NULL,
    alias character varying(20) NOT NULL
);


--
-- Name: sms_provider_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sms_provider_provider_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sms_provider_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sms_provider_provider_id_seq OWNED BY public.sms_provider.provider_id;


--
-- Name: theme; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.theme (
    theme_id integer NOT NULL,
    alias character varying(50) NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    sort integer DEFAULT 0 NOT NULL,
    preview character varying(255),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: theme_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.theme_text (
    theme_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text,
    description text
);


--
-- Name: theme_theme_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.theme_theme_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: theme_theme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.theme_theme_id_seq OWNED BY public.theme.theme_id;


--
-- Name: unparseds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unparseds (
    id integer NOT NULL,
    delivery character varying(20) NOT NULL,
    local_id character varying(50) NOT NULL,
    city json NOT NULL,
    processed_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: unparseds_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unparseds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unparseds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unparseds_id_seq OWNED BY public.unparseds.id;


--
-- Name: zip; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.zip (
    zip_id integer NOT NULL,
    country_id integer NOT NULL,
    city_id integer NOT NULL,
    zip character varying(30) NOT NULL
);


--
-- Name: zip_zip_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.zip_zip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: zip_zip_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.zip_zip_id_seq OWNED BY public.zip.zip_id;


--
-- Name: action_log action_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_log ALTER COLUMN action_id SET DEFAULT nextval('public.action_log_action_id_seq'::regclass);


--
-- Name: adonis_schema id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adonis_schema ALTER COLUMN id SET DEFAULT nextval('public.adonis_schema_id_seq'::regclass);


--
-- Name: area area_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area ALTER COLUMN area_id SET DEFAULT nextval('public.area_area_id_seq'::regclass);


--
-- Name: background background_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background ALTER COLUMN background_id SET DEFAULT nextval('public.background_background_id_seq'::regclass);


--
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


--
-- Name: country country_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country ALTER COLUMN country_id SET DEFAULT nextval('public.country_country_id_seq'::regclass);


--
-- Name: delivery_server_user id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_server_user ALTER COLUMN id SET DEFAULT nextval('public.delivery_server_user_id_seq'::regclass);


--
-- Name: edost_region edost_region_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edost_region ALTER COLUMN edost_region_id SET DEFAULT nextval('public.edost_region_edost_region_id_seq'::regclass);


--
-- Name: lang lang_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lang ALTER COLUMN lang_id SET DEFAULT nextval('public.lang_lang_id_seq'::regclass);


--
-- Name: payment_gateway payment_gateway_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_gateway ALTER COLUMN payment_gateway_id SET DEFAULT nextval('public.payment_gateway_payment_gateway_id_seq'::regclass);


--
-- Name: region region_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region ALTER COLUMN region_id SET DEFAULT nextval('public.region_region_id_seq'::regclass);


--
-- Name: shipping shipping_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping ALTER COLUMN shipping_id SET DEFAULT nextval('public.shipping_shipping_id_seq'::regclass);


--
-- Name: shipping_option option_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option ALTER COLUMN option_id SET DEFAULT nextval('public.shipping_option_option_id_seq'::regclass);


--
-- Name: shipping_pickup point_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_pickup ALTER COLUMN point_id SET DEFAULT nextval('public.pickup_point_point_id_seq'::regclass);


--
-- Name: shipping_tariff tariff_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_tariff ALTER COLUMN tariff_id SET DEFAULT nextval('public.shipping_tariff_tariff_id_seq'::regclass);


--
-- Name: sms_provider provider_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_provider ALTER COLUMN provider_id SET DEFAULT nextval('public.sms_provider_provider_id_seq'::regclass);


--
-- Name: theme theme_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme ALTER COLUMN theme_id SET DEFAULT nextval('public.theme_theme_id_seq'::regclass);


--
-- Name: unparseds id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unparseds ALTER COLUMN id SET DEFAULT nextval('public.unparseds_id_seq'::regclass);


--
-- Name: zip zip_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zip ALTER COLUMN zip_id SET DEFAULT nextval('public.zip_zip_id_seq'::regclass);


--
-- Data for Name: action_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.action_log (action_id, type, object_type, object_id, subject_type, subject_id, reason, action_data, action_text, created_at, updated_at, "from", "to") FROM stdin;
\.


--
-- Data for Name: adonis_schema; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.adonis_schema (id, name, batch, migration_time) FROM stdin;
1	1550133229044_user_schema	1	2019-03-15 20:54:54.577413+00
2	1550133999088_unparsed_schema	1	2019-03-15 20:54:54.589309+00
3	1553429148237_action_log_schema	2	2019-04-04 16:21:02.760578+00
4	1553534449455_add_fields_schema	3	2019-04-04 16:23:34.73771+00
5	1553681642186_add_fields_to_action_log_schema	3	2019-04-04 16:23:34.743148+00
6	1554387706679_action_log_indxs_schema	3	2019-04-04 16:23:34.770822+00
\.


--
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.area (area_id, region_id, created_at, deleted_at, kladr_id, fias_id) FROM stdin;
\.


--
-- Data for Name: area_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.area_text (area_id, lang_id, title, pure_title) FROM stdin;
\.


--
-- Data for Name: background; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.background (background_id, img, preview, sort, css) FROM stdin;
2	images/backgrounds/cheap_diagonal_fabric/bg.png	images/backgrounds/cheap_diagonal_fabric/preview.png	10	{"background-color": "transparent", "background-repeat": "repeat"}
3	images/backgrounds/restaurant/bg.png	images/backgrounds/restaurant/preview.png	20	{"background-color": "transparent", "background-repeat": "repeat"}
4	images/backgrounds/school/bg.png	images/backgrounds/school/preview.png	30	{"background-color": "transparent", "background-repeat": "repeat"}
5	images/backgrounds/small_steps/bg.png	images/backgrounds/small_steps/preview.png	40	{"background-color": "transparent", "background-repeat": "repeat"}
6	images/backgrounds/gray_lines/bg.png	images/backgrounds/gray_lines/preview.png	50	{"background-color": "transparent", "background-repeat": "no-repeat"}
7	images/backgrounds/light_urban_tall_meeting_structure/bg.jpg	images/backgrounds/light_urban_tall_meeting_structure/preview.jpg	60	{"background-size": "cover", "background-color": "transparent", "background-repeat": "no-repeat", "background-position": "center", "background-attachment": "fixed"}
8	images/backgrounds/table_with_fuzzy_background/bg.jpg	images/backgrounds/table_with_fuzzy_background/preview.jpg	70	{"background-size": "cover", "background-color": "transparent", "background-repeat": "no-repeat", "background-position": "center", "background-attachment": "fixed"}
9	images/backgrounds/white_brick_wall_background/bg.jpg	images/backgrounds/white_brick_wall_background/preview.jpg	80	{"background-size": "cover", "background-color": "transparent", "background-repeat": "no-repeat", "background-position": "center", "background-attachment": "fixed"}
10	images/backgrounds/dark_natural_retro_decorative_backdrop/bg.jpg	images/backgrounds/dark_natural_retro_decorative_backdrop/preview.jpg	90	{"background-size": "cover", "background-color": "transparent", "background-repeat": "no-repeat", "background-position": "center", "background-attachment": "fixed"}
11	images/backgrounds/vegetables_set_left_black_slate/bg.jpg	images/backgrounds/vegetables_set_left_black_slate/bg.jpg	100	{"background-size": "cover", "background-color": "transparent", "background-repeat": "no-repeat", "background-position": "center", "background-attachment": "fixed"}
12	images/backgrounds/set_ingredients_prepare_dough/bg.jpg	images/backgrounds/set_ingredients_prepare_dough/bg.jpg	110	{"background-size": "cover", "background-color": "transparent", "background-repeat": "no-repeat", "background-position": "center", "background-attachment": "fixed"}
13	images/backgrounds/mountains/bg.jpg	images/backgrounds/mountains/bg.jpg	120	{"background-color": "#fff", "background-repeat": "no-repeat", "background-position": "top center"}
14	images/backgrounds/damaged_brick_wall_texture/bg.jpg	images/backgrounds/damaged_brick_wall_texture/bg.jpg	120	{"background-size": "cover", "background-color": "transparent", "background-repeat": "no-repeat", "background-position": "center", "background-attachment": "fixed"}
15	images/backgrounds/sports/bg.png	images/backgrounds/sports/bg.png	130	{"background-color": "transparent", "background-repeat": "repeat"}
16	images/backgrounds/paint_flowers/bg.jpg	images/backgrounds/paint_flowers/bg.jpg	140	{"background-color": "#f7f5ed", "background-repeat": "no-repeat", "background-position": "top center"}
17	images/backgrounds/tweed/bg.png	images/backgrounds/tweed/bg.png	150	{"background-color": "transparent", "background-repeat": "repeat"}
18	images/backgrounds/retina_wood/bg.png	images/backgrounds/retina_wood/bg.png	160	{"background-color": "transparent", "background-repeat": "repeat"}
19	images/backgrounds/congruent_pentagon/bg.png	images/backgrounds/congruent_pentagon/bg.png	170	{"background-color": "transparent", "background-repeat": "repeat"}
20	images/backgrounds/food/bg.png	images/backgrounds/food/bg.png	180	{"background-color": "transparent", "background-repeat": "repeat"}
21	images/backgrounds/brickwall/bg.png	images/backgrounds/brickwall/bg.png	190	{"background-color": "transparent", "background-repeat": "repeat"}
22	images/backgrounds/polonez_car/bg.png	images/backgrounds/polonez_car/bg.png	200	{"background-color": "transparent", "background-repeat": "repeat"}
\.


--
-- Data for Name: background_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.background_text (background_id, lang_id, title) FROM stdin;
2	1	Шаблон: диагональ
3	1	Шаблон: ресторан
4	1	Шаблон: школа
5	1	Шаблон: маленькие шаги
6	1	Серые линии
7	1	Городская среда: здания
8	1	Деревянный стол с размытым фоном
9	1	Стена из белых кирпичей
10	1	Стена из темных досок
11	1	Набор овощей на темном фоне
12	1	Набор ингридиентов для приготовления теста
14	1	Текстура поврежденной кирпичной стены
13	1	Горы
15	1	Шаблон: спорт
16	1	Рисунок цветов
17	1	Шаблон: твид
18	1	Шаблон: паркетная доска
19	1	Шаблон: зеленые пятиугольники
20	1	Шаблон: продукты
21	1	Шаблон: светлые кирпичи
22	1	Шаблон: машины
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.city (city_id, country_id, region_id, area_id, vk_id, is_important, created_at, deleted_at, vk_no_region, kladr_id, fias_id, geo) FROM stdin;
\.


--
-- Data for Name: city_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.city_text (city_id, lang_id, title, pure_title) FROM stdin;
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.country (country_id, code, vk_id, created_at, deleted_at) FROM stdin;
1	af	\N	2022-03-26 08:29:46.761049+00	\N
2	ax	\N	2022-03-26 08:29:46.76654+00	\N
3	al	\N	2022-03-26 08:29:46.769893+00	\N
4	dz	\N	2022-03-26 08:29:46.773258+00	\N
5	as	\N	2022-03-26 08:29:46.776809+00	\N
6	ad	\N	2022-03-26 08:29:46.780082+00	\N
7	ao	\N	2022-03-26 08:29:46.783584+00	\N
8	ai	\N	2022-03-26 08:29:46.78711+00	\N
9	aq	\N	2022-03-26 08:29:46.790472+00	\N
10	ag	\N	2022-03-26 08:29:46.793837+00	\N
11	ar	\N	2022-03-26 08:29:46.79709+00	\N
12	am	\N	2022-03-26 08:29:46.800422+00	\N
13	aw	\N	2022-03-26 08:29:46.803859+00	\N
14	au	\N	2022-03-26 08:29:46.807067+00	\N
15	at	\N	2022-03-26 08:29:46.810255+00	\N
16	az	\N	2022-03-26 08:29:46.813403+00	\N
17	bs	\N	2022-03-26 08:29:46.817066+00	\N
18	bh	\N	2022-03-26 08:29:46.820785+00	\N
19	bd	\N	2022-03-26 08:29:46.825078+00	\N
20	bb	\N	2022-03-26 08:29:46.828862+00	\N
21	by	\N	2022-03-26 08:29:46.832708+00	\N
22	be	\N	2022-03-26 08:29:46.838718+00	\N
23	bz	\N	2022-03-26 08:29:46.842724+00	\N
24	bj	\N	2022-03-26 08:29:46.846052+00	\N
25	bm	\N	2022-03-26 08:29:46.849946+00	\N
26	bt	\N	2022-03-26 08:29:46.853482+00	\N
27	bo	\N	2022-03-26 08:29:46.857922+00	\N
28	bq	\N	2022-03-26 08:29:46.862357+00	\N
29	ba	\N	2022-03-26 08:29:46.866042+00	\N
30	bw	\N	2022-03-26 08:29:46.870528+00	\N
31	bv	\N	2022-03-26 08:29:46.875231+00	\N
32	br	\N	2022-03-26 08:29:46.878995+00	\N
33	io	\N	2022-03-26 08:29:46.882859+00	\N
34	bn	\N	2022-03-26 08:29:46.886329+00	\N
35	bg	\N	2022-03-26 08:29:46.890213+00	\N
36	bf	\N	2022-03-26 08:29:46.893457+00	\N
37	bi	\N	2022-03-26 08:29:46.897071+00	\N
38	kh	\N	2022-03-26 08:29:46.900848+00	\N
39	cm	\N	2022-03-26 08:29:46.90465+00	\N
40	ca	\N	2022-03-26 08:29:46.908118+00	\N
41	cv	\N	2022-03-26 08:29:46.911346+00	\N
42	ky	\N	2022-03-26 08:29:46.915086+00	\N
43	cf	\N	2022-03-26 08:29:46.919086+00	\N
44	td	\N	2022-03-26 08:29:46.923876+00	\N
45	cl	\N	2022-03-26 08:29:46.927427+00	\N
46	cn	\N	2022-03-26 08:29:46.930875+00	\N
47	cx	\N	2022-03-26 08:29:46.934615+00	\N
48	cc	\N	2022-03-26 08:29:46.938407+00	\N
49	co	\N	2022-03-26 08:29:46.941846+00	\N
50	km	\N	2022-03-26 08:29:46.945281+00	\N
51	cg	\N	2022-03-26 08:29:46.948859+00	\N
52	cd	\N	2022-03-26 08:29:46.953082+00	\N
53	ck	\N	2022-03-26 08:29:46.95667+00	\N
54	cr	\N	2022-03-26 08:29:46.960335+00	\N
55	ci	\N	2022-03-26 08:29:46.964059+00	\N
56	hr	\N	2022-03-26 08:29:46.96757+00	\N
57	cu	\N	2022-03-26 08:29:46.971449+00	\N
58	cw	\N	2022-03-26 08:29:46.975406+00	\N
59	cy	\N	2022-03-26 08:29:46.979251+00	\N
60	cz	\N	2022-03-26 08:29:46.982515+00	\N
61	dk	\N	2022-03-26 08:29:46.986188+00	\N
62	dj	\N	2022-03-26 08:29:46.989862+00	\N
63	dm	\N	2022-03-26 08:29:46.993452+00	\N
64	do	\N	2022-03-26 08:29:46.996847+00	\N
65	ec	\N	2022-03-26 08:29:47.000151+00	\N
66	eg	\N	2022-03-26 08:29:47.003702+00	\N
67	sv	\N	2022-03-26 08:29:47.007151+00	\N
68	gq	\N	2022-03-26 08:29:47.010637+00	\N
69	er	\N	2022-03-26 08:29:47.013925+00	\N
70	ee	\N	2022-03-26 08:29:47.017961+00	\N
71	et	\N	2022-03-26 08:29:47.021851+00	\N
72	fk	\N	2022-03-26 08:29:47.025982+00	\N
73	fo	\N	2022-03-26 08:29:47.029667+00	\N
74	fj	\N	2022-03-26 08:29:47.033118+00	\N
75	fi	\N	2022-03-26 08:29:47.037199+00	\N
76	fr	\N	2022-03-26 08:29:47.041272+00	\N
77	gf	\N	2022-03-26 08:29:47.044709+00	\N
78	pf	\N	2022-03-26 08:29:47.048109+00	\N
79	tf	\N	2022-03-26 08:29:47.051785+00	\N
80	ga	\N	2022-03-26 08:29:47.056277+00	\N
81	gm	\N	2022-03-26 08:29:47.059795+00	\N
82	ge	\N	2022-03-26 08:29:47.063069+00	\N
83	de	\N	2022-03-26 08:29:47.066896+00	\N
84	gh	\N	2022-03-26 08:29:47.070847+00	\N
85	gi	\N	2022-03-26 08:29:47.075576+00	\N
86	gr	\N	2022-03-26 08:29:47.079122+00	\N
87	gl	\N	2022-03-26 08:29:47.083358+00	\N
88	gd	\N	2022-03-26 08:29:47.087085+00	\N
89	gp	\N	2022-03-26 08:29:47.091166+00	\N
90	gu	\N	2022-03-26 08:29:47.094894+00	\N
91	gt	\N	2022-03-26 08:29:47.099039+00	\N
92	gg	\N	2022-03-26 08:29:47.10248+00	\N
93	gn	\N	2022-03-26 08:29:47.106198+00	\N
94	gw	\N	2022-03-26 08:29:47.109503+00	\N
95	gy	\N	2022-03-26 08:29:47.11273+00	\N
96	ht	\N	2022-03-26 08:29:47.116414+00	\N
97	hm	\N	2022-03-26 08:29:47.119766+00	\N
98	va	\N	2022-03-26 08:29:47.12413+00	\N
99	hn	\N	2022-03-26 08:29:47.127429+00	\N
100	hk	\N	2022-03-26 08:29:47.130842+00	\N
101	hu	\N	2022-03-26 08:29:47.134197+00	\N
102	is	\N	2022-03-26 08:29:47.137703+00	\N
103	in	\N	2022-03-26 08:29:47.141021+00	\N
104	id	\N	2022-03-26 08:29:47.144541+00	\N
105	ir	\N	2022-03-26 08:29:47.147967+00	\N
106	iq	\N	2022-03-26 08:29:47.151388+00	\N
107	ie	\N	2022-03-26 08:29:47.154962+00	\N
108	im	\N	2022-03-26 08:29:47.158395+00	\N
109	il	\N	2022-03-26 08:29:47.161947+00	\N
110	it	\N	2022-03-26 08:29:47.165203+00	\N
111	jm	\N	2022-03-26 08:29:47.169139+00	\N
112	jp	\N	2022-03-26 08:29:47.172662+00	\N
113	je	\N	2022-03-26 08:29:47.176154+00	\N
114	jo	\N	2022-03-26 08:29:47.179609+00	\N
115	kz	\N	2022-03-26 08:29:47.182952+00	\N
116	ke	\N	2022-03-26 08:29:47.186296+00	\N
117	ki	\N	2022-03-26 08:29:47.189787+00	\N
118	kp	\N	2022-03-26 08:29:47.19314+00	\N
119	kr	\N	2022-03-26 08:29:47.196486+00	\N
120	kw	\N	2022-03-26 08:29:47.20015+00	\N
121	kg	\N	2022-03-26 08:29:47.203647+00	\N
122	la	\N	2022-03-26 08:29:47.207023+00	\N
123	lv	\N	2022-03-26 08:29:47.210595+00	\N
124	lb	\N	2022-03-26 08:29:47.214088+00	\N
125	ls	\N	2022-03-26 08:29:47.217974+00	\N
126	lr	\N	2022-03-26 08:29:47.22122+00	\N
127	ly	\N	2022-03-26 08:29:47.224605+00	\N
128	li	\N	2022-03-26 08:29:47.228037+00	\N
129	lt	\N	2022-03-26 08:29:47.231394+00	\N
130	lu	\N	2022-03-26 08:29:47.235151+00	\N
131	mo	\N	2022-03-26 08:29:47.240217+00	\N
132	mk	\N	2022-03-26 08:29:47.2438+00	\N
133	mg	\N	2022-03-26 08:29:47.24726+00	\N
134	mw	\N	2022-03-26 08:29:47.250864+00	\N
135	my	\N	2022-03-26 08:29:47.254164+00	\N
136	mv	\N	2022-03-26 08:29:47.257541+00	\N
137	ml	\N	2022-03-26 08:29:47.260833+00	\N
138	mt	\N	2022-03-26 08:29:47.264179+00	\N
139	mh	\N	2022-03-26 08:29:47.267711+00	\N
140	mq	\N	2022-03-26 08:29:47.270842+00	\N
141	mr	\N	2022-03-26 08:29:47.274325+00	\N
142	mu	\N	2022-03-26 08:29:47.277582+00	\N
143	yt	\N	2022-03-26 08:29:47.280727+00	\N
144	mx	\N	2022-03-26 08:29:47.284619+00	\N
145	fm	\N	2022-03-26 08:29:47.287862+00	\N
146	md	\N	2022-03-26 08:29:47.29156+00	\N
147	mc	\N	2022-03-26 08:29:47.294838+00	\N
148	mn	\N	2022-03-26 08:29:47.298176+00	\N
149	me	\N	2022-03-26 08:29:47.301529+00	\N
150	ms	\N	2022-03-26 08:29:47.305068+00	\N
151	ma	\N	2022-03-26 08:29:47.308464+00	\N
152	mz	\N	2022-03-26 08:29:47.31181+00	\N
153	mm	\N	2022-03-26 08:29:47.31536+00	\N
154	na	\N	2022-03-26 08:29:47.318588+00	\N
155	nr	\N	2022-03-26 08:29:47.322217+00	\N
156	np	\N	2022-03-26 08:29:47.325857+00	\N
157	nl	\N	2022-03-26 08:29:47.329418+00	\N
158	nc	\N	2022-03-26 08:29:47.332824+00	\N
159	nz	\N	2022-03-26 08:29:47.335978+00	\N
160	ni	\N	2022-03-26 08:29:47.339726+00	\N
161	ne	\N	2022-03-26 08:29:47.343063+00	\N
162	ng	\N	2022-03-26 08:29:47.347156+00	\N
163	nu	\N	2022-03-26 08:29:47.350972+00	\N
164	nf	\N	2022-03-26 08:29:47.354686+00	\N
165	mp	\N	2022-03-26 08:29:47.358396+00	\N
166	no	\N	2022-03-26 08:29:47.362212+00	\N
167	om	\N	2022-03-26 08:29:47.366517+00	\N
168	pk	\N	2022-03-26 08:29:47.370886+00	\N
169	pw	\N	2022-03-26 08:29:47.374529+00	\N
170	ps	\N	2022-03-26 08:29:47.378011+00	\N
171	pa	\N	2022-03-26 08:29:47.381649+00	\N
172	pg	\N	2022-03-26 08:29:47.385171+00	\N
173	py	\N	2022-03-26 08:29:47.388725+00	\N
174	pe	\N	2022-03-26 08:29:47.392131+00	\N
175	ph	\N	2022-03-26 08:29:47.395782+00	\N
176	pn	\N	2022-03-26 08:29:47.399487+00	\N
177	pl	\N	2022-03-26 08:29:47.402639+00	\N
178	pt	\N	2022-03-26 08:29:47.406029+00	\N
179	pr	\N	2022-03-26 08:29:47.410521+00	\N
180	qa	\N	2022-03-26 08:29:47.415766+00	\N
181	re	\N	2022-03-26 08:29:47.420111+00	\N
182	ro	\N	2022-03-26 08:29:47.42426+00	\N
183	ru	\N	2022-03-26 08:29:47.428638+00	\N
184	rw	\N	2022-03-26 08:29:47.433259+00	\N
185	bl	\N	2022-03-26 08:29:47.437585+00	\N
186	sh	\N	2022-03-26 08:29:47.441564+00	\N
187	kn	\N	2022-03-26 08:29:47.445613+00	\N
188	lc	\N	2022-03-26 08:29:47.45038+00	\N
189	mf	\N	2022-03-26 08:29:47.455025+00	\N
190	pm	\N	2022-03-26 08:29:47.459102+00	\N
191	vc	\N	2022-03-26 08:29:47.463071+00	\N
192	ws	\N	2022-03-26 08:29:47.467099+00	\N
193	sm	\N	2022-03-26 08:29:47.470707+00	\N
194	st	\N	2022-03-26 08:29:47.47402+00	\N
195	sa	\N	2022-03-26 08:29:47.477253+00	\N
196	sn	\N	2022-03-26 08:29:47.480666+00	\N
197	rs	\N	2022-03-26 08:29:47.484206+00	\N
198	sc	\N	2022-03-26 08:29:47.487345+00	\N
199	sl	\N	2022-03-26 08:29:47.490627+00	\N
200	sg	\N	2022-03-26 08:29:47.494019+00	\N
201	sx	\N	2022-03-26 08:29:47.497362+00	\N
202	sk	\N	2022-03-26 08:29:47.500504+00	\N
203	si	\N	2022-03-26 08:29:47.503596+00	\N
204	sb	\N	2022-03-26 08:29:47.506878+00	\N
205	so	\N	2022-03-26 08:29:47.510074+00	\N
206	za	\N	2022-03-26 08:29:47.513187+00	\N
207	gs	\N	2022-03-26 08:29:47.516559+00	\N
208	ss	\N	2022-03-26 08:29:47.519755+00	\N
209	es	\N	2022-03-26 08:29:47.523085+00	\N
210	lk	\N	2022-03-26 08:29:47.526623+00	\N
211	sd	\N	2022-03-26 08:29:47.53+00	\N
212	sr	\N	2022-03-26 08:29:47.533287+00	\N
213	sj	\N	2022-03-26 08:29:47.536568+00	\N
214	sz	\N	2022-03-26 08:29:47.539942+00	\N
215	se	\N	2022-03-26 08:29:47.543327+00	\N
216	ch	\N	2022-03-26 08:29:47.546678+00	\N
217	sy	\N	2022-03-26 08:29:47.550005+00	\N
218	tw	\N	2022-03-26 08:29:47.553471+00	\N
219	tj	\N	2022-03-26 08:29:47.556655+00	\N
220	tz	\N	2022-03-26 08:29:47.559752+00	\N
221	th	\N	2022-03-26 08:29:47.562835+00	\N
222	tl	\N	2022-03-26 08:29:47.566057+00	\N
223	tg	\N	2022-03-26 08:29:47.56947+00	\N
224	tk	\N	2022-03-26 08:29:47.57327+00	\N
225	to	\N	2022-03-26 08:29:47.577063+00	\N
226	tt	\N	2022-03-26 08:29:47.580703+00	\N
227	tn	\N	2022-03-26 08:29:47.584344+00	\N
228	tr	\N	2022-03-26 08:29:47.588252+00	\N
229	tm	\N	2022-03-26 08:29:47.591667+00	\N
230	tc	\N	2022-03-26 08:29:47.595324+00	\N
231	tv	\N	2022-03-26 08:29:47.598615+00	\N
232	ug	\N	2022-03-26 08:29:47.601933+00	\N
233	ua	\N	2022-03-26 08:29:47.605424+00	\N
234	ae	\N	2022-03-26 08:29:47.609148+00	\N
235	gb	\N	2022-03-26 08:29:47.612879+00	\N
236	us	\N	2022-03-26 08:29:47.616421+00	\N
237	um	\N	2022-03-26 08:29:47.620268+00	\N
238	uy	\N	2022-03-26 08:29:47.623971+00	\N
239	uz	\N	2022-03-26 08:29:47.627935+00	\N
240	vu	\N	2022-03-26 08:29:47.63188+00	\N
241	ve	\N	2022-03-26 08:29:47.635771+00	\N
242	vn	\N	2022-03-26 08:29:47.639331+00	\N
243	vg	\N	2022-03-26 08:29:47.642882+00	\N
244	vi	\N	2022-03-26 08:29:47.646431+00	\N
245	wf	\N	2022-03-26 08:29:47.649855+00	\N
246	eh	\N	2022-03-26 08:29:47.653305+00	\N
247	ye	\N	2022-03-26 08:29:47.656857+00	\N
248	zm	\N	2022-03-26 08:29:47.660206+00	\N
249	zw	\N	2022-03-26 08:29:47.663847+00	\N
\.


--
-- Data for Name: country_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.country_text (country_id, lang_id, title) FROM stdin;
244	1	Virgin Islands, U.S.
245	1	Wallis and Futuna
246	1	Western Sahara
247	1	Yemen
248	1	Zambia
249	1	Zimbabwe
1	1	Afghanistan
2	1	Åland Islands
3	1	Albania
4	1	Algeria
5	1	American Samoa
6	1	Andorra
7	1	Angola
8	1	Anguilla
9	1	Antarctica
10	1	Antigua and Barbuda
11	1	Argentina
12	1	Armenia
13	1	Aruba
14	1	Australia
15	1	Austria
16	1	Azerbaijan
17	1	Bahamas
18	1	Bahrain
19	1	Bangladesh
20	1	Barbados
21	1	Belarus
22	1	Belgium
23	1	Belize
24	1	Benin
25	1	Bermuda
26	1	Bhutan
27	1	Bolivia, Plurinational State of
28	1	Bonaire, Sint Eustatius and Saba
29	1	Bosnia and Herzegovina
30	1	Botswana
31	1	Bouvet Island
32	1	Brazil
33	1	British Indian Ocean Territory
34	1	Brunei Darussalam
35	1	Bulgaria
36	1	Burkina Faso
37	1	Burundi
38	1	Cambodia
39	1	Cameroon
40	1	Canada
41	1	Cape Verde
42	1	Cayman Islands
43	1	Central African Republic
44	1	Chad
45	1	Chile
46	1	China
47	1	Christmas Island
48	1	Cocos (Keeling) Islands
49	1	Colombia
50	1	Comoros
51	1	Congo
52	1	Congo, the Democratic Republic of the
53	1	Cook Islands
54	1	Costa Rica
55	1	Côte d'Ivoire
56	1	Croatia
57	1	Cuba
58	1	Curaçao
59	1	Cyprus
60	1	Czech Republic
61	1	Denmark
62	1	Djibouti
63	1	Dominica
64	1	Dominican Republic
65	1	Ecuador
66	1	Egypt
67	1	El Salvador
68	1	Equatorial Guinea
69	1	Eritrea
70	1	Estonia
71	1	Ethiopia
72	1	Falkland Islands (Malvinas)
73	1	Faroe Islands
74	1	Fiji
75	1	Finland
76	1	France
77	1	French Guiana
78	1	French Polynesia
79	1	French Southern Territories
80	1	Gabon
81	1	Gambia
82	1	Georgia
83	1	Germany
84	1	Ghana
85	1	Gibraltar
86	1	Greece
87	1	Greenland
88	1	Grenada
89	1	Guadeloupe
90	1	Guam
91	1	Guatemala
92	1	Guernsey
93	1	Guinea
94	1	Guinea-Bissau
95	1	Guyana
96	1	Haiti
97	1	Heard Island and McDonald Islands
98	1	Holy See (Vatican City State)
99	1	Honduras
100	1	Hong Kong
101	1	Hungary
102	1	Iceland
103	1	India
104	1	Indonesia
105	1	Iran, Islamic Republic of
106	1	Iraq
107	1	Ireland
108	1	Isle of Man
109	1	Israel
110	1	Italy
111	1	Jamaica
112	1	Japan
113	1	Jersey
114	1	Jordan
115	1	Kazakhstan
116	1	Kenya
117	1	Kiribati
118	1	Korea, Democratic People's Republic of
119	1	Korea, Republic of
120	1	Kuwait
121	1	Kyrgyzstan
122	1	Lao People's Democratic Republic
123	1	Latvia
124	1	Lebanon
125	1	Lesotho
126	1	Liberia
127	1	Libya
128	1	Liechtenstein
129	1	Lithuania
130	1	Luxembourg
131	1	Macao
132	1	Macedonia, the Former Yugoslav Republic of
133	1	Madagascar
134	1	Malawi
135	1	Malaysia
136	1	Maldives
137	1	Mali
138	1	Malta
139	1	Marshall Islands
140	1	Martinique
141	1	Mauritania
142	1	Mauritius
143	1	Mayotte
144	1	Mexico
145	1	Micronesia, Federated States of
146	1	Moldova, Republic of
147	1	Monaco
148	1	Mongolia
149	1	Montenegro
150	1	Montserrat
151	1	Morocco
152	1	Mozambique
153	1	Myanmar
154	1	Namibia
155	1	Nauru
156	1	Nepal
157	1	Netherlands
158	1	New Caledonia
159	1	New Zealand
160	1	Nicaragua
161	1	Niger
162	1	Nigeria
163	1	Niue
164	1	Norfolk Island
165	1	Northern Mariana Islands
166	1	Norway
167	1	Oman
168	1	Pakistan
169	1	Palau
170	1	Palestine, State of
171	1	Panama
172	1	Papua New Guinea
173	1	Paraguay
174	1	Peru
175	1	Philippines
176	1	Pitcairn
177	1	Poland
178	1	Portugal
179	1	Puerto Rico
180	1	Qatar
181	1	Réunion
182	1	Romania
183	1	Russian Federation
184	1	Rwanda
185	1	Saint Barthélemy
186	1	Saint Helena, Ascension and Tristan da Cunha
187	1	Saint Kitts and Nevis
188	1	Saint Lucia
189	1	Saint Martin (French part)
190	1	Saint Pierre and Miquelon
191	1	Saint Vincent and the Grenadines
192	1	Samoa
193	1	San Marino
194	1	Sao Tome and Principe
195	1	Saudi Arabia
196	1	Senegal
197	1	Serbia
198	1	Seychelles
199	1	Sierra Leone
200	1	Singapore
201	1	Sint Maarten (Dutch part)
202	1	Slovakia
203	1	Slovenia
204	1	Solomon Islands
205	1	Somalia
206	1	South Africa
207	1	South Georgia and the South Sandwich Islands
208	1	South Sudan
209	1	Spain
210	1	Sri Lanka
211	1	Sudan
212	1	Suriname
213	1	Svalbard and Jan Mayen
214	1	Swaziland
215	1	Sweden
216	1	Switzerland
217	1	Syrian Arab Republic
218	1	Taiwan, Province of China
219	1	Tajikistan
220	1	Tanzania, United Republic of
221	1	Thailand
222	1	Timor-Leste
223	1	Togo
224	1	Tokelau
225	1	Tonga
226	1	Trinidad and Tobago
227	1	Tunisia
228	1	Turkey
229	1	Turkmenistan
230	1	Turks and Caicos Islands
231	1	Tuvalu
232	1	Uganda
233	1	Ukraine
234	1	United Arab Emirates
235	1	United Kingdom
236	1	United States
237	1	United States Minor Outlying Islands
238	1	Uruguay
239	1	Uzbekistan
240	1	Vanuatu
241	1	Venezuela, Bolivarian Republic of
242	1	Viet Nam
243	1	Virgin Islands, British
\.


--
-- Data for Name: delivery_server_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_server_user (id, email, password, created_at, updated_at) FROM stdin;
3	kirill@sellios.ru	$2a$10$/6UNA6jqvPc/pb8Db3cUje5T6wX0vkhutJ8aDWmnppBHZXVbrmhru	2019-04-04 16:27:26+00	2019-04-04 16:27:26+00
4	kate@sellios.ru	$2a$10$9CW/8ph5QeZCSTr2Pr96sOkzfiRehAbMlfwzO0EkeXPwCmsPtw4BK	2019-04-24 08:37:19+00	2019-04-24 08:37:19+00
\.


--
-- Data for Name: edost_region; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.edost_region (edost_region_id, region_id, title) FROM stdin;
\.


--
-- Data for Name: lang; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lang (lang_id, code, is_backend) FROM stdin;
1	en	t
\.


--
-- Data for Name: payment_gateway; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_gateway (payment_gateway_id, alias, settings, sort) FROM stdin;
1	cashOnDelivery	\N	10
4	paypal	\N	20
\.


--
-- Data for Name: payment_gateway_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_gateway_text (payment_gateway_id, lang_id, title, description) FROM stdin;
1	1	Cash on delivery	Handle payments manually.
4	1	Paypal	\N
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.region (region_id, country_id, vk_id, created_at, deleted_at, kladr_id, fias_id) FROM stdin;
\.


--
-- Data for Name: region_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.region_text (region_id, lang_id, title, pure_title) FROM stdin;
\.


--
-- Data for Name: shipping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping (shipping_id, alias, settings, only_calculation) FROM stdin;
2	selfPickup	\N	f
\.


--
-- Data for Name: shipping_city; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_city (shipping_id, city_id, type, local_id, local_city_title) FROM stdin;
\.


--
-- Data for Name: shipping_country; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_country (shipping_id, country_id, local_id) FROM stdin;
\.


--
-- Data for Name: shipping_option; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_option (option_id, shipping_id, type, alias, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: shipping_option_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_option_text (option_id, lang_id, title) FROM stdin;
\.


--
-- Data for Name: shipping_pickup; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_pickup (point_id, shipping_id, city_id, local_id, coordinate, possibility_to_pay_for_order, deleted_at) FROM stdin;
\.


--
-- Data for Name: shipping_pickup_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_pickup_text (point_id, lang_id, title, address, phone, work_schedule) FROM stdin;
\.


--
-- Data for Name: shipping_tariff; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_tariff (tariff_id, shipping_id, local_id, type, service_group, postomat, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: shipping_tariff_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_tariff_text (tariff_id, lang_id, title) FROM stdin;
\.


--
-- Data for Name: shipping_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_text (shipping_id, lang_id, title) FROM stdin;
2	1	Self pickup
\.


--
-- Data for Name: shipping_zip; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_zip (shipping_id, zip_id, courier) FROM stdin;
\.


--
-- Data for Name: sms_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sms_provider (provider_id, alias) FROM stdin;
1	unisender
2	smspilot
\.


--
-- Data for Name: theme; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.theme (theme_id, alias, is_default, sort, preview, created_at, deleted_at) FROM stdin;
7	moon	t	0	images/themes/moon.jpg	2018-03-12 14:34:48.737691+00	\N
6	marsFull	f	10	images/themes/mars-full-screen.jpg	2017-11-20 16:18:13.351052+00	\N
5	venus	f	20	images/themes/venus.jpg	2017-04-12 14:08:38.208443+00	\N
3	mercury	f	30	images/themes/mercury.jpg	2017-04-12 14:08:34.310386+00	\N
4	mars	f	40	images/themes/mars.jpg	2017-04-12 14:08:38.085649+00	\N
8	neptune	f	5	images/themes/neptune.jpg	2019-11-18 15:47:17.914992+00	\N
\.


--
-- Data for Name: theme_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.theme_text (theme_id, lang_id, title, description) FROM stdin;
3	1	Меркурий	\N
4	1	Марс	\N
5	1	Венера	\N
6	1	Марс (полноэкранная)	\N
7	1	Луна	\N
8	1	Нептун	\N
\.


--
-- Data for Name: unparseds; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.unparseds (id, delivery, local_id, city, processed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: zip; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.zip (zip_id, country_id, city_id, zip) FROM stdin;
\.


--
-- Name: action_log_action_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.action_log_action_id_seq', 143564, true);


--
-- Name: adonis_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.adonis_schema_id_seq', 6, true);


--
-- Name: area_area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.area_area_id_seq', 7989, true);


--
-- Name: background_background_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.background_background_id_seq', 22, true);


--
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.city_city_id_seq', 1450403, true);


--
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.country_country_id_seq', 249, true);


--
-- Name: delivery_server_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_server_user_id_seq', 4, true);


--
-- Name: edost_region_edost_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.edost_region_edost_region_id_seq', 1033, true);


--
-- Name: lang_lang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lang_lang_id_seq', 3, true);


--
-- Name: payment_gateway_payment_gateway_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_gateway_payment_gateway_id_seq', 4, true);


--
-- Name: pickup_point_point_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pickup_point_point_id_seq', 119871, true);


--
-- Name: region_region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.region_region_id_seq', 11350, true);


--
-- Name: shipping_option_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shipping_option_option_id_seq', 17, true);


--
-- Name: shipping_shipping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shipping_shipping_id_seq', 5, true);


--
-- Name: shipping_tariff_tariff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shipping_tariff_tariff_id_seq', 6, true);


--
-- Name: sms_provider_provider_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sms_provider_provider_id_seq', 2, true);


--
-- Name: theme_theme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.theme_theme_id_seq', 8, true);


--
-- Name: unparseds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.unparseds_id_seq', 57293, true);


--
-- Name: zip_zip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.zip_zip_id_seq', 429746, true);


--
-- Name: action_log action_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.action_log
    ADD CONSTRAINT action_log_pkey PRIMARY KEY (action_id);


--
-- Name: adonis_schema adonis_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adonis_schema
    ADD CONSTRAINT adonis_schema_pkey PRIMARY KEY (id);


--
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (area_id);


--
-- Name: area_text area_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_text
    ADD CONSTRAINT area_text_pkey PRIMARY KEY (area_id, lang_id);


--
-- Name: background background_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background
    ADD CONSTRAINT background_pkey PRIMARY KEY (background_id);


--
-- Name: background_text background_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background_text
    ADD CONSTRAINT background_text_pkey PRIMARY KEY (background_id, lang_id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- Name: city_text city_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city_text
    ADD CONSTRAINT city_text_pkey PRIMARY KEY (city_id, lang_id);


--
-- Name: city city_vk_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_vk_id_key UNIQUE (vk_id);


--
-- Name: country country_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_code_key UNIQUE (code);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- Name: country_text country_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country_text
    ADD CONSTRAINT country_text_pkey PRIMARY KEY (country_id, lang_id);


--
-- Name: country country_vk_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_vk_id_key UNIQUE (vk_id);


--
-- Name: delivery_server_user delivery_server_user_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_server_user
    ADD CONSTRAINT delivery_server_user_email_unique UNIQUE (email);


--
-- Name: delivery_server_user delivery_server_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_server_user
    ADD CONSTRAINT delivery_server_user_pkey PRIMARY KEY (id);


--
-- Name: edost_region edost_region_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edost_region
    ADD CONSTRAINT edost_region_pkey PRIMARY KEY (edost_region_id);


--
-- Name: edost_region edost_region_region_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edost_region
    ADD CONSTRAINT edost_region_region_id_key UNIQUE (region_id);


--
-- Name: lang lang_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lang
    ADD CONSTRAINT lang_code_key UNIQUE (code);


--
-- Name: lang lang_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lang
    ADD CONSTRAINT lang_pkey PRIMARY KEY (lang_id);


--
-- Name: payment_gateway payment_gateway_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_gateway
    ADD CONSTRAINT payment_gateway_alias_key UNIQUE (alias);


--
-- Name: payment_gateway payment_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_gateway
    ADD CONSTRAINT payment_gateway_pkey PRIMARY KEY (payment_gateway_id);


--
-- Name: payment_gateway_text payment_gateway_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_gateway_text
    ADD CONSTRAINT payment_gateway_text_pkey PRIMARY KEY (payment_gateway_id, lang_id);


--
-- Name: shipping_pickup pickup_point_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_pickup
    ADD CONSTRAINT pickup_point_pkey PRIMARY KEY (point_id);


--
-- Name: shipping_pickup_text pickup_point_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_pickup_text
    ADD CONSTRAINT pickup_point_text_pkey PRIMARY KEY (point_id, lang_id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (region_id);


--
-- Name: region_text region_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region_text
    ADD CONSTRAINT region_text_pkey PRIMARY KEY (region_id, lang_id);


--
-- Name: region region_vk_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_vk_id_key UNIQUE (vk_id);


--
-- Name: shipping shipping_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping
    ADD CONSTRAINT shipping_alias_key UNIQUE (alias);


--
-- Name: shipping_city shipping_city_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_city
    ADD CONSTRAINT shipping_city_pkey PRIMARY KEY (shipping_id, city_id);


--
-- Name: shipping_city shipping_city_shipping_id_local_id_unique_constraint; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_city
    ADD CONSTRAINT shipping_city_shipping_id_local_id_unique_constraint UNIQUE (shipping_id, local_id);


--
-- Name: shipping_country shipping_country_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_country
    ADD CONSTRAINT shipping_country_pkey PRIMARY KEY (shipping_id, country_id);


--
-- Name: shipping_option shipping_option_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_pkey PRIMARY KEY (option_id);


--
-- Name: shipping_option_text shipping_option_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option_text
    ADD CONSTRAINT shipping_option_text_pkey PRIMARY KEY (option_id, lang_id);


--
-- Name: shipping shipping_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping
    ADD CONSTRAINT shipping_pkey PRIMARY KEY (shipping_id);


--
-- Name: shipping_tariff shipping_tariff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_tariff
    ADD CONSTRAINT shipping_tariff_pkey PRIMARY KEY (tariff_id);


--
-- Name: shipping_text shipping_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_text
    ADD CONSTRAINT shipping_text_pkey PRIMARY KEY (shipping_id, lang_id);


--
-- Name: shipping_zip shipping_zip_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_zip
    ADD CONSTRAINT shipping_zip_pkey PRIMARY KEY (shipping_id, zip_id);


--
-- Name: sms_provider sms_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sms_provider
    ADD CONSTRAINT sms_provider_pkey PRIMARY KEY (provider_id);


--
-- Name: theme theme_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme
    ADD CONSTRAINT theme_alias_key UNIQUE (alias);


--
-- Name: theme theme_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme
    ADD CONSTRAINT theme_pkey PRIMARY KEY (theme_id);


--
-- Name: unparseds unparseds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unparseds
    ADD CONSTRAINT unparseds_pkey PRIMARY KEY (id);


--
-- Name: zip zip_country_id_zip_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zip
    ADD CONSTRAINT zip_country_id_zip_key UNIQUE (country_id, zip);


--
-- Name: zip zip_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zip
    ADD CONSTRAINT zip_pkey PRIMARY KEY (zip_id);


--
-- Name: action_log_action_text_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_action_text_idx ON public.action_log USING btree (action_text);


--
-- Name: action_log_from_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_from_idx ON public.action_log USING btree ("from");


--
-- Name: action_log_object_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_object_id_idx ON public.action_log USING btree (object_id);


--
-- Name: action_log_object_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_object_type_idx ON public.action_log USING btree (object_type);


--
-- Name: action_log_reason_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_reason_idx ON public.action_log USING btree (reason);


--
-- Name: action_log_subject_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_subject_id_idx ON public.action_log USING btree (subject_id);


--
-- Name: action_log_subject_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_subject_type_idx ON public.action_log USING btree (subject_type);


--
-- Name: action_log_to_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_to_idx ON public.action_log USING btree ("to");


--
-- Name: action_log_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX action_log_type_idx ON public.action_log USING btree (type);


--
-- Name: area_fias_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX area_fias_id_index ON public.area USING btree (fias_id);


--
-- Name: area_kladr_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX area_kladr_id_idx ON public.area USING btree (kladr_id);


--
-- Name: area_kladr_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX area_kladr_id_index ON public.area USING btree (kladr_id);


--
-- Name: area_region_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX area_region_id_deleted_at_idx ON public.area USING btree (region_id, deleted_at);


--
-- Name: city_country_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX city_country_id_deleted_at_idx ON public.city USING btree (country_id, deleted_at);


--
-- Name: city_country_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX city_country_id_idx ON public.city USING btree (country_id) WHERE (deleted_at IS NULL);


--
-- Name: city_country_id_is_important_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX city_country_id_is_important_deleted_at_idx ON public.city USING btree (country_id, is_important, deleted_at) WHERE ((is_important IS TRUE) AND (deleted_at IS NULL));


--
-- Name: city_fias_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX city_fias_id_index ON public.city USING btree (fias_id);


--
-- Name: city_kladr_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX city_kladr_id_idx ON public.city USING btree (kladr_id);


--
-- Name: city_kladr_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX city_kladr_id_index ON public.city USING btree (kladr_id);


--
-- Name: city_text_lang_id_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX city_text_lang_id_lower_idx ON public.city_text USING gin (lang_id, lower(title) public.gin_trgm_ops);


--
-- Name: city_text_lang_id_lower_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX city_text_lang_id_lower_idx1 ON public.city_text USING btree (lang_id, lower(title));


--
-- Name: country_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX country_deleted_at_idx ON public.country USING btree (deleted_at);


--
-- Name: pickup_point_shipping_id_local_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pickup_point_shipping_id_local_id_idx ON public.shipping_pickup USING btree (shipping_id, local_id);


--
-- Name: region_country_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX region_country_id_deleted_at_idx ON public.region USING btree (country_id, deleted_at);


--
-- Name: region_fias_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX region_fias_id_index ON public.region USING btree (fias_id);


--
-- Name: region_kladr_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX region_kladr_id_idx ON public.region USING btree (kladr_id);


--
-- Name: region_kladr_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX region_kladr_id_index ON public.region USING btree (kladr_id);


--
-- Name: region_text_lang_id_title_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX region_text_lang_id_title_idx ON public.region_text USING btree (lang_id, title);


--
-- Name: shipping_country_shipping_id_local_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX shipping_country_shipping_id_local_id_idx ON public.shipping_country USING btree (shipping_id, local_id);


--
-- Name: shipping_pickup_shipping_id_city_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX shipping_pickup_shipping_id_city_id_idx ON public.shipping_pickup USING btree (shipping_id, city_id);


--
-- Name: shipping_zip_shipping_id_courier_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX shipping_zip_shipping_id_courier_idx ON public.shipping_zip USING btree (shipping_id, courier);


--
-- Name: theme_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX theme_deleted_at_idx ON public.theme USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: theme_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX theme_is_default_idx ON public.theme USING btree (is_default) WHERE (is_default IS TRUE);


--
-- Name: unparseds_delivery_local_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unparseds_delivery_local_id_idx ON public.unparseds USING btree (delivery, local_id);


--
-- Name: area area_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER area_after_insert AFTER INSERT ON public.area FOR EACH ROW EXECUTE FUNCTION public.area_after_insert();


--
-- Name: background background_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER background_after_insert AFTER INSERT ON public.background FOR EACH ROW EXECUTE FUNCTION public.background_after_insert();


--
-- Name: city city_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER city_after_insert AFTER INSERT ON public.city FOR EACH ROW EXECUTE FUNCTION public.city_after_insert();


--
-- Name: country country_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER country_after_insert AFTER INSERT ON public.country FOR EACH ROW EXECUTE FUNCTION public.country_after_insert();


--
-- Name: payment_gateway payment_gateway_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER payment_gateway_after_insert AFTER INSERT ON public.payment_gateway FOR EACH ROW EXECUTE FUNCTION public.payment_gateway_after_insert();


--
-- Name: region region_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER region_after_insert AFTER INSERT ON public.region FOR EACH ROW EXECUTE FUNCTION public.region_after_insert();


--
-- Name: shipping shipping_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER shipping_after_insert AFTER INSERT ON public.shipping FOR EACH ROW EXECUTE FUNCTION public.shipping_after_insert();


--
-- Name: shipping_option shipping_option_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER shipping_option_after_insert AFTER INSERT ON public.shipping_option FOR EACH ROW EXECUTE FUNCTION public.shipping_option_after_insert();


--
-- Name: shipping_pickup shipping_pickup_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER shipping_pickup_after_insert AFTER INSERT ON public.shipping_pickup FOR EACH ROW EXECUTE FUNCTION public.shipping_pickup_after_insert();


--
-- Name: shipping_tariff shipping_tariff_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER shipping_tariff_after_insert AFTER INSERT ON public.shipping_tariff FOR EACH ROW EXECUTE FUNCTION public.shipping_tariff_after_insert();


--
-- Name: shipping_zip shipping_zip_after_insert_city_courier; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER shipping_zip_after_insert_city_courier AFTER INSERT ON public.shipping_zip FOR EACH ROW EXECUTE FUNCTION public.shipping_zip_city_courier();


--
-- Name: shipping_zip shipping_zip_after_update_city_courier; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER shipping_zip_after_update_city_courier AFTER UPDATE ON public.shipping_zip FOR EACH ROW EXECUTE FUNCTION public.shipping_zip_city_courier();


--
-- Name: theme theme_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER theme_after_insert AFTER INSERT ON public.theme FOR EACH ROW EXECUTE FUNCTION public.theme_after_insert();


--
-- Name: area area_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.region(region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: area_text area_text_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_text
    ADD CONSTRAINT area_text_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(area_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: area_text area_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.area_text
    ADD CONSTRAINT area_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: background_text background_text_background_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background_text
    ADD CONSTRAINT background_text_background_id_fkey FOREIGN KEY (background_id) REFERENCES public.background(background_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: background_text background_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.background_text
    ADD CONSTRAINT background_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: city city_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(area_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: city city_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: city city_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.region(region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: city_text city_text_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city_text
    ADD CONSTRAINT city_text_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: city_text city_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city_text
    ADD CONSTRAINT city_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: country_text country_text_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country_text
    ADD CONSTRAINT country_text_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: country_text country_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country_text
    ADD CONSTRAINT country_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: edost_region edost_region_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.edost_region
    ADD CONSTRAINT edost_region_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.region(region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_gateway_text payment_gateway_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_gateway_text
    ADD CONSTRAINT payment_gateway_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_gateway_text payment_gateway_text_payment_gateway_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_gateway_text
    ADD CONSTRAINT payment_gateway_text_payment_gateway_id_fkey FOREIGN KEY (payment_gateway_id) REFERENCES public.payment_gateway(payment_gateway_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_pickup pickup_point_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_pickup
    ADD CONSTRAINT pickup_point_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_pickup pickup_point_shipping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_pickup
    ADD CONSTRAINT pickup_point_shipping_id_fkey FOREIGN KEY (shipping_id) REFERENCES public.shipping(shipping_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_pickup_text pickup_point_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_pickup_text
    ADD CONSTRAINT pickup_point_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_pickup_text pickup_point_text_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_pickup_text
    ADD CONSTRAINT pickup_point_text_point_id_fkey FOREIGN KEY (point_id) REFERENCES public.shipping_pickup(point_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: region region_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: region_text region_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region_text
    ADD CONSTRAINT region_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: region_text region_text_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.region_text
    ADD CONSTRAINT region_text_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.region(region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_city shipping_city_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_city
    ADD CONSTRAINT shipping_city_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_city shipping_city_shipping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_city
    ADD CONSTRAINT shipping_city_shipping_id_fkey FOREIGN KEY (shipping_id) REFERENCES public.shipping(shipping_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_country shipping_country_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_country
    ADD CONSTRAINT shipping_country_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_country shipping_country_shipping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_country
    ADD CONSTRAINT shipping_country_shipping_id_fkey FOREIGN KEY (shipping_id) REFERENCES public.shipping(shipping_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option shipping_option_shipping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option
    ADD CONSTRAINT shipping_option_shipping_id_fkey FOREIGN KEY (shipping_id) REFERENCES public.shipping(shipping_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option_text shipping_option_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option_text
    ADD CONSTRAINT shipping_option_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_option_text shipping_option_text_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_option_text
    ADD CONSTRAINT shipping_option_text_option_id_fkey FOREIGN KEY (option_id) REFERENCES public.shipping_option(option_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_tariff shipping_tariff_shipping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_tariff
    ADD CONSTRAINT shipping_tariff_shipping_id_fkey FOREIGN KEY (shipping_id) REFERENCES public.shipping(shipping_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_tariff_text shipping_tariff_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_tariff_text
    ADD CONSTRAINT shipping_tariff_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_tariff_text shipping_tariff_text_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_tariff_text
    ADD CONSTRAINT shipping_tariff_text_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.shipping_tariff(tariff_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_text shipping_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_text
    ADD CONSTRAINT shipping_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_text shipping_text_shipping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_text
    ADD CONSTRAINT shipping_text_shipping_id_fkey FOREIGN KEY (shipping_id) REFERENCES public.shipping(shipping_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_zip shipping_zip_shipping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_zip
    ADD CONSTRAINT shipping_zip_shipping_id_fkey FOREIGN KEY (shipping_id) REFERENCES public.shipping(shipping_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: shipping_zip shipping_zip_zip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_zip
    ADD CONSTRAINT shipping_zip_zip_id_fkey FOREIGN KEY (zip_id) REFERENCES public.zip(zip_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: theme_text theme_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme_text
    ADD CONSTRAINT theme_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: theme_text theme_text_theme_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme_text
    ADD CONSTRAINT theme_text_theme_id_fkey FOREIGN KEY (theme_id) REFERENCES public.theme(theme_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: zip zip_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.zip
    ADD CONSTRAINT zip_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

