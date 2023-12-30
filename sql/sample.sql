--
-- PostgreSQL database dump
--

-- Dumped from database version 13.13 (Debian 13.13-1.pgdg120+1)
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
-- Name: intarray; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS intarray WITH SCHEMA public;


--
-- Name: EXTENSION intarray; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION intarray IS 'functions, operators, and index support for 1-D arrays of integers';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: postgres_fdw; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgres_fdw WITH SCHEMA public;


--
-- Name: EXTENSION postgres_fdw; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION postgres_fdw IS 'foreign-data wrapper for remote PostgreSQL servers';


--
-- Name: address_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.address_type AS ENUM (
    'billing',
    'shipping'
);


--
-- Name: attrs_html_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.attrs_html_type AS ENUM (
    'text',
    'text_area',
    'checkbox',
    'dropdown'
);


--
-- Name: publishing_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.publishing_status AS ENUM (
    'draft',
    'published',
    'hidden'
);


--
-- Name: category_child_row; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.category_child_row AS (
	category_id integer,
	parent_id integer,
	lang_id integer,
	title text,
	url_key public.citext,
	tree_sort text,
	level integer,
	deleted_at timestamp with time zone,
	custom_link character varying(255),
	status public.publishing_status,
	image_id integer
);


--
-- Name: characteristic_system_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.characteristic_system_type AS ENUM (
    'length',
    'width',
    'height',
    'weight',
    'size'
);


--
-- Name: characteristic_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.characteristic_type AS ENUM (
    'checkbox',
    'radio',
    'select',
    'text',
    'textarea',
    'wysiwyg'
);


--
-- Name: city_option_extended_row; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.city_option_extended_row AS (
	id integer,
	city_title text,
	region_title text,
	area_title text
);


--
-- Name: delivery_calc_method; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.delivery_calc_method AS ENUM (
    'byShippingService',
    'byEdost',
    'byOwnRates',
    'single'
);


--
-- Name: discount_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.discount_type AS ENUM (
    'fixed',
    'percent'
);


--
-- Name: essence_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.essence_type AS ENUM (
    'orders'
);


--
-- Name: feed_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.feed_type AS ENUM (
    'google-shopping',
    'facebook'
);


--
-- Name: filter_field_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.filter_field_type AS ENUM (
    'category',
    'brand',
    'price',
    'availability',
    'characteristic'
);


--
-- Name: form_entry_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.form_entry_status AS ENUM (
    'new',
    'completed',
    'cancelled'
);


--
-- Name: form_field_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.form_field_type AS ENUM (
    'text',
    'email',
    'checkbox',
    'checkbox-list',
    'radio',
    'select',
    'textarea',
    'file'
);


--
-- Name: image_used_in; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.image_used_in AS ENUM (
    'page',
    'category',
    'product',
    'manufacturer',
    'carousel',
    'instagram',
    'textWithIcons',
    'background',
    'blog',
    'form',
    'wysiwyg',
    'theme'
);


--
-- Name: import_file_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.import_file_type AS ENUM (
    'zip',
    'xml'
);


--
-- Name: import_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.import_status AS ENUM (
    'uploading',
    'new',
    'queued',
    'in_progress',
    'success',
    'error'
);


--
-- Name: import_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.import_type AS ENUM (
    '1c_catalog',
    '1c_sale'
);


--
-- Name: inventory_option_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.inventory_option_category AS ENUM (
    'changeQty',
    'systemChangeQty'
);


--
-- Name: menu_item_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.menu_item_type AS ENUM (
    'folder',
    'page',
    'category',
    'product',
    'url'
);


--
-- Name: notification_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.notification_type AS ENUM (
    'orderReviewRequest'
);


--
-- Name: notify_transport; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.notify_transport AS ENUM (
    'email'
);


--
-- Name: order_discount_source; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.order_discount_source AS ENUM (
    'manual',
    'coupon'
);


--
-- Name: order_status_stock_location; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.order_status_stock_location AS ENUM (
    'inside',
    'outside',
    'basket'
);


--
-- Name: page_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.page_type AS ENUM (
    'page',
    'folder',
    'landing'
);


--
-- Name: parcel_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.parcel_status AS ENUM (
    'new',
    'processing',
    'act_created'
);


--
-- Name: payment_transaction_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.payment_transaction_status AS ENUM (
    'created',
    'awaitingForCallback',
    'completed',
    'cancelled',
    'exception'
);


--
-- Name: product_import_image_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_import_image_status AS ENUM (
    'new',
    'downloaded',
    'error'
);


--
-- Name: product_import_rel_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_import_rel_status AS ENUM (
    'created',
    'updated',
    'error',
    'appendVariant',
    'updateVariant'
);


--
-- Name: product_import_run_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_import_run_type AS ENUM (
    'once',
    'cron'
);


--
-- Name: product_import_source_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_import_source_type AS ENUM (
    'file',
    'url'
);


--
-- Name: product_import_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_import_status AS ENUM (
    'awaiting_download',
    'downloading',
    'awaiting_setup',
    'ready_for_import',
    'in_progress',
    'success',
    'error'
);


--
-- Name: product_import_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_import_type AS ENUM (
    'csv',
    'excel',
    'yml'
);


--
-- Name: product_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_type AS ENUM (
    'digital',
    'material'
);


--
-- Name: product_variant_characteristic_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.product_variant_characteristic_type AS ENUM (
    'variant',
    'redefine'
);


--
-- Name: publication_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.publication_status AS ENUM (
    'published',
    'draft'
);


--
-- Name: queue_event_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.queue_event_type AS ENUM (
    'created',
    'updated'
);


--
-- Name: setting_group; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.setting_group AS ENUM (
    'inventory',
    'system',
    'orders',
    'delivery',
    'catalog',
    'aws',
    'mail',
    'cms',
    'exchange'
);


--
-- Name: sms_event_alias; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.sms_event_alias AS ENUM (
    'order_status_change'
);


--
-- Name: sms_log_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.sms_log_status AS ENUM (
    'success',
    'error'
);


--
-- Name: space_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.space_type AS ENUM (
    's3',
    'db'
);


--
-- Name: sub_category_policy; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.sub_category_policy AS ENUM (
    'subGoods',
    'subCategories',
    'subCategoriesNoLeftMenu'
);


--
-- Name: tax_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.tax_status AS ENUM (
    'taxable',
    'none'
);


--
-- Name: transfer_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.transfer_status AS ENUM (
    'draft',
    'completed',
    'cancelled'
);


--
-- Name: typearea_block_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.typearea_block_type AS ENUM (
    'text'
);


--
-- Name: basket_add_item(integer, integer, integer, integer, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.basket_add_item(__basket_id integer, __item_id integer, __qty integer, __price_id integer, __basic_price numeric, __final_price numeric, __discount_amount numeric, __discount_percent numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare
		__basket_item_id integer;
		__item_price_id integer;
		__deleted_at timestamp with time zone;
	begin
		select
			basket_item_id, deleted_at
			into __basket_item_id, __deleted_at
		from
			basket_item
		where
			basket_id = __basket_id
			and item_id = __item_id
		;

		if __basket_item_id is not null then
			if __deleted_at is null then
				update
					basket_item
				set
					qty = qty + __qty,
					deleted_at = null
				where
					basket_item_id = __basket_item_id
				;
			else
				insert into item_price
					(price_id, basic_price, final_price, discount_amount, discount_percent)
				values
					(__price_id, __basic_price, __final_price, __discount_amount, __discount_percent) returning item_price_id into __item_price_id;

				update
					basket_item
				set
					qty = __qty,
					deleted_at = null,
					item_price_id = __item_price_id
				where
					basket_item_id = __basket_item_id
				;
			end if;
		else
			insert into item_price
				(price_id, basic_price, final_price, discount_amount, discount_percent)
			values
				(__price_id, __basic_price, __final_price, __discount_amount, __discount_percent) returning item_price_id into __item_price_id;

			insert into basket_item
				(basket_id, item_id, qty, item_price_id)
			values
				(__basket_id, __item_id, __qty, __item_price_id);
		end if;
	end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: basket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.basket (
    basket_id integer NOT NULL,
    person_id integer,
    is_active boolean DEFAULT true NOT NULL,
    public_id uuid DEFAULT gen_random_uuid(),
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: basket_get(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.basket_get(__person_id integer) RETURNS SETOF public.basket
    LANGUAGE plpgsql
    AS $$
	begin
		insert into basket
			(person_id, is_active)
		select
			__person_id, true
		where
			not exists (
				select
					1
				from
					basket
				where
					person_id = __person_id
					and is_active is true
			);

		return query
			select * from basket where person_id = __person_id and is_active is true;
	end;
$$;


--
-- Name: box_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.box_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ begin insert into box_text (box_id, lang_id) select new.box_id, lang_id from lang; return new; end; $$;


--
-- Name: category_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.category_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into category_text (category_id, lang_id)
		select
			NEW.category_id,
			lang_id
		from
			lang;

		insert into category_prop
			(category_id)
		values
			(new.category_id);

		return NEW;
	end;
$$;


--
-- Name: category_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.category_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = category_get_next_sort(new.site_id, new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: category_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.category_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = category_get_next_sort(new.site_id, new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: category_get_children(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.category_get_children(__category_id integer) RETURNS SETOF public.category_child_row
    LANGUAGE plpgsql
    AS $$
				declare
					r category_child_row%rowtype;
				begin
					for r in
						with recursive category_children as (
							select
								category_id,
								parent_id,
								lang_id,
								title,
								url_key,
								to_char(category.sort, 'FM00000000'::text) AS tree_sort,
								0 as level,
								deleted_at,
								category_prop.custom_link,
								status,
								image_id
							from
								category
								inner join category_text using(category_id)
								inner join category_prop using(category_id)
							where
								parent_id = __category_id
							union all
							select
								c.category_id,
								c.parent_id,
								ct.lang_id,
								ct.title,
								ct.url_key,
								(vw.tree_sort || '.'::text) || to_char(c.sort, 'FM00000000'::text) AS tree_sort,
								vw.level + 1,
								c.deleted_at,
								cp.custom_link,
								c.status,
								c.image_id
							from
								category c
								inner join category_children vw on vw.category_id = c.parent_id
								inner join category_text ct on c.category_id = ct.category_id and ct.lang_id = vw.lang_id
								inner join category_prop cp on c.category_id = cp.category_id
							where
								vw.level < 15
						) select * from category_children
					loop
						return next r;
					end loop;

					return;
				end;
			$$;


--
-- Name: category_get_next_sort(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.category_get_next_sort(siteid integer, parentid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare
		nextSortSql text = 'select coalesce(max(sort),0)+1 from category where site_id = $1 and parent_id';
		nextSort int;
	begin
			if parentId is null then
				nextSortSql = nextSortSql || ' is null';
			else
				nextSortSql = nextSortSql || '=$2';
			end if;

			execute nextSortSql into nextSort using siteId, parentId;

		return nextSort;
	end;
$_$;


--
-- Name: category_get_parents(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.category_get_parents(__category_id integer) RETURNS SETOF public.category_child_row
    LANGUAGE plpgsql
    AS $$
				declare
					r category_child_row%rowtype;
				begin
					for r in
						with recursive category_parents as (
							select
								category_id,
								parent_id,
								lang_id,
								title,
								url_key,
								to_char(category.sort, 'FM00000000'::text) AS tree_sort,
								0 as level,
								deleted_at,
								category_prop.custom_link,
								status,
								image_id
							from
								category
								inner join category_text using(category_id)
								inner join category_prop using(category_id)
							where
								category_id = __category_id
							union all
							select
								c.category_id,
								c.parent_id,
								ct.lang_id,
								ct.title,
								ct.url_key,
								(vw.tree_sort || '.'::text) || to_char(c.sort, 'FM00000000'::text) AS tree_sort,
								vw.level + 1,
								c.deleted_at,
								cp.custom_link,
								c.status,
								c.image_id
							from
								category c
								inner join category_parents vw on vw.parent_id = c.category_id
								inner join category_text ct on c.category_id = ct.category_id and ct.lang_id = vw.lang_id
								inner join category_prop cp on c.category_id = cp.category_id
							where
								vw.level < 15
						) select * from category_parents
					loop
						return next r;
					end loop;

					return;
				end;
			$$;


--
-- Name: category_init(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.category_init() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into category_text (category_id, lang_id)
		select
			NEW.category_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: characteristic_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into characteristic_text (characteristic_id, lang_id)
		select
			NEW.characteristic_id,
			lang_id
		from
			lang;

		insert into characteristic_prop (characteristic_id) values (NEW.characteristic_id);

		return NEW;
	end;
$$;


--
-- Name: characteristic_before_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_before_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		update
			characteristic
		set
			parent_id = null
		where
			parent_id = old.characteristic_id
			and characteristic_id in (
				select
					characteristic_id
				from
					characteristic_variant_val
				where
					rel_type = 'variant'
			);


		-- needs to safely remove characteristics with parent_id
		delete from
			characteristic_variant_val
		where
			(
				characteristic_id in (
					select characteristic_id from characteristic where parent_id = old.characteristic_id
				)
				or
				characteristic_id = old.characteristic_id
			)
			and rel_type = 'redefine';

		return old;
	end;
$$;


--
-- Name: characteristic_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__parentId int;
	begin
		if new.sort is null then
		      new.sort = characteristic_get_next_sort(new.group_id, new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: characteristic_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if old.type != new.type then
			if exists(
				select
					value_id
				from
					characteristic_variant_val
				where
					characteristic_id = new.characteristic_id
					and rel_type = 'variant'
			) then
				raise exception 'Cannot change type for characteristic_id="%" - it is in variant.', new.characteristic_id;
			end if;
		end if;

		return new;
	end;
$$;


--
-- Name: characteristic_get_next_sort(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_get_next_sort(groupid integer, parentid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare
		nextSortSql text = 'select coalesce(max(sort),0)+10 from characteristic where group_id = $1 and parent_id';
		nextSort int;
	begin
			if parentId is null then
				nextSortSql = nextSortSql || ' is null';
			else
				nextSortSql = nextSortSql || '=$2';
			end if;

			execute nextSortSql into nextSort using groupId, parentId;

		return nextSort;
	end;
$_$;


--
-- Name: characteristic_product_val_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_product_val_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into characteristic_product_val_text (value_id, lang_id)
		select
			NEW.value_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: characteristic_type_case_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_type_case_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into characteristic_type_case_text (case_id, lang_id)
		select
			NEW.case_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: characteristic_type_case_before_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_type_case_before_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		_valId int;
	begin
		select
			value_id into _valId
		from
			characteristic_variant_val
		where
			case_id = old.case_id
			and rel_type = 'variant';

		if _valId is not null then
			raise EXCEPTION 'Cannot delete typeCase since it has relation in variant!';
		end if;

		return old;
	end;
$$;


--
-- Name: characteristic_type_case_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_type_case_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
			new.sort = (
				select
					coalesce(max(sort), 0) + 10
				from
					characteristic_type_case
				where
					characteristic_id = new.characteristic_id
			);
		end if;

		return new;
	end;
$$;


--
-- Name: characteristic_type_case_text_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_type_case_text_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	update
		variant_text
	set
		title = source_title.title
	from
		(
			select
				variant_id,
				lang_id,
				string_agg(characteristic_type_case_text.title, ' - ' order by value_id asc) as title
			from
				variant
				inner join characteristic_variant_val using(variant_id)
				inner join characteristic_type_case_text using(case_id)
			where
				rel_type = 'variant'
			group by
				variant_id,
				lang_id
		) as source_title
	where
		variant_text.variant_id = source_title.variant_id
		and variant_text.lang_id = source_title.lang_id
		and variant_text.variant_id in (
			select
				variant_id
			from
				characteristic_variant_val
			where
				case_id = new.case_id
				and rel_type = 'variant'
		);

	return NEW;
end;
$$;


--
-- Name: characteristic_variant_val_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_variant_val_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare _cases int[];
begin
	if old.rel_type = 'variant' and old.case_id is not null then
		select
			cases into _cases
		from
			variant
		where
			variant_id = old.variant_id;

		if _cases is not null then
			_cases := array_remove(_cases, old.case_id);
			update
				variant
			set
				cases = _cases
			where
				variant_id = old.variant_id;
		end if;

		execute variant_set_title(old.variant_id);
	end if;

	return old;
end;
$$;


--
-- Name: characteristic_variant_val_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_variant_val_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	insert into characteristic_variant_val_text (value_id, lang_id)
	select
		NEW.value_id,
		lang_id
	from
		lang;

	if new.case_id is not null then
		update
			variant
		set
			cases = uniq(array_append(cases, new.case_id))
		where
			variant_id = new.variant_id;

		execute variant_set_title(new.variant_id);
	end if;

	return NEW;
end;
$$;


--
-- Name: characteristic_variant_val_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_variant_val_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare _cases int[];
begin
	if new.case_id != old.case_id and new.case_id is not null then
		select
			cases into _cases
		from
			variant
		where
			variant_id = new.variant_id;

		_cases := array_remove(_cases, old.case_id);
		_cases := uniq(array_append(_cases, new.case_id));

		update variant set cases = _cases where variant_id = new.variant_id;

		execute variant_set_title(new.variant_id);
	end if;

	return NEW;
end;
$$;


--
-- Name: characteristic_variant_val_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.characteristic_variant_val_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.variant_id != old.variant_id then
			raise exception 'VariantId cannot be changed due to triggers logic. Use delete/insert.';
		end if;

		return NEW;
	end;
$$;


--
-- Name: city_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.city_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

	begin
		if old.deleted_at is null then
			perform country_change_city_qty(old.country_id, old.is_important, -1);
		end if;

		return NEW;
	end;
$$;


--
-- Name: city_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.city_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.country_id != old.country_id then
			perform country_update_city_qty(old.country_id);
		end if;

		perform country_update_city_qty(new.country_id);

		return NEW;
	end;
$$;


--
-- Name: commodity_group_before_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.commodity_group_before_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		update
			characteristic
		set
			group_id = null
		where
			group_id = old.group_id
			and characteristic_id in (
				select characteristic_id from characteristic_variant_val where rel_type = 'variant'
			);

		-- needs to safely remove characteristics with commodity_group
		delete from
			characteristic_variant_val
		where
			characteristic_id in (
				select characteristic_id from characteristic where group_id = old.group_id
			)
			and rel_type = 'redefine';

		return old;
	end;
$$;


--
-- Name: commodity_group_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.commodity_group_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.deleted_at is not null and old.deleted_at is null and new.is_default is true then
			new.is_default = false;
		end if;

		return new;
	end;
$$;


--
-- Name: commodity_group_init(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.commodity_group_init() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into commodity_group_text (group_id, lang_id)
		select
			NEW.group_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: custom_item_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.custom_item_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 begin
				insert into inventory_item (custom_item_id)
				values (NEW.custom_item_id);

				return NEW;
	 end;
$$;


--
-- Name: customer_group_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.customer_group_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into customer_group_text (group_id, lang_id)
		select
			NEW.group_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: delivery_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delivery_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into delivery_text (delivery_id, lang_id)
		select
			new.delivery_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


--
-- Name: delivery_city_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delivery_city_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into delivery_city_text (delivery_city_id, lang_id)
		select
			new.delivery_city_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


--
-- Name: delivery_country_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delivery_country_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into delivery_country_text (delivery_country_id, lang_id)
		select
			new.delivery_country_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


--
-- Name: delivery_site_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delivery_site_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
		      new.sort := (select coalesce(max(sort),-10)+10 from delivery_site where site_id = new.site_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: filter_field_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.filter_field_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
		      new.sort = (select coalesce(max(sort), -10) + 10 from filter_field where filter_id = new.filter_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: final_price_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.final_price_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__product_id int;
	begin
		select get_product_id_by_variant_item(old.item_id) into __product_id;

		if __product_id is not null then
			perform recalc_range_final_price(__product_id, old.point_id, old.currency_id);
		end if;

		return old;
	end;
$$;


--
-- Name: final_price_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.final_price_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__product_id int;
	begin
		select get_product_id_by_variant_item(new.item_id) into __product_id;

		if __product_id is not null then
			perform recalc_range_final_price(__product_id, new.point_id, new.currency_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: final_price_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.final_price_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__product_id int;
	begin
		if new.point_id != old.point_id or new.item_id != old.item_id or new.price_id != old.price_id then
			raise exception 'Fields from PK cannot be changed. Use delete/insert instead.';
		end if;

		if coalesce(new.value, 0) != coalesce(old.value, 0) or coalesce(new.old, 0) != coalesce(old.old, 0) then
			select get_product_id_by_variant_item(new.item_id) into __product_id;

			if __product_id is not null then
				perform recalc_range_final_price(__product_id, new.point_id, new.currency_id);
			end if;
		end if;

		return NEW;
	end;
$$;


--
-- Name: form_entry_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.form_entry_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		update
			form
		set
			entries_amount = (
				select
					count(entry_id) as amount
				from
					form_entry
				where
					form_id = new.form_id
			)
		where
			form_id = new.form_id;

		return new;
	end;
$$;


--
-- Name: form_field_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.form_field_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
			new.sort = (select coalesce(max(sort), -10) + 10 from form_field where form_id = new.form_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: get_product_id_by_variant_item(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_product_id_by_variant_item(__item_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	declare
		__product_id integer;
	begin
		select
			p.product_id
			into __product_id
		 from
			inventory_item i
			inner join variant v on i.variant_id = v.variant_id
			inner join product p on p.product_id = v.product_id
			inner join inventory_item pi on pi.product_id = p.product_id
		where
			i.item_id = __item_id;

		return __product_id;
	end;
$$;


--
-- Name: has_active_variants(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.has_active_variants(__product_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
	declare __total int;
	declare __hasVariants boolean;

	begin
		select count(*) into __total from variant where product_id = __product_id and deleted_at is null;

		if __total > 0 then
			__hasVariants := true;
		else
			__hasVariants := false;
		end if;

		return __hasVariants;
	end;
$$;


--
-- Name: import_file_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.import_file_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__totalFiles int;
		__withMyStatus int;
	begin
		if old.status != new.status then
			select
				sum(case when status = new.status then 1 else 0 end),
				count(*)
				into __withMyStatus, __totalFiles
			from
				import_file
			where
				import_id = new.import_id;

			if __withMyStatus = __totalFiles then
				update
					import
				set
					status = new.status
				where
					import_id = new.import_id;
			end if;
		end if;

		return new;
	end;
$$;


--
-- Name: inventory_change_available_qty(integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_change_available_qty(__movement_id integer, __location_id integer, __item_id integer, __new_qty integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare
		__current_qty int;
		__diff int;
		__insert_new boolean;
	begin
		if __new_qty < 0 then
			raise exception 'New qty cannot be less then zero!';
		end if;

		/* current quantity */
		select
			available_qty
			into __current_qty
		from
			inventory_stock
		where
			location_id = __location_id
			and item_id = __item_id;

		if __current_qty is null then
			__current_qty := 0;
			__insert_new := true;
		else
			__insert_new := false;
		end if;

		__diff := __new_qty - __current_qty;

		if __diff != 0 then
			if __insert_new then
				insert into inventory_stock
					(location_id, item_id, available_qty)
				values
					(__location_id, __item_id, __new_qty);
			else
				update
					inventory_stock
				set
					available_qty = __new_qty
				where
					location_id = __location_id
					and item_id = __item_id;
			end if;

			insert into inventory_movement_item
				(movement_id, item_id, from_location_id, to_location_id, available_qty_diff)
			values
				(__movement_id, __item_id, __location_id, __location_id, __diff);
		end if;
	end;
$$;


--
-- Name: inventory_item_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_item_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		PERFORM product_update_qty(old.product_id, old.variant_id, old.available_qty * -1, old.reserved_qty * -1);

		return old;
	end;
$$;


--
-- Name: inventory_item_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_item_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		PERFORM product_update_qty(new.product_id, new.variant_id, new.available_qty, new.reserved_qty);

		return NEW;
	end;
$$;


--
-- Name: inventory_item_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_item_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__availableQtyDiff int;
		__reservedQtyDiff int;
	begin
		__availableQtyDiff := new.available_qty - old.available_qty;
		__reservedQtyDiff := new.reserved_qty - old.reserved_qty;

		PERFORM product_update_qty(new.product_id, new.variant_id, __availableQtyDiff, __reservedQtyDiff);

		return NEW;
	end;
$$;


--
-- Name: inventory_item_before_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_item_before_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		PERFORM product_update_qty(old.product_id, old.variant_id, old.available_qty * -1, old.reserved_qty * -1);

		return old;
	end;
$$;


--
-- Name: inventory_option_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_option_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into inventory_option_text (option_id, lang_id)
		select
			NEW.option_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: inventory_option_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_option_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
		      new.sort = inventory_option_get_next_sort(new.category);
		end if;

		return NEW;
	end;
$$;


--
-- Name: inventory_option_get_next_sort(public.inventory_option_category); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_option_get_next_sort(__category public.inventory_option_category) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	declare
		__nextSort int;
	begin
		select
			coalesce(max(sort),-10)+10 into __nextSort
		from
			inventory_option
		where
			category = __category
		;

		return __nextSort;
	end;
$$;


--
-- Name: inventory_price_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_price_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		r point_sale%rowtype;
	begin
		for r in select point_id from point_sale
		loop
			delete from
				final_price
			where
				point_id = r.point_id
				and item_id = old.item_id
				and price_id = old.price_id
				and is_auto_generated = true;
		end loop;

		return new;
	end;
$$;


--
-- Name: inventory_price_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_price_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		r point_sale%rowtype;
	begin
		for r in select point_id from point_sale
		loop
			execute set_final_price_auto_generated(r.point_id, new.item_id, new.price_id, new.currency_id, new.value, new.old);
		end loop;

		return new;
	end;
$$;


--
-- Name: inventory_price_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_price_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		r point_sale%rowtype;
	begin
		if new.item_id != old.item_id or new.price_id != old.price_id then
			raise exception 'item_id or price_id cannot be changed.  Use delete and insert.';
		end if;

		for r in select point_id from point_sale
		loop
			execute set_final_price_auto_generated(r.point_id, new.item_id, new.price_id, new.currency_id, new.value, new.old);
		end loop;

		return new;
	end;
$$;


--
-- Name: inventory_stock_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_stock_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	__trackInventory boolean;
begin
	select track_inventory into __trackInventory from vw_track_inventory where item_id = old.item_id;

	if __trackInventory is true then
		update
			inventory_item
		set
			available_qty = available_qty - old.available_qty,
			reserved_qty = reserved_qty - old.reserved_qty
		where
			item_id = old.item_id;
	end if;

	return old;
end;
$$;


--
-- Name: inventory_stock_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_stock_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	__trackInventory boolean;
begin
	select track_inventory into __trackInventory from vw_track_inventory where item_id = new.item_id;

	if __trackInventory is true then
		update
			inventory_item
		set
			available_qty = available_qty + new.available_qty,
			reserved_qty = reserved_qty + new.reserved_qty
		where
			item_id = new.item_id;
	end if;

	return NEW;
end;
$$;


--
-- Name: inventory_stock_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_stock_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
	__availableQtyDiff int;
	__reservedQtyDiff int;
	__trackInventory boolean;
begin
	if old.item_id != new.item_id then
		raise exception 'item_id cannot be changed!';
	end if;

	select track_inventory into __trackInventory from vw_track_inventory where item_id = new.item_id;

	__availableQtyDiff := new.available_qty - old.available_qty;
	__reservedQtyDiff := new.reserved_qty - old.reserved_qty;

	if __trackInventory is true then
		update
			inventory_item
		set
			available_qty = available_qty + __availableQtyDiff,
			reserved_qty = reserved_qty + __reservedQtyDiff
		where
			item_id = new.item_id;
	end if;

	return new;
end;
$$;


--
-- Name: label_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.label_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into label_text (label_id, lang_id)
		select
			new.label_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


--
-- Name: labels_delete_obsolete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.labels_delete_obsolete() RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		r label%ROWTYPE;
	BEGIN
		for r in
			(select
				*
			from
				label
			where
				remove_after is not null)
		loop
			delete from
				product_label_rel
			where
				product_label_rel.label_id = r.label_id
				and now() >= product_label_rel.created_at + interval '1 day' * r.remove_after;
		end loop;
	END;
$$;


--
-- Name: manufacturer_init(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.manufacturer_init() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into manufacturer_text (manufacturer_id, lang_id)
		select
			NEW.manufacturer_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: menu_item_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.menu_item_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into menu_item_rel (item_id) values (new.item_id);

		return NEW;
	end;
$$;


--
-- Name: menu_item_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.menu_item_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = menu_item_next_sort(new.block_id, new.lang_id, new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: menu_item_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.menu_item_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = menu_item_next_sort(new.block_id, new.lang_id, new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: menu_item_next_sort(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.menu_item_next_sort(__block_id integer, __lang_id integer, __parent_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare
		__sql text = '
			select
				coalesce(max(sort),-10)+10
			from
				menu_item
			where
				block_id = $1
				and lang_id = $2
				and parent_id
		';
		__next int;
	begin
			if __parent_id is null then
				__sql = __sql || ' is null';
			else
				__sql = __sql || '=$3';
			end if;

			execute __sql into __next using __block_id, __lang_id, __parent_id;

		return __next;
	end;
$_$;


--
-- Name: order_service_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_service_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into order_service_delivery
			(order_service_id)
		values
			(new.order_service_id);

		return NEW;
	end;
$$;


--
-- Name: order_service_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_service_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__final_price numeric(20,2);
	begin
		if new.qty is not null and new.item_price_id is not null then
			select
				final_price into __final_price
			from
				item_price
			where
				item_price_id = new.item_price_id;

			if __final_price is not null then
				new.total_price := __final_price * new.qty;
			end if;
		end if;

		return NEW;
	end;
$$;


--
-- Name: order_service_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_service_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__final_price numeric(20,2);
	begin
		if new.qty is not null and new.item_price_id is not null then
			select
				final_price into __final_price
			from
				item_price
			where
				item_price_id = new.item_price_id;

			if __final_price is not null then
				new.total_price := __final_price * new.qty;
			end if;
		end if;

		return NEW;
	end;
$$;


--
-- Name: order_source_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_source_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into order_source_text (source_id, lang_id)
		select
			NEW.source_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: order_source_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_source_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = (select coalesce(max(sort), -10) + 10 from order_source);
		end if;

		return NEW;
	end;
$$;


--
-- Name: order_status_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_status_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into order_status_text (status_id, lang_id)
		select
			NEW.status_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: order_status_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_status_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = order_status_get_next_sort(new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: order_status_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_status_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = order_status_get_next_sort(new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: order_status_get_next_sort(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.order_status_get_next_sort(__parent_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare
		nextSortSql text = 'select coalesce(max(sort), -10)+10 from order_status where parent_id';
		nextSort int;
	begin
			if __parent_id is null then
				nextSortSql = nextSortSql || ' is null';
			else
				nextSortSql = nextSortSql || '=$1';
			end if;

			execute nextSortSql into nextSort using __parent_id;

		return nextSort;
	end;
$_$;


--
-- Name: orders_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.orders_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

	begin
		insert into order_prop (order_id) values (new.order_id);

		return NEW;
	end;
$$;


--
-- Name: page_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.page_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if old.typearea_id is not null then
			delete from typearea where typearea_id = old.typearea_id;
		end if;

		return old;
	end;
$$;


--
-- Name: page_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.page_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into page_props (page_id) values (new.page_id);

		return NEW;
	end;
$$;


--
-- Name: page_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.page_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = page_get_next_sort(new.site_id, new.lang_id, new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: page_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.page_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	begin
		if new.sort is null then
		      new.sort = page_get_next_sort(new.site_id, new.lang_id, new.parent_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: page; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page (
    page_id integer NOT NULL,
    site_id integer NOT NULL,
    lang_id integer NOT NULL,
    parent_id integer,
    type public.page_type NOT NULL,
    title public.citext,
    system_alias public.citext,
    url_key public.citext,
    typearea_id integer,
    route_id integer,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT page_check CHECK ((page_id <> parent_id))
);


--
-- Name: page_get_children(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.page_get_children(__page_id integer) RETURNS SETOF public.page
    LANGUAGE plpgsql
    AS $$
	declare
		r page%rowtype;
	begin
		for r in
			with recursive page_children as (
				select
					page.*
				from
					page
				where
					parent_id = __page_id
				union all
				select
					page.*
				from
					page
					inner join page_children vw on vw.page_id = page.parent_id

			) select * from page_children
		loop
			return next r;
		end loop;

		return;
	end;
$$;


--
-- Name: page_get_next_sort(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.page_get_next_sort(__site_id integer, __lang_id integer, __parent_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare
		nextSortSql text = 'select coalesce(max(sort),-10)+10 from page where site_id = $1 and lang_id = $2 and parent_id';
		nextSort int;
	begin
			if __parent_id is null then
				nextSortSql = nextSortSql || ' is null';
			else
				nextSortSql = nextSortSql || '=$3';
			end if;

			execute nextSortSql into nextSort using __site_id, __lang_id, __parent_id;

		return nextSort;
	end;
$_$;


--
-- Name: payment_method_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.payment_method_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into payment_method_text (payment_method_id, lang_id)
		select
			NEW.payment_method_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: payment_method_site_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.payment_method_site_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
		      new.sort := (select coalesce(max(sort),-10)+10 from payment_method_site where site_id = new.site_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: person_address_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_address_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 begin
			perform person_update_search(new.person_id);
			return NEW;
	 end;
$$;


--
-- Name: person_address_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_address_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	 begin
			perform person_update_search(new.person_id);
			return NEW;
	 end;
$$;


--
-- Name: person_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		perform person_update_search(new.person_id);

		return NEW;
	end;
$$;


--
-- Name: person_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		new.email = lower(new.email);

		return NEW;
	end;
$$;


--
-- Name: person_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		new.email = lower(new.email);

		return NEW;
	end;
$$;


--
-- Name: person_init(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_init() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into person_auth (person_id) values (NEW.person_id);
		insert into person_settings (person_id) values (NEW.person_id);
		insert into person_profile (person_id) values (new.person_id);
		insert into person_search (person_id) values (new.person_id);
		insert into person_visitor (person_id) values (new.person_id);

		perform person_update_search(new.person_id);

		return NEW;
	end;
$$;


--
-- Name: person_profile_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_profile_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		perform person_update_search(new.person_id);

		return NEW;
	end;
$$;


--
-- Name: person_profile_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_profile_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		perform person_update_search(new.person_id);

		return NEW;
	end;
$$;


--
-- Name: person_update_search(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.person_update_search(__person_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare
		__text text;
	begin
		select
			concat(email, ', ', first_name, ' ', last_name, ' ', patronymic, ', ', phone, ', ', comment)
			into __text
		from
			person
			inner join person_profile using(person_id)
		where
			person_id = __person_id;

		select
			concat(__text, ', ',
				string_agg(
					first_name || ' ' || last_name || ', ' || company || ', '
					|| address_line_1 || ' ' || address_line_2 || ', '
					|| city || ', ' || state || ', ' || zip || ', '
					|| phone || ', ' || comment,
					','
				)
			) into __text
		from
			person_address
		where
			person_id = __person_id;

		update
			person_search
		set
			search = __text
		where
			person_id = __person_id;
	end;
$$;


--
-- Name: phone_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.phone_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		perform phone_check_default_exists(old.person_id);
		perform person_update_search(old.person_id);

		return old;
	end;
$$;


--
-- Name: phone_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.phone_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		perform phone_check_default_exists(new.person_id);
		perform person_update_search(new.person_id);

		return new;
	end;
$$;


--
-- Name: phone_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.phone_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		perform person_update_search(new.person_id);

		return NEW;
	end;
$$;


--
-- Name: phone_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.phone_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.is_default_for_sms is true and old.is_default_for_sms is false then
			update
				phone
			set
				is_default_for_sms = false
			where
				person_id = new.person_id
				and is_default_for_sms is true;
		end if;

		return new;
	end;
$$;


--
-- Name: phone_check_default_exists(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.phone_check_default_exists(__person_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	begin
		update
			phone
		set
			is_default_for_sms = true
		where
			phone_id in (
				select
					phone_id
				from
					phone
					inner join (
						select
							person_id,
							sum(
								CASE WHEN is_default_for_sms is true THEN 1 ELSE 0 END
							) as total_default
						from
							phone
						where
							person_id = __person_id
						group by
							person_id
					) as person_total on
						phone.person_id = person_total.person_id
						and person_total.total_default = 0
				where
					phone.person_id = __person_id
				limit 1
			);
	end;
$$;


--
-- Name: price_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.price_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into price_text (price_id, lang_id)
		select
			NEW.price_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: price_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.price_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
			new.sort = (select coalesce(max(sort), -10) + 10 from price);
		end if;

		return NEW;
	end;
$$;


--
-- Name: product_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if coalesce(new.group_id, 0) != coalesce(old.group_id, 0) then
			delete from characteristic_product_val where product_id = new.product_id;
		end if;

		return NEW;
	end;
$$;


--
-- Name: product_category_rel_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_category_rel_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if old.is_default is true then
			insert into product_category_rel
				(category_id, product_id, is_default)
			select
				category_id,
				product_id,
				true
			from
				product_category_rel
				inner join vw_category_flat_list using(category_id)
			where
				product_id = old.product_id
			order by tree_sort desc
			limit 1
			on conflict (category_id, product_id) do update set is_default = true;
		end if;

		return old;
	end;

$$;


--
-- Name: product_category_rel_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_category_rel_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if not exists (select 1 from product_category_rel where product_id = new.product_id and is_default = true)
		then
			new.is_default := true;
		end if;

		return new;
	end;
$$;


--
-- Name: product_check_default_img(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_check_default_img(__product_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	begin
		if product_has_default(__product_id) is false then
			update
				product_image pi
			set
				is_default = true
			from (
				select
					product_image_id
				from
					product_image
				where
					product_id = __product_id
				order by sort asc
				limit 1
			) sub
			where
				pi.product_image_id = sub.product_image_id
			;
		end if;
	end;
$$;


--
-- Name: product_has_default(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_has_default(__product_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
	declare
		__default_qty int;
	begin
		select
			count(*) into __default_qty
		from
			product_image
		where
			product_id = __product_id
			and is_default is true;

		if __default_qty > 0 then
			return true;
		else
			return false;
		end if;
	end;
$$;


--
-- Name: product_image_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_image_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		PERFORM product_check_default_img(old.product_id);

		return old;
	end;
$$;


--
-- Name: product_image_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_image_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into product_image_text (product_image_id, lang_id)
		select
			NEW.product_image_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: product_image_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_image_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
			new.sort = (select coalesce(max(sort), -10) + 10 from product_image where product_id = new.product_id);
		end if;

		if new.is_default is false and product_has_default(new.product_id) is false then
			new.is_default = true;
		end if;

		return NEW;
	end;
$$;


--
-- Name: product_init(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_init() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into product_text (product_id, lang_id)
		select
			NEW.product_id,
			lang_id
		from
			lang;

		insert into product_prop (product_id) values (new.product_id);

		insert into inventory_item (product_id) values (new.product_id);

		insert into product_yml (product_id) values (new.product_id);

		return NEW;
	end;
$$;


--
-- Name: product_recalc_qty(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_recalc_qty(__product_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare
		__availableQty integer;
		__reservedQty integer;
	begin
		select
			available_qty,
			reserved_qty
			into
			__availableQty,
			__reservedQty
		from
			inventory_item
		where
			product_id = __product_id
		;

		select
			coalesce(sum(i.available_qty), 0) + __availableQty,
			coalesce(sum(i.reserved_qty), 0) + __reservedQty
			into
			__availableQty,
			__reservedQty
		from
			inventory_item i
			inner join variant v using(variant_id)
		where
			v.product_id = __product_id;

		update
			product_prop
		set
			available_qty = __availableQty,
			reserved_qty = __reservedQty
		where
			product_id = __product_id;
	end;
$$;


--
-- Name: product_update_qty(integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_update_qty(__product_id integer, __variant_id integer, __available_qty integer, __reserved_qty integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	begin
		if __product_id is null then
			select
				product_id
				into __product_id
			from
				variant
			where
				variant_id = __variant_id;
		end if;

		update
			product_prop
		set
			available_qty = available_qty + __available_qty,
			reserved_qty = reserved_qty + __reserved_qty
		where
			product_id = __product_id;
	end;
$$;


--
-- Name: product_variant_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_variant_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into product_variant_text (variant_id, lang_id)
		select
			NEW.variant_id,
			lang_id
		from
			lang;

		return NEW;
	end;
$$;


--
-- Name: product_variant_characteristic_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.product_variant_characteristic_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare _relId int;
	begin
		if new.rel_type = 'variant' then
			select rel_id into _relId from product_variant_characteristic where product_id = new.product_id and characteristic_id = new.characteristic_id and rel_type = 'redefine';

			if _relId is not null then
				delete from product_variant_characteristic where rel_id = _relId;
			end if;
		end if;

		if new.sort is null then
			new.sort = (
				select
					coalesce(max(sort), 0) + 10
				from
					product_variant_characteristic
				where
					product_id = new.product_id
					and rel_type = new.rel_type
			);
		end if;

		return NEW;
	end;
$$;


--
-- Name: recalc_range_final_price(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.recalc_range_final_price(__product_id integer, __point_id integer, __currency_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare
		__product_item_id integer;
		r final_price%rowtype;
	begin
		select item_id into __product_item_id from inventory_item where product_id = __product_id;
		FOR r IN
			select
				/* select columns, since r should be final_price%rowtype */
				__point_id as point_id,
				__product_item_id as item_id,
				p.price_id as price_id,
				tmp.currency_id as currency_id,
				null as value,
				tmp.min as min,
				tmp.max as max,
				true as is_auto_generated,
				null as old,

				/* for product with variants - fill old price only if old price is filled for all variants */
				/* it was fixed for https://trello.com/c/5YFggIpv/480-%D0%BD%D0%B5%D0%B2%D0%B5%D1%80%D0%BD%D0%BE-%D0%B2%D1%8B%D1%81%D1%82%D0%B0%D0%B2%D0%BB%D1%8F%D0%B5%D1%82%D1%81%D1%8F-%D1%86%D0%B5%D0%BD%D0%B0-%D0%BE%D1%82 */
				case
					when tmp.total_rows = tmp.total_old_rows then
						tmp.old_min
					else
						null
				end as old_min,
				case
					when tmp.total_rows = tmp.total_old_rows then
						tmp.old_max
					else
						null
				end as old_max
			from
				price p
				left join (
					select
						f.price_id,
						f.currency_id,
						min(f.value) as min,
						max(f.value) as max,
						min(f.old) as old_min,
						max(f.old) as old_max,
						count(*) as total_rows,
						count(f.old) as total_old_rows
					from
						final_price f
						inner join inventory_item i on i.item_id = f.item_id
						inner join variant v on v.variant_id = i.variant_id
					where
						v.product_id = __product_id
						and f.point_id = __point_id
						and v.deleted_at is null
					group by
						f.price_id, f.currency_id
				) tmp on tmp.price_id = p.price_id
		LOOP
			perform set_range_final_price(__point_id, __product_item_id, r.price_id, __currency_id, r.min, r.max, r.old_min, r.old_max);
		END LOOP;

		return;
	end;
$$;


--
-- Name: reserve_item_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reserve_item_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		execute reserve_update_total(old.reserve_id);

		return old;
	end;
$$;


--
-- Name: reserve_item_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reserve_item_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		execute reserve_update_total(new.reserve_id);

		return NEW;
	end;
$$;


--
-- Name: reserve_item_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reserve_item_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		execute reserve_update_total(new.reserve_id);

		return NEW;
	end;
$$;


--
-- Name: reserve_item_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reserve_item_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__final_price numeric(20,2);
	begin
		if new.qty is not null and new.item_price_id is not null then
			select
				final_price into __final_price
			from
				item_price
			where
				item_price_id = new.item_price_id;

			if __final_price is not null then
				new.total_price := __final_price * new.qty;
			end if;
		end if;

		return NEW;
	end;
$$;


--
-- Name: reserve_item_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reserve_item_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__final_price numeric(20,2);
	begin
		if new.qty is not null and new.item_price_id is not null then
			select
				final_price into __final_price
			from
				item_price
			where
				item_price_id = new.item_price_id;

			if __final_price is not null then
				new.total_price := __final_price * new.qty;
			end if;
		end if;

		return NEW;
	end;
$$;


--
-- Name: reserve_update_total(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reserve_update_total(__reserve_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare
		__totalPrice numeric(20,2);
		__totalQty integer;
	begin
		select
			sum(total_price), sum(qty)
			into __totalPrice, __totalQty
		from
			reserve_item
		where
			reserve_id = __reserve_id;

		update
			reserve
		set
			total_price = __totalPrice,
			total_qty = coalesce(__totalQty, 0)
		where
			reserve_id = __reserve_id;
	end;
$$;


--
-- Name: reserve_update_totals(integer, integer, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.reserve_update_totals(__reserve_id integer, __qty_diff integer, __price_diff numeric) RETURNS void
    LANGUAGE plpgsql
    AS $_$
	declare
		__sql text = 'update reserve set total_qty = total_qty + $1';
	begin
		if __price_diff is not null then
			__sql = __sql || ', total_price = total_price + $2';
		end if;

		__sql = __sql || ' where reserve_id = $3';

		execute __sql using __qty_diff, __price_diff, __reserve_id;
	end;
$_$;


--
-- Name: service_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.service_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into service_text (service_id, lang_id)
		select
			new.service_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


--
-- Name: set_final_price_auto_generated(integer, integer, integer, integer, numeric, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_final_price_auto_generated(__point_id integer, __item_id integer, __price_id integer, __currency_id integer, __value numeric, __old numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare
		__auto_generated boolean;
	begin
		/* update or insert auto-generated final price */
		select
			is_auto_generated
			into __auto_generated
		from
			final_price
		where
			point_id = __point_id
			and item_id = __item_id
			and price_id = __price_id
		;

		if __auto_generated = false then
			return;
		end if;

		if __auto_generated is null then
			insert into final_price
				(point_id, item_id, price_id, currency_id, value, is_auto_generated, old)
			values
				(__point_id, __item_id, __price_id, __currency_id, __value, true, __old);
		else
			update
				final_price
			set
				value = __value,
				currency_id = __currency_id,
				old = __old
			where
				point_id = __point_id
				and item_id = __item_id
				and price_id = __price_id;
		end if;

		return;
	end;
$$;


--
-- Name: set_inventory_price(integer, integer, integer, numeric, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_inventory_price(__item_id integer, __price_id integer, __currency_id integer, __value numeric, __old numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
	begin
		update
			inventory_price
		set
			value = __value,
			currency_id = __currency_id,
			old = __old
		where
			item_id = __item_id
			and price_id = __price_id;

		insert into inventory_price
			(item_id, price_id, value, currency_id, old)
		select
			__item_id, __price_id, __value, __currency_id, __old
		where
			not exists (
				select
					1
				from
					inventory_price
				where
					item_id = __item_id
					and price_id = __price_id
			);
	end;
$$;


--
-- Name: set_range_final_price(integer, integer, integer, integer, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_range_final_price(__point_id integer, __item_id integer, __price_id integer, __currency_id integer, __min numeric, __max numeric, __old_min numeric, __old_max numeric) RETURNS void
    LANGUAGE plpgsql
    AS $$
	begin
		update
			final_price
		set
			min = __min,
			max = __max,
			old_min = __old_min,
			old_max = __old_max
		where
			point_id = __point_id
			and item_id = __item_id
			and price_id = __price_id
		;


		insert into final_price
			(point_id, item_id, price_id, currency_id, min, max, is_auto_generated, old_min, old_max)
		select
			__point_id,
			__item_id,
			__price_id,
			__currency_id,
			__min,
			__max,
			true,
			__old_min,
			__old_max
		where
			not exists (
				select
					1
				from
					final_price
				where
					point_id = __point_id
					and item_id = __item_id
					and price_id = __price_id
			);

		return;

	end;
$$;


--
-- Name: site_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.site_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into point_sale (site_id) values (new.site_id);

		return NEW;
	end;
$$;


--
-- Name: site_delivery_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.site_delivery_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
		      new.sort := (select coalesce(max(sort),-10)+10 from site_delivery where site_id = new.site_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: sphinx_replace_article(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.sphinx_replace_article(__id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		__row article%ROWTYPE;
	begin
		if exists (select 1 from article where article_id = __id)
		then
			for __row in
				select
					article.*
				from
					article
					inner join lang using (lang_id)
				where
					article_id = __id
					and lang.code = 'ru'
			loop
				execute sphinx_replace('babylonSiteSearchRu', (__row.article_id * 10 + 5), ARRAY[
					'local_id', __row.article_id::text,
					'site_id', __row.site_id::text,
					'type', 'article',
					'title', __row.title::text,
					'text', __row.content::text,
					'seo_title', '',
					'meta', ''
				]);
			end loop;
		else
			execute sphinx_delete('babylonSiteSearchRu', __id * 10 + 5);
		end if;
	end;
$$;


--
-- Name: sphinx_replace_category(integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.sphinx_replace_category(__id integer, __reindexproducts boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		__row vw_search_category%ROWTYPE;
		__relRow product_category_rel%ROWTYPE;
	begin
		if exists (select 1 from vw_category_flat_list where category_id = __id)
		then
			for __row in select * from vw_search_category where local_id = __id and lang_code = 'ru'
			loop
				execute sphinx_replace('babylonSiteSearchRu', __row.id, ARRAY[
					'local_id', __row.local_id::text,
					'site_id', __row.site_id::text,
					'type', __row.type::text,
					'title', __row.title::text,
					'text', __row.text::text,
					'seo_title', concat_ws(',', __row.seo_title, __row.seo_header),
					'meta', concat_ws(',', __row.meta_description, __row.meta_keywords)
				]);
			end loop;
		else
			execute sphinx_delete('babylonSiteSearchRu', __id * 10 + 2);
		end if;

		if __reIndexProducts is true then
			for __relRow in select * from product_category_rel where category_id = __id
			loop
				execute sphinx_replace_product(__relRow.product_id);
			end loop;
		end if;
	end;
$$;


--
-- Name: sphinx_replace_manufacturer(integer, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.sphinx_replace_manufacturer(__id integer, __reindexproducts boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		__row vw_search_manufacturer%ROWTYPE;
		__productRow product%ROWTYPE;
	begin
		if exists (select 1 from manufacturer where manufacturer_id = __id and deleted_at is null)
		then
			for __row in select * from vw_search_manufacturer where local_id = __id and lang_code = 'ru'
			loop
				execute sphinx_replace('babylonSiteSearchRu', __row.id, ARRAY[
					'local_id', __row.local_id::text,
					'type', __row.type::text,
					'title', __row.title::text,
					'text', __row.text::text,
					'seo_title', concat_ws(',', __row.seo_title, __row.seo_header),
					'meta', concat_ws(',', __row.meta_description, __row.meta_keywords)
				]);
			end loop;
		else
			execute sphinx_delete('babylonSiteSearchRu', __id * 10 + 4);
		end if;

		if __reIndexProducts is true then
			for __productRow in select * from product where manufacturer_id = __id
			loop
				execute sphinx_replace_product(__productRow.product_id);
			end loop;
		end if;
	end;
$$;


--
-- Name: sphinx_replace_page(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.sphinx_replace_page(__id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		__row vw_search_page%ROWTYPE;
	begin
		if exists (select 1 from vw_page_flat_list where page_id = __id)
		then
			for __row in select * from vw_search_page where local_id = __id and lang_code = 'ru'
			loop
				execute sphinx_replace('babylonSiteSearchRu', __row.id, ARRAY[
					'local_id', __row.local_id::text,
					'site_id', __row.site_id::text,
					'type', __row.type::text,
					'title', __row.title::text,
					'text', __row.text::text,
					'seo_title', concat_ws(',', __row.seo_title, __row.seo_header),
					'meta', concat_ws(',', __row.meta_description, __row.meta_keywords)
				]);
			end loop;
		else
			execute sphinx_delete('babylonSiteSearchRu', __id * 10 + 3);
		end if;
	end;
$$;


--
-- Name: sphinx_replace_product(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.sphinx_replace_product(__id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		__row vw_search_product%ROWTYPE;
	begin
		if exists (select 1 from product where product_id = __id and deleted_at is null)
		then
			for __row in select * from vw_search_product where local_id = __id and lang_code = 'ru'
			loop
				execute sphinx_replace('babylonAdminProductRu', __row.id, ARRAY[
					'local_id', __row.local_id::text,
					'site_id', __row.site_id::text,
					'title', __row.title::text,
					'sku', __row.sku::text,
					'description', __row.text::text,
					'variants_search', __row.variant_search::text,
					'manufacturer_title', __row.manufacturer_title::text,
					'group_title', __row.group_title::text,
					'categories_title', __row.cats_title::text
				]);

				execute sphinx_replace('babylonSiteSearchRu', __row.id, ARRAY[
					'local_id', __row.local_id::text,
					'site_id', __row.site_id::text,
					'type', __row.type::text,
					'title', __row.title::text,
					'sku', __row.sku::text,
					'text', __row.text::text,
					'seo_title', concat_ws(',', __row.seo_title, __row.seo_header),
					'meta', concat_ws(',', __row.meta_description, __row.meta_keywords),
					'other', concat_ws(',', __row.variant_search, __row.manufacturer_title, __row.cats_title)
				]);
			end loop;
		else
			execute sphinx_delete('babylonAdminProductRu', __id * 10 + 1);
			execute sphinx_delete('babylonSiteSearchRu', __id * 10 + 1);
		end if;
	end;
$$;


--
-- Name: theme_installed_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.theme_installed_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into theme_installed_text (installed_id, lang_id)
		select
			new.installed_id,
			lang_id
		from
			lang;

		return new;
	end;
$$;


--
-- Name: typearea_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.typearea_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into typearea_rel (typearea_id) values (new.typearea_id);

		return NEW;
	end;
$$;


--
-- Name: typearea_block_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.typearea_block_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into typearea_block_text (block_id) values (new.block_id);

		return NEW;
	end;
$$;


--
-- Name: typearea_block_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.typearea_block_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
			new.sort := (select coalesce(max(sort), -10) + 10 from typearea_block where typearea_id = new.typearea_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: typearea_block_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.typearea_block_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
			new.sort := (select coalesce(max(sort), -10) + 10 from typearea_block where typearea_id = new.typearea_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: typearea_block_before_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.typearea_block_before_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
			new.sort := (select coalesce(max(sort), -10) + 10 from typearea_block where typearea_id = new.typearea_id);
		end if;

		return NEW;
	end;
$$;


--
-- Name: typearea_rel_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.typearea_rel_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		delete from typearea where typearea_id = old.typearea_id;

		return old;
	end;
$$;


--
-- Name: update_product_prices_by_variant(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_product_prices_by_variant(__product_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	declare
		row_point point_sale%rowtype;
		row_currency currency%rowtype;
	begin
		for row_point in
			select
				distinct p.*
			from
				point_sale p
				inner join final_price f using(point_id)
				inner join inventory_item i using(item_id)
			where
				i.product_id = __product_id
		loop
			for row_currency in
				select
					distinct c.*
				from
					currency c
					inner join final_price f using(currency_id)
					inner join inventory_item i using(item_id)
				where
					i.product_id = __product_id
			loop
				perform recalc_range_final_price(__product_id, row_point.point_id, row_currency.currency_id);
			end loop;
		end loop;

	end;
$$;


--
-- Name: variant_after_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.variant_after_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		perform update_product_prices_by_variant(old.product_id);

		update
			product
		set
			has_variants = has_active_variants(old.product_id)
		where
			product_id = old.product_id;

		return old;
	end;
$$;


--
-- Name: variant_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.variant_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into variant_text (variant_id, lang_id)
		select
			NEW.variant_id,
			lang_id
		from
			lang;

		insert into inventory_item (variant_id) values (new.variant_id);

		if new.deleted_at is null then
			update
				product
			set
				has_variants = true
			where
				product_id = new.product_id;
		end if;

		return NEW;
	end;
$$;


--
-- Name: variant_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.variant_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.product_id != old.product_id then
			raise exception 'Cannot change product for variant_id: %s', new.product_id;
		end if;

		if (new.deleted_at is null and old.deleted_at is not null) or (new.deleted_at is not null and old.deleted_at is null) then
			perform update_product_prices_by_variant(old.product_id);

			update
				product
			set
				has_variants = has_active_variants(new.product_id)
			where
				product_id = new.product_id;
		end if;

		return new;
	end;
$$;


--
-- Name: variant_before_delete(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.variant_before_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	declare
		__available_qty int;
		__reserved_qty int;
	begin
		select
			available_qty,
			reserved_qty
			into
			__available_qty,
			__reserved_qty
		from
			inventory_item
		where
			variant_id = old.variant_id;

		if __available_qty is not null then
			PERFORM product_update_qty(null, old.variant_id, __available_qty * -1, __reserved_qty * -1);
		end if;

		return old;
	end;
$$;


--
-- Name: variant_check_default_img(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.variant_check_default_img(__variant_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
				begin
					if variant_has_default(__variant_id) is false then
						update
							variant_image vi
						set
							is_default = true
						from (
							select
								variant_image_id
							from
								variant_image
							where
								variant_id = __variant_id
							order by created_at asc
							limit 1
						) sub
						where
							vi.variant_image_id = sub.variant_image_id
						;
					end if;
				end;
			$$;


--
-- Name: variant_has_default(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.variant_has_default(__variant_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
				declare
					__default_qty int;
				begin
					select
						count(*) into __default_qty
					from
						variant_image
					where
						variant_id = __variant_id
						and is_default is true;
					if __default_qty > 0 then
						return true;
					else
						return false;
					end if;
				end;
			$$;


--
-- Name: variant_set_title(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.variant_set_title(__variant_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
	update
		variant_text
	set
		title = source_title.title
	from
		(
			select
				variant_id,
				lang_id,
				string_agg(characteristic_type_case_text.title, ' - ' order by value_id asc) as title
			from
				variant
				inner join characteristic_variant_val using(variant_id)
				inner join characteristic_type_case_text using(case_id)
			where
				rel_type = 'variant'
			group by
				variant_id,
				lang_id
		) as source_title
	where
		variant_text.variant_id = source_title.variant_id
		and variant_text.lang_id = source_title.lang_id
		and variant_text.variant_id = __variant_id;
end;
$$;


--
-- Name: warehouse_after_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.warehouse_after_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		insert into warehouse_text (warehouse_id, lang_id)
		select
			new.warehouse_id,
			lang_id
		from
			lang;

		insert into inventory_location
			(warehouse_id)
		values
			(new.warehouse_id);

		return new;
	end;
$$;


--
-- Name: warehouse_before_insert(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.warehouse_before_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		if new.sort is null then
		      new.sort = warehouse_get_next_sort();
		end if;

		return NEW;
	end;
$$;


--
-- Name: warehouse_get_next_sort(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.warehouse_get_next_sort() RETURNS integer
    LANGUAGE plpgsql
    AS $$
	declare
		__nextSort int;
	begin
		select
			coalesce(max(sort),0)+10
			into __nextSort
		from
			warehouse;

		return __nextSort;
	end;
$$;


--
-- Name: delivery_server; Type: SERVER; Schema: -; Owner: -
--

CREATE SERVER delivery_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    dbname 'delivery'
);


--
-- Name: USER MAPPING postgres SERVER delivery_server; Type: USER MAPPING; Schema: -; Owner: -
--

CREATE USER MAPPING FOR postgres SERVER delivery_server OPTIONS (
    password '4mK5jdq3pT',
    "user" 'delivery_view'
);


--
-- Name: admin_comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_comment (
    comment_id integer NOT NULL,
    essence_id integer NOT NULL,
    person_id integer,
    comment text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: admin_comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_comment_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_comment_comment_id_seq OWNED BY public.admin_comment.comment_id;


--
-- Name: api_file_uploader; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_file_uploader (
    id integer NOT NULL,
    file_id uuid NOT NULL,
    path character varying(500),
    chunk_position smallint NOT NULL,
    is_initial boolean DEFAULT false NOT NULL,
    data json DEFAULT '{}'::json NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    file_size integer DEFAULT 0 NOT NULL
);


--
-- Name: api_file_uploader_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.api_file_uploader_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_file_uploader_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.api_file_uploader_id_seq OWNED BY public.api_file_uploader.id;


--
-- Name: api_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_token (
    token_id integer NOT NULL,
    name character varying(255),
    client_id character varying(20),
    secret character varying(255),
    permanent_token character varying(300) DEFAULT NULL::character varying,
    require_exp boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    is_system boolean DEFAULT false NOT NULL,
    can_manage boolean DEFAULT false NOT NULL
);


--
-- Name: api_token_token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.api_token_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_token_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.api_token_token_id_seq OWNED BY public.api_token.token_id;


--
-- Name: area; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.area (
    area_id integer NOT NULL,
    region_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'area'
);
ALTER FOREIGN TABLE public.area ALTER COLUMN area_id OPTIONS (
    column_name 'area_id'
);
ALTER FOREIGN TABLE public.area ALTER COLUMN region_id OPTIONS (
    column_name 'region_id'
);
ALTER FOREIGN TABLE public.area ALTER COLUMN created_at OPTIONS (
    column_name 'created_at'
);
ALTER FOREIGN TABLE public.area ALTER COLUMN deleted_at OPTIONS (
    column_name 'deleted_at'
);


--
-- Name: area_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.area_text (
    area_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'area_text'
);
ALTER FOREIGN TABLE public.area_text ALTER COLUMN area_id OPTIONS (
    column_name 'area_id'
);
ALTER FOREIGN TABLE public.area_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.area_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: article; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.article (
    article_id integer NOT NULL,
    site_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    url_key public.citext,
    date timestamp with time zone DEFAULT now(),
    announcement text,
    content text,
    image_id integer,
    status public.publishing_status DEFAULT 'draft'::public.publishing_status NOT NULL,
    created_by integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: article_article_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.article_article_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: article_article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.article_article_id_seq OWNED BY public.article.article_id;


--
-- Name: auth_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_resource (
    resource_id integer NOT NULL,
    parent_id integer,
    alias character varying(50) NOT NULL,
    title character varying(50),
    CONSTRAINT auth_resource_check CHECK ((resource_id <> parent_id))
);


--
-- Name: COLUMN auth_resource.alias; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.auth_resource.alias IS 'Unique string ID for resource. E.g.: cms.pages';


--
-- Name: auth_resource_resource_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_resource_resource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_resource_resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_resource_resource_id_seq OWNED BY public.auth_resource.resource_id;


--
-- Name: auth_rule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_rule (
    rule_id integer NOT NULL,
    role_id integer NOT NULL,
    resource_id integer,
    task_id integer,
    is_allowed boolean NOT NULL,
    CONSTRAINT "Resource or Task. Both can't be in same sime" CHECK ((((resource_id IS NULL) AND (task_id IS NOT NULL)) OR ((resource_id IS NOT NULL) AND (task_id IS NULL))))
);


--
-- Name: auth_rule_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_rule_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_rule_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_rule_rule_id_seq OWNED BY public.auth_rule.rule_id;


--
-- Name: auth_task; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_task (
    task_id integer NOT NULL,
    resource_id integer NOT NULL,
    alias character varying(50) NOT NULL,
    title character varying(50)
);


--
-- Name: auth_task_task_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_task_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_task_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_task_task_id_seq OWNED BY public.auth_task.task_id;


--
-- Name: background; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.background (
    background_id integer NOT NULL,
    img character varying(255) NOT NULL,
    preview character varying(255) NOT NULL,
    sort integer NOT NULL,
    css jsonb
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'background'
);
ALTER FOREIGN TABLE public.background ALTER COLUMN background_id OPTIONS (
    column_name 'background_id'
);
ALTER FOREIGN TABLE public.background ALTER COLUMN img OPTIONS (
    column_name 'img'
);
ALTER FOREIGN TABLE public.background ALTER COLUMN preview OPTIONS (
    column_name 'preview'
);
ALTER FOREIGN TABLE public.background ALTER COLUMN sort OPTIONS (
    column_name 'sort'
);
ALTER FOREIGN TABLE public.background ALTER COLUMN css OPTIONS (
    column_name 'css'
);


--
-- Name: background_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.background_text (
    background_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'background_text'
);
ALTER FOREIGN TABLE public.background_text ALTER COLUMN background_id OPTIONS (
    column_name 'background_id'
);
ALTER FOREIGN TABLE public.background_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.background_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: basket_basket_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.basket_basket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: basket_basket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.basket_basket_id_seq OWNED BY public.basket.basket_id;


--
-- Name: basket_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.basket_item (
    basket_item_id integer NOT NULL,
    basket_id integer NOT NULL,
    item_id integer NOT NULL,
    qty integer DEFAULT 0 NOT NULL,
    item_price_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: basket_item_basket_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.basket_item_basket_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: basket_item_basket_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.basket_item_basket_item_id_seq OWNED BY public.basket_item.basket_item_id;


--
-- Name: box; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.box (
    box_id integer NOT NULL,
    length numeric(10,2) NOT NULL,
    width numeric(10,2) NOT NULL,
    height numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: box_box_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.box_box_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: box_box_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.box_box_id_seq OWNED BY public.box.box_id;


--
-- Name: box_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.box_text (
    box_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    category_id integer NOT NULL,
    parent_id integer,
    site_id integer NOT NULL,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    external_id public.citext,
    status public.publishing_status DEFAULT 'published'::public.publishing_status NOT NULL,
    created_by integer,
    image_id integer,
    CONSTRAINT category_check CHECK ((parent_id <> category_id))
);


--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category.category_id;


--
-- Name: category_menu_rel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category_menu_rel (
    category_id integer NOT NULL,
    block_id integer NOT NULL
);


--
-- Name: category_prop; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category_prop (
    category_id integer NOT NULL,
    use_filter boolean DEFAULT true NOT NULL,
    filter_id integer,
    custom_link character varying(500),
    sub_category_policy public.sub_category_policy,
    show_in_parent_page_menu boolean DEFAULT true NOT NULL,
    arbitrary_data jsonb
);


--
-- Name: category_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category_text (
    category_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    custom_title text,
    custom_header text,
    meta_description text,
    meta_keywords text,
    url_key public.citext,
    description_top text,
    description_bottom text
);


--
-- Name: characteristic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic (
    characteristic_id integer NOT NULL,
    parent_id integer,
    group_id integer,
    type public.characteristic_type,
    system_type public.characteristic_system_type,
    alias public.citext,
    sort integer NOT NULL,
    CONSTRAINT characteristic_check CHECK ((characteristic_id <> parent_id))
);


--
-- Name: characteristic_characteristic_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.characteristic_characteristic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: characteristic_characteristic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.characteristic_characteristic_id_seq OWNED BY public.characteristic.characteristic_id;


--
-- Name: characteristic_product_val; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic_product_val (
    value_id integer NOT NULL,
    product_id integer NOT NULL,
    characteristic_id integer NOT NULL,
    case_id integer
);


--
-- Name: characteristic_product_val_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic_product_val_text (
    value_id integer NOT NULL,
    lang_id integer NOT NULL,
    value text
);


--
-- Name: characteristic_product_val_value_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.characteristic_product_val_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: characteristic_product_val_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.characteristic_product_val_value_id_seq OWNED BY public.characteristic_product_val.value_id;


--
-- Name: characteristic_prop; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic_prop (
    characteristic_id integer NOT NULL,
    is_folder boolean DEFAULT false NOT NULL,
    is_hidden boolean DEFAULT false NOT NULL,
    default_value public.citext
);


--
-- Name: characteristic_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic_text (
    characteristic_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    help public.citext
);


--
-- Name: characteristic_type_case; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic_type_case (
    case_id integer NOT NULL,
    characteristic_id integer NOT NULL,
    sort integer
);


--
-- Name: characteristic_type_case_case_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.characteristic_type_case_case_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: characteristic_type_case_case_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.characteristic_type_case_case_id_seq OWNED BY public.characteristic_type_case.case_id;


--
-- Name: characteristic_type_case_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic_type_case_text (
    case_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: characteristic_variant_val; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic_variant_val (
    value_id integer NOT NULL,
    variant_id integer NOT NULL,
    characteristic_id integer NOT NULL,
    case_id integer,
    rel_type public.product_variant_characteristic_type NOT NULL
);


--
-- Name: characteristic_variant_val_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.characteristic_variant_val_text (
    value_id integer NOT NULL,
    lang_id integer NOT NULL,
    value public.citext
);


--
-- Name: characteristic_variant_val_value_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.characteristic_variant_val_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: characteristic_variant_val_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.characteristic_variant_val_value_id_seq OWNED BY public.characteristic_variant_val.value_id;


--
-- Name: city; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.city (
    city_id integer NOT NULL,
    country_id integer NOT NULL,
    region_id integer,
    area_id integer,
    vk_id bigint,
    is_important boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    vk_no_region boolean
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'city'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN city_id OPTIONS (
    column_name 'city_id'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN country_id OPTIONS (
    column_name 'country_id'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN region_id OPTIONS (
    column_name 'region_id'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN area_id OPTIONS (
    column_name 'area_id'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN vk_id OPTIONS (
    column_name 'vk_id'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN is_important OPTIONS (
    column_name 'is_important'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN created_at OPTIONS (
    column_name 'created_at'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN deleted_at OPTIONS (
    column_name 'deleted_at'
);
ALTER FOREIGN TABLE public.city ALTER COLUMN vk_no_region OPTIONS (
    column_name 'vk_no_region'
);


--
-- Name: city_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.city_text (
    city_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'city_text'
);
ALTER FOREIGN TABLE public.city_text ALTER COLUMN city_id OPTIONS (
    column_name 'city_id'
);
ALTER FOREIGN TABLE public.city_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.city_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: collection; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collection (
    collection_id integer NOT NULL,
    site_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    alias public.citext,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: collection_collection_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.collection_collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: collection_collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.collection_collection_id_seq OWNED BY public.collection.collection_id;


--
-- Name: collection_product_rel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.collection_product_rel (
    rel_id integer NOT NULL,
    collection_id integer NOT NULL,
    product_id integer NOT NULL,
    sort integer
);


--
-- Name: collection_product_rel_rel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.collection_product_rel_rel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: collection_product_rel_rel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.collection_product_rel_rel_id_seq OWNED BY public.collection_product_rel.rel_id;


--
-- Name: commodity_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commodity_group (
    group_id integer NOT NULL,
    type public.product_type,
    unit_id integer,
    not_track_inventory boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    yml_export boolean DEFAULT true NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    vat character varying(20) DEFAULT 'noVat'::character varying NOT NULL,
    physical_products boolean DEFAULT true NOT NULL
);


--
-- Name: commodity_group_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commodity_group_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commodity_group_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commodity_group_group_id_seq OWNED BY public.commodity_group.group_id;


--
-- Name: commodity_group_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commodity_group_text (
    group_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: consumed_space; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.consumed_space (
    space_id integer NOT NULL,
    type public.space_type NOT NULL,
    volume bigint DEFAULT 0 NOT NULL,
    bucket character varying(100),
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: consumed_space_space_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.consumed_space_space_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: consumed_space_space_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.consumed_space_space_id_seq OWNED BY public.consumed_space.space_id;


--
-- Name: country; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.country (
    country_id integer NOT NULL,
    code character varying(2),
    vk_id bigint,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'country'
);
ALTER FOREIGN TABLE public.country ALTER COLUMN country_id OPTIONS (
    column_name 'country_id'
);
ALTER FOREIGN TABLE public.country ALTER COLUMN code OPTIONS (
    column_name 'code'
);
ALTER FOREIGN TABLE public.country ALTER COLUMN vk_id OPTIONS (
    column_name 'vk_id'
);
ALTER FOREIGN TABLE public.country ALTER COLUMN created_at OPTIONS (
    column_name 'created_at'
);
ALTER FOREIGN TABLE public.country ALTER COLUMN deleted_at OPTIONS (
    column_name 'deleted_at'
);


--
-- Name: country_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.country_text (
    country_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'country_text'
);
ALTER FOREIGN TABLE public.country_text ALTER COLUMN country_id OPTIONS (
    column_name 'country_id'
);
ALTER FOREIGN TABLE public.country_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.country_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: coupon_campaign; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon_campaign (
    campaign_id integer NOT NULL,
    title character varying(255) NOT NULL,
    discount_type public.discount_type,
    discount_value numeric(20,2),
    limit_usage_per_code smallint,
    limit_usage_per_customer smallint,
    min_order_amount numeric(20,2),
    created_at timestamp with time zone DEFAULT now(),
    deleted_at timestamp with time zone
);


--
-- Name: coupon_campaign_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_campaign_campaign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupon_campaign_campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_campaign_campaign_id_seq OWNED BY public.coupon_campaign.campaign_id;


--
-- Name: coupon_code; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon_code (
    code_id integer NOT NULL,
    campaign_id integer NOT NULL,
    code public.citext NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: coupon_code_code_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_code_code_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupon_code_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_code_code_id_seq OWNED BY public.coupon_code.code_id;


--
-- Name: cross_sell; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cross_sell (
    cross_sell_id integer NOT NULL,
    category_id integer NOT NULL,
    product_id integer NOT NULL,
    rel_product_id integer NOT NULL,
    sort integer
);


--
-- Name: cross_sell_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cross_sell_category (
    category_id integer NOT NULL,
    alias character varying(20) NOT NULL,
    title character varying(255) NOT NULL
);


--
-- Name: cross_sell_category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cross_sell_category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cross_sell_category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cross_sell_category_category_id_seq OWNED BY public.cross_sell_category.category_id;


--
-- Name: cross_sell_cross_sell_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cross_sell_cross_sell_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cross_sell_cross_sell_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cross_sell_cross_sell_id_seq OWNED BY public.cross_sell.cross_sell_id;


--
-- Name: currency; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.currency (
    currency_id integer NOT NULL,
    alias character varying(3) NOT NULL,
    code integer NOT NULL,
    title character varying(255)
);


--
-- Name: currency_currency_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.currency_currency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: currency_currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.currency_currency_id_seq OWNED BY public.currency.currency_id;


--
-- Name: custom_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.custom_item (
    custom_item_id integer NOT NULL,
    title character varying(255) NOT NULL,
    price numeric(20,2) NOT NULL
);


--
-- Name: custom_item_custom_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.custom_item_custom_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: custom_item_custom_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.custom_item_custom_item_id_seq OWNED BY public.custom_item.custom_item_id;


--
-- Name: customer_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_group (
    group_id integer NOT NULL,
    alias public.citext,
    price_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: customer_group_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_group_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_group_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_group_group_id_seq OWNED BY public.customer_group.group_id;


--
-- Name: customer_group_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_group_text (
    group_id integer,
    lang_id integer,
    title public.citext
);


--
-- Name: delivery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery (
    delivery_id integer NOT NULL,
    alias public.citext,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    shipping_id integer,
    shipping_config jsonb,
    location_shipping_id integer,
    free_shipping_from numeric(20,2),
    calc_method public.delivery_calc_method,
    img character varying(255),
    status public.publishing_status DEFAULT 'published'::public.publishing_status NOT NULL,
    created_by integer,
    tax character varying(30),
    mark_up character varying(255) DEFAULT NULL::character varying
);


--
-- Name: delivery_city; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_city (
    delivery_city_id integer NOT NULL,
    delivery_site_id integer NOT NULL,
    city_id integer NOT NULL,
    rate numeric(20,2)
);


--
-- Name: delivery_city_delivery_city_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_city_delivery_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_city_delivery_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_city_delivery_city_id_seq OWNED BY public.delivery_city.delivery_city_id;


--
-- Name: delivery_city_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_city_text (
    delivery_city_id integer,
    lang_id integer,
    delivery_time public.citext
);


--
-- Name: delivery_country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_country (
    delivery_country_id integer NOT NULL,
    delivery_site_id integer NOT NULL,
    country_id integer NOT NULL,
    all_city boolean DEFAULT true NOT NULL,
    rate numeric(20,2)
);


--
-- Name: delivery_country_delivery_country_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_country_delivery_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_country_delivery_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_country_delivery_country_id_seq OWNED BY public.delivery_country.delivery_country_id;


--
-- Name: delivery_country_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_country_text (
    delivery_country_id integer,
    lang_id integer,
    delivery_time public.citext
);


--
-- Name: delivery_delivery_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_delivery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_delivery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_delivery_id_seq OWNED BY public.delivery.delivery_id;


--
-- Name: delivery_exclude_city; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_exclude_city (
    delivery_site_id integer NOT NULL,
    city_id integer NOT NULL
);


--
-- Name: delivery_site; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_site (
    delivery_site_id integer NOT NULL,
    site_id integer NOT NULL,
    delivery_id integer NOT NULL,
    sort integer NOT NULL
);


--
-- Name: delivery_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_text (
    delivery_id integer,
    lang_id integer,
    title public.citext,
    description text
);


--
-- Name: edost_region; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.edost_region (
    edost_region_id integer NOT NULL,
    region_id integer NOT NULL,
    title character varying(255)
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'edost_region'
);
ALTER FOREIGN TABLE public.edost_region ALTER COLUMN edost_region_id OPTIONS (
    column_name 'edost_region_id'
);
ALTER FOREIGN TABLE public.edost_region ALTER COLUMN region_id OPTIONS (
    column_name 'region_id'
);
ALTER FOREIGN TABLE public.edost_region ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: essence; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.essence (
    essence_id integer NOT NULL,
    type public.essence_type NOT NULL,
    essence_local_id integer NOT NULL
);


--
-- Name: essence_essence_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.essence_essence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: essence_essence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.essence_essence_id_seq OWNED BY public.essence.essence_id;


--
-- Name: feeds; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feeds (
    feed_id integer NOT NULL,
    title character varying(255) NOT NULL,
    type public.feed_type NOT NULL,
    conditions json DEFAULT '{}'::json NOT NULL,
    is_protected json,
    data json DEFAULT '{}'::json NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: feeds_feed_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.feeds_feed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: feeds_feed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.feeds_feed_id_seq OWNED BY public.feeds.feed_id;


--
-- Name: filter; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.filter (
    filter_id integer NOT NULL,
    title character varying(255),
    is_default boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: filter_field; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.filter_field (
    field_id integer NOT NULL,
    filter_id integer NOT NULL,
    type public.filter_field_type NOT NULL,
    characteristic_id integer,
    sort integer NOT NULL
);


--
-- Name: filter_field_field_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.filter_field_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: filter_field_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.filter_field_field_id_seq OWNED BY public.filter_field.field_id;


--
-- Name: filter_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.filter_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: filter_filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.filter_filter_id_seq OWNED BY public.filter.filter_id;


--
-- Name: final_price; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.final_price (
    point_id integer NOT NULL,
    item_id integer NOT NULL,
    price_id integer NOT NULL,
    currency_id integer NOT NULL,
    value numeric(20,2),
    min numeric(20,2),
    max numeric(20,2),
    is_auto_generated boolean DEFAULT true NOT NULL,
    old numeric(20,2),
    old_min numeric(20,2),
    old_max numeric(20,2)
);


--
-- Name: image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.image (
    image_id integer NOT NULL,
    site_id integer,
    lang_id integer,
    name text,
    size integer,
    path character varying(255),
    width integer,
    height integer,
    used_in public.image_used_in[],
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    mime_type character varying(255)
);


--
-- Name: image_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.image_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: image_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.image_image_id_seq OWNED BY public.image.image_id;


--
-- Name: image_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.image_tag (
    image_tag_id integer NOT NULL,
    title character varying(100)
);


--
-- Name: image_tag_image_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.image_tag_image_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: image_tag_image_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.image_tag_image_tag_id_seq OWNED BY public.image_tag.image_tag_id;


--
-- Name: image_tag_rel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.image_tag_rel (
    image_tag_id integer NOT NULL,
    product_image_id integer NOT NULL
);


--
-- Name: inventory_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_item (
    item_id integer NOT NULL,
    product_id integer,
    variant_id integer,
    available_qty integer DEFAULT 0 NOT NULL,
    reserved_qty integer DEFAULT 0 NOT NULL,
    custom_item_id integer,
    CONSTRAINT inventory_item_check CHECK ((((
CASE
    WHEN (product_id IS NOT NULL) THEN 1
    ELSE 0
END +
CASE
    WHEN (variant_id IS NOT NULL) THEN 1
    ELSE 0
END) +
CASE
    WHEN (custom_item_id IS NOT NULL) THEN 1
    ELSE 0
END) = 1))
);


--
-- Name: inventory_item_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_item_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_item_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_item_item_id_seq OWNED BY public.inventory_item.item_id;


--
-- Name: inventory_location; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_location (
    location_id integer NOT NULL,
    warehouse_id integer,
    CONSTRAINT inventory_location_warehouse_id_check CHECK ((
CASE
    WHEN (warehouse_id IS NOT NULL) THEN 1
    ELSE 0
END = 1))
);


--
-- Name: inventory_location_location_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_location_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_location_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_location_location_id_seq OWNED BY public.inventory_location.location_id;


--
-- Name: inventory_movement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_movement (
    movement_id integer NOT NULL,
    reason_id integer NOT NULL,
    person_id integer,
    reserve_id integer,
    props jsonb,
    notes public.citext,
    ts timestamp with time zone DEFAULT now() NOT NULL,
    order_id integer
);


--
-- Name: inventory_movement_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_movement_item (
    movement_item_id integer NOT NULL,
    movement_id integer NOT NULL,
    item_id integer NOT NULL,
    from_location_id integer,
    to_location_id integer,
    available_qty_diff integer NOT NULL,
    reserved_qty_diff integer
);


--
-- Name: TABLE inventory_movement_item; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.inventory_movement_item IS 'difference in available quantity';


--
-- Name: inventory_movement_item_movement_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_movement_item_movement_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_movement_item_movement_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_movement_item_movement_item_id_seq OWNED BY public.inventory_movement_item.movement_item_id;


--
-- Name: inventory_movement_movement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_movement_movement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_movement_movement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_movement_movement_id_seq OWNED BY public.inventory_movement.movement_id;


--
-- Name: inventory_option; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_option (
    option_id integer NOT NULL,
    category public.inventory_option_category NOT NULL,
    alias public.citext,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: inventory_option_option_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_option_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_option_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_option_option_id_seq OWNED BY public.inventory_option.option_id;


--
-- Name: inventory_option_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_option_text (
    option_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: inventory_price; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_price (
    item_id integer NOT NULL,
    price_id integer NOT NULL,
    value numeric(20,2) NOT NULL,
    currency_id integer NOT NULL,
    old numeric(20,2)
);


--
-- Name: inventory_stock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_stock (
    stock_id integer NOT NULL,
    location_id integer NOT NULL,
    item_id integer NOT NULL,
    supply_id integer,
    available_qty integer DEFAULT 0 NOT NULL,
    reserved_qty integer DEFAULT 0 NOT NULL,
    CONSTRAINT inventory_stock_available_qty_check CHECK ((available_qty >= 0)),
    CONSTRAINT inventory_stock_reserved_qty_check CHECK ((reserved_qty >= 0))
);


--
-- Name: inventory_stock_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_stock_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_stock_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_stock_stock_id_seq OWNED BY public.inventory_stock.stock_id;


--
-- Name: inventory_supply; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory_supply (
    supply_id integer NOT NULL
);


--
-- Name: inventory_supply_supply_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_supply_supply_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory_supply_supply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inventory_supply_supply_id_seq OWNED BY public.inventory_supply.supply_id;


--
-- Name: item_price; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.item_price (
    item_price_id integer NOT NULL,
    price_id integer,
    basic_price numeric(20,2),
    final_price numeric(20,2),
    discount_amount numeric(20,2),
    discount_percent numeric(5,2)
);


--
-- Name: item_price_item_price_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.item_price_item_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: item_price_item_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.item_price_item_price_id_seq OWNED BY public.item_price.item_price_id;


--
-- Name: label; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.label (
    label_id integer NOT NULL,
    color character varying(7) NOT NULL,
    text_color character varying(7) DEFAULT '#000'::character varying NOT NULL,
    icon character varying(20),
    remove_after integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: label_label_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.label_label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: label_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.label_label_id_seq OWNED BY public.label.label_id;


--
-- Name: label_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.label_text (
    label_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(255)
);


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
-- Name: lang_title; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lang_title (
    lang_id integer NOT NULL,
    in_lang_id integer NOT NULL,
    title character varying(100) NOT NULL
);


--
-- Name: manufacturer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufacturer (
    manufacturer_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    layout character varying(255),
    deleted_at timestamp with time zone,
    image_id integer,
    status public.publishing_status DEFAULT 'published'::public.publishing_status NOT NULL,
    created_by integer
);


--
-- Name: manufacturer_manufacturer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.manufacturer_manufacturer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: manufacturer_manufacturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.manufacturer_manufacturer_id_seq OWNED BY public.manufacturer.manufacturer_id;


--
-- Name: manufacturer_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.manufacturer_text (
    manufacturer_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    custom_title text,
    custom_header text,
    meta_description text,
    meta_keywords text,
    url_key public.citext,
    description text
);


--
-- Name: menu_block; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menu_block (
    block_id integer NOT NULL,
    site_id integer NOT NULL,
    key character varying(100) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: menu_block_block_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.menu_block_block_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menu_block_block_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.menu_block_block_id_seq OWNED BY public.menu_block.block_id;


--
-- Name: menu_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menu_item (
    item_id integer NOT NULL,
    block_id integer NOT NULL,
    lang_id integer NOT NULL,
    parent_id integer,
    type public.menu_item_type NOT NULL,
    title text,
    url text,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    highlight boolean DEFAULT false NOT NULL,
    css_class character varying(255),
    CONSTRAINT menu_item_check CHECK ((item_id <> parent_id))
);


--
-- Name: menu_item_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.menu_item_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: menu_item_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.menu_item_item_id_seq OWNED BY public.menu_item.item_id;


--
-- Name: menu_item_rel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menu_item_rel (
    item_id integer NOT NULL,
    category_id integer,
    page_id integer,
    product_id integer
);


--
-- Name: notification_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_history (
    notification_id integer NOT NULL,
    recipient character varying(500) NOT NULL,
    type public.notification_type NOT NULL,
    essence_id integer,
    text text,
    sent_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: notification_history_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_history_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notification_history_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_history_notification_id_seq OWNED BY public.notification_history.notification_id;


--
-- Name: notification_template; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_template (
    template_id integer NOT NULL,
    status_id integer,
    transport public.notify_transport,
    subject text,
    template text,
    event_type public.queue_event_type
);


--
-- Name: notification_template_template_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_template_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notification_template_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_template_template_id_seq OWNED BY public.notification_template.template_id;


--
-- Name: offer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offer (
    offer_id integer NOT NULL,
    product_id integer NOT NULL,
    price numeric(20,2),
    created_at timestamp with time zone DEFAULT now(),
    deleted_at timestamp with time zone
);


--
-- Name: offer_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.offer_offer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: offer_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.offer_offer_id_seq OWNED BY public.offer.offer_id;


--
-- Name: order_attrs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_attrs (
    attr_id integer NOT NULL,
    title character varying(255) NOT NULL,
    key character varying(20) NOT NULL,
    type public.attrs_html_type NOT NULL,
    options json,
    hint character varying(1000),
    sort integer DEFAULT 0 NOT NULL
);


--
-- Name: order_attrs_attr_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_attrs_attr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_attrs_attr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_attrs_attr_id_seq OWNED BY public.order_attrs.attr_id;


--
-- Name: order_discount; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_discount (
    discount_id integer NOT NULL,
    order_id integer NOT NULL,
    title character varying(255),
    discount_type public.discount_type,
    value numeric(20,2),
    source public.order_discount_source,
    code_id integer,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: order_discount_discount_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_discount_discount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_discount_discount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_discount_discount_id_seq OWNED BY public.order_discount.discount_id;


--
-- Name: order_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_history (
    history_id integer NOT NULL,
    order_id integer NOT NULL,
    status_id integer NOT NULL,
    person_id integer,
    changed_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: order_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_history_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_history_history_id_seq OWNED BY public.order_history.history_id;


--
-- Name: order_prop; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_prop (
    order_id integer NOT NULL,
    client_comment text,
    custom_attrs jsonb
);


--
-- Name: order_service; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_service (
    order_service_id integer NOT NULL,
    order_id integer NOT NULL,
    service_id integer,
    qty integer DEFAULT 0 NOT NULL,
    total_price numeric(20,2),
    item_price_id integer,
    is_delivery boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: order_service_delivery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_service_delivery (
    order_service_id integer NOT NULL,
    delivery_id integer,
    title character varying(255),
    text_info character varying(1000),
    data json
);


--
-- Name: order_service_order_service_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_service_order_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_service_order_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_service_order_service_id_seq OWNED BY public.order_service.order_service_id;


--
-- Name: order_source; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_source (
    source_id integer NOT NULL,
    alias public.citext,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: order_source_source_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_source_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_source_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_source_source_id_seq OWNED BY public.order_source.source_id;


--
-- Name: order_source_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_source_text (
    source_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: order_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_status (
    status_id integer NOT NULL,
    parent_id integer,
    alias public.citext,
    background_color character varying(6),
    stock_location public.order_status_stock_location DEFAULT 'inside'::public.order_status_stock_location NOT NULL,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    CONSTRAINT order_status_check CHECK ((status_id <> parent_id))
);


--
-- Name: order_status_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_status_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_status_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_status_status_id_seq OWNED BY public.order_status.status_id;


--
-- Name: order_status_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_status_text (
    status_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: track_number; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.track_number (
    track_number_id integer NOT NULL,
    order_id integer NOT NULL,
    track_number public.citext,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: order_track_number_track_number_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_track_number_track_number_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_track_number_track_number_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_track_number_track_number_id_seq OWNED BY public.track_number.track_number_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    source_id integer,
    status_id integer,
    point_id integer,
    customer_id integer,
    basket_id integer,
    payment_method_id integer,
    service_total_price numeric(20,2),
    service_total_qty integer DEFAULT 0 NOT NULL,
    total_price numeric(20,2),
    created_by integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    confirmed_at timestamp with time zone,
    paid_at timestamp with time zone,
    payment_mark_up numeric(20,2) DEFAULT 0 NOT NULL,
    discount_for_order numeric(20,2) DEFAULT 0 NOT NULL,
    got_cash_at timestamp with time zone,
    publishing_status public.publishing_status DEFAULT 'published'::public.publishing_status NOT NULL,
    public_id uuid DEFAULT gen_random_uuid(),
    tax_amount numeric(20,2) DEFAULT NULL::numeric,
    tax_calculations json DEFAULT '{}'::json NOT NULL
);


--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: page_page_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_page_id_seq OWNED BY public.page.page_id;


--
-- Name: page_props; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page_props (
    page_id integer NOT NULL,
    custom_title text,
    custom_header text,
    meta_description text,
    meta_keywords text
);


--
-- Name: payment_callback; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_callback (
    payment_callback_id integer NOT NULL,
    payment_transaction_id integer,
    response json,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: payment_callback_payment_callback_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_callback_payment_callback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_callback_payment_callback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_callback_payment_callback_id_seq OWNED BY public.payment_callback.payment_callback_id;


--
-- Name: payment_gateway; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.payment_gateway (
    payment_gateway_id integer NOT NULL,
    alias character varying(20),
    settings jsonb,
    sort integer NOT NULL
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'payment_gateway'
);
ALTER FOREIGN TABLE public.payment_gateway ALTER COLUMN payment_gateway_id OPTIONS (
    column_name 'payment_gateway_id'
);
ALTER FOREIGN TABLE public.payment_gateway ALTER COLUMN alias OPTIONS (
    column_name 'alias'
);
ALTER FOREIGN TABLE public.payment_gateway ALTER COLUMN settings OPTIONS (
    column_name 'settings'
);
ALTER FOREIGN TABLE public.payment_gateway ALTER COLUMN sort OPTIONS (
    column_name 'sort'
);


--
-- Name: payment_gateway_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.payment_gateway_text (
    payment_gateway_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(100),
    description text
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'payment_gateway_text'
);
ALTER FOREIGN TABLE public.payment_gateway_text ALTER COLUMN payment_gateway_id OPTIONS (
    column_name 'payment_gateway_id'
);
ALTER FOREIGN TABLE public.payment_gateway_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.payment_gateway_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);
ALTER FOREIGN TABLE public.payment_gateway_text ALTER COLUMN description OPTIONS (
    column_name 'description'
);


--
-- Name: payment_method; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_method (
    payment_method_id integer NOT NULL,
    site_id integer NOT NULL,
    payment_gateway_id integer,
    for_all_delivery boolean DEFAULT true,
    config jsonb,
    mark_up numeric(5,3) DEFAULT 0 NOT NULL,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: payment_method_delivery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_method_delivery (
    payment_method_id integer NOT NULL,
    delivery_site_id integer NOT NULL
);


--
-- Name: payment_method_payment_method_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_method_payment_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_method_payment_method_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_method_payment_method_id_seq OWNED BY public.payment_method.payment_method_id;


--
-- Name: payment_method_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_method_text (
    payment_method_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(255)
);


--
-- Name: payment_request; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_request (
    payment_request_id integer NOT NULL,
    payment_transaction_id integer NOT NULL,
    request json,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: payment_request_payment_request_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_request_payment_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_request_payment_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_request_payment_request_id_seq OWNED BY public.payment_request.payment_request_id;


--
-- Name: payment_transaction; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_transaction (
    payment_transaction_id integer NOT NULL,
    payment_method_id integer NOT NULL,
    status public.payment_transaction_status DEFAULT 'created'::public.payment_transaction_status NOT NULL,
    mark_up_amount numeric(20,2) DEFAULT 0 NOT NULL,
    total_amount numeric(20,2) DEFAULT 0 NOT NULL,
    currency_id integer NOT NULL,
    external_id character varying(255),
    order_id integer,
    person_id integer,
    data jsonb,
    error jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT payment_transaction_total_amount_check CHECK ((total_amount >= (0)::numeric))
);


--
-- Name: payment_transaction_payment_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_transaction_payment_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_transaction_payment_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_transaction_payment_transaction_id_seq OWNED BY public.payment_transaction.payment_transaction_id;


--
-- Name: person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person (
    person_id integer NOT NULL,
    site_id integer NOT NULL,
    email character varying(255),
    registered_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    is_owner boolean DEFAULT false NOT NULL,
    status public.publishing_status DEFAULT 'published'::public.publishing_status NOT NULL,
    created_by integer,
    public_id uuid DEFAULT gen_random_uuid()
);


--
-- Name: person_address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_address (
    address_id integer NOT NULL,
    person_id integer NOT NULL,
    type public.address_type,
    is_default boolean DEFAULT false NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    company character varying(200),
    address_line_1 character varying(300),
    address_line_2 character varying(300),
    city character varying(100),
    state character varying(100),
    country_id integer,
    zip character varying(100),
    phone character varying(100),
    comment text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    public_id uuid DEFAULT gen_random_uuid()
);


--
-- Name: person_address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_address_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_address_address_id_seq OWNED BY public.person_address.address_id;


--
-- Name: person_attrs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_attrs (
    attr_id integer NOT NULL,
    title character varying(255) NOT NULL,
    key character varying(20) NOT NULL,
    type public.attrs_html_type NOT NULL,
    options json,
    hint character varying(1000),
    sort integer DEFAULT 0 NOT NULL
);


--
-- Name: person_attrs_attr_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_attrs_attr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_attrs_attr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_attrs_attr_id_seq OWNED BY public.person_attrs.attr_id;


--
-- Name: person_auth; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_auth (
    person_id integer NOT NULL,
    pass character varying(100),
    email_confirmed timestamp with time zone
);


--
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_person_id_seq OWNED BY public.person.person_id;


--
-- Name: person_profile; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_profile (
    person_id integer NOT NULL,
    first_name public.citext,
    last_name public.citext,
    patronymic public.citext,
    group_id integer,
    phone character varying(100),
    receive_marketing_info boolean DEFAULT false NOT NULL,
    comment text,
    custom_attrs jsonb
);


--
-- Name: person_role_rel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_role_rel (
    person_id integer NOT NULL,
    role_id integer NOT NULL
);


--
-- Name: person_search; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_search (
    person_id integer NOT NULL,
    search text
);


--
-- Name: person_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_settings (
    person_id integer NOT NULL,
    settings jsonb
);


--
-- Name: person_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_token (
    token_id integer NOT NULL,
    person_id integer NOT NULL,
    type character varying(30) NOT NULL,
    token_1 character varying(50) NOT NULL,
    token_2 character varying(10) NOT NULL,
    ip inet,
    valid_till timestamp with time zone,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: person_token_token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_token_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: person_token_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_token_token_id_seq OWNED BY public.person_token.token_id;


--
-- Name: person_visitor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person_visitor (
    person_id integer NOT NULL,
    user_agent text
);


--
-- Name: point_sale; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.point_sale (
    point_id integer NOT NULL,
    site_id integer,
    CONSTRAINT point_sale_signle_reference CHECK ((
CASE
    WHEN (site_id IS NOT NULL) THEN 1
    ELSE 0
END = 1))
);


--
-- Name: point_sale_point_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.point_sale_point_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: point_sale_point_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.point_sale_point_id_seq OWNED BY public.point_sale.point_id;


--
-- Name: price; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price (
    price_id integer NOT NULL,
    alias public.citext NOT NULL,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    has_old_price boolean DEFAULT false NOT NULL
);


--
-- Name: price_price_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.price_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: price_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.price_price_id_seq OWNED BY public.price.price_id;


--
-- Name: price_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.price_text (
    price_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product (
    product_id integer NOT NULL,
    sku public.citext,
    manufacturer_id integer,
    group_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    has_variants boolean DEFAULT false NOT NULL,
    external_id public.citext,
    status public.publishing_status DEFAULT 'published'::public.publishing_status NOT NULL,
    created_by integer
);


--
-- Name: product_category_rel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_category_rel (
    category_id integer NOT NULL,
    product_id integer NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    sort integer
);


--
-- Name: product_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_image (
    product_image_id integer NOT NULL,
    product_id integer NOT NULL,
    image_id integer NOT NULL,
    is_default boolean NOT NULL,
    sort integer NOT NULL,
    source_url text
);


--
-- Name: product_image_product_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_image_product_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_image_product_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_image_product_image_id_seq OWNED BY public.product_image.product_image_id;


--
-- Name: product_image_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_image_text (
    product_image_id integer NOT NULL,
    lang_id integer NOT NULL,
    description text,
    alt text
);


--
-- Name: product_import; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_import (
    import_id integer NOT NULL,
    site_id integer NOT NULL,
    lang_id integer NOT NULL,
    person_id integer NOT NULL,
    type public.product_import_type NOT NULL,
    run public.product_import_run_type NOT NULL,
    source_type public.product_import_source_type NOT NULL,
    file_name character varying(255),
    file_path character varying(255),
    url character varying(255),
    settings jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    cloud_path character varying(255)
);


--
-- Name: product_import_imgs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_import_imgs (
    import_id integer NOT NULL,
    url text,
    product_id integer NOT NULL,
    status public.product_import_image_status DEFAULT 'new'::public.product_import_image_status NOT NULL,
    reason character varying(500),
    import_img_id integer NOT NULL
);


--
-- Name: product_import_imgs_import_img_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_import_imgs_import_img_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_import_imgs_import_img_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_import_imgs_import_img_id_seq OWNED BY public.product_import_imgs.import_img_id;


--
-- Name: product_import_import_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_import_import_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_import_import_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_import_import_id_seq OWNED BY public.product_import.import_id;


--
-- Name: product_import_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_import_log (
    log_id integer NOT NULL,
    import_id integer NOT NULL,
    file_name character varying(255),
    file_path character varying(255),
    status public.product_import_status NOT NULL,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    completed_at timestamp with time zone,
    result jsonb
);


--
-- Name: product_import_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_import_log_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_import_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_import_log_log_id_seq OWNED BY public.product_import_log.log_id;


--
-- Name: product_import_rel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_import_rel (
    log_id integer NOT NULL,
    product_id integer,
    category_id integer,
    status public.product_import_rel_status NOT NULL,
    message jsonb,
    variant_id integer
);


--
-- Name: product_label_rel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_label_rel (
    label_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: product_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_product_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_product_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_product_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_product_id_seq1 OWNED BY public.product.product_id;


--
-- Name: product_prop; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_prop (
    product_id integer NOT NULL,
    available_qty integer DEFAULT 0 NOT NULL,
    reserved_qty integer DEFAULT 0 NOT NULL,
    layout character varying(255),
    country_of_origin integer,
    extra jsonb,
    size jsonb DEFAULT '{}'::jsonb NOT NULL,
    characteristic jsonb,
    tax_status public.tax_status DEFAULT 'taxable'::public.tax_status NOT NULL,
    tax_class_id integer,
    arbitrary_data jsonb
);


--
-- Name: product_review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_review (
    review_id integer NOT NULL,
    order_id integer,
    product_id integer,
    name character varying(255) DEFAULT NULL::character varying,
    rating smallint,
    text text,
    status public.publishing_status DEFAULT 'published'::public.publishing_status NOT NULL,
    created_by integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: product_review_img; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_review_img (
    review_img_id integer NOT NULL,
    review_id integer NOT NULL,
    image_id integer NOT NULL,
    sort integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: product_review_img_review_img_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_review_img_review_img_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_review_img_review_img_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_review_img_review_img_id_seq OWNED BY public.product_review_img.review_img_id;


--
-- Name: product_review_review_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_review_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_review_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_review_review_id_seq OWNED BY public.product_review.review_id;


--
-- Name: product_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_text (
    product_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    custom_title text,
    custom_header text,
    meta_description text,
    meta_keywords text,
    url_key public.citext,
    description text
);


--
-- Name: product_variant_characteristic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variant_characteristic (
    rel_id integer NOT NULL,
    product_id integer NOT NULL,
    characteristic_id integer NOT NULL,
    rel_type public.product_variant_characteristic_type NOT NULL,
    sort integer NOT NULL
);


--
-- Name: TABLE product_variant_characteristic; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.product_variant_characteristic IS 'Relation between characteristics for variants and product.';


--
-- Name: COLUMN product_variant_characteristic.rel_type; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.product_variant_characteristic.rel_type IS 'variant - for variant generation
redefine - variant redefine characteristic';


--
-- Name: product_variant_characteristic_rel_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_variant_characteristic_rel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_variant_characteristic_rel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_variant_characteristic_rel_id_seq OWNED BY public.product_variant_characteristic.rel_id;


--
-- Name: product_yml; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_yml (
    product_id integer NOT NULL,
    yml_export boolean DEFAULT true NOT NULL,
    vendor_code character varying(255),
    model character varying(255),
    title text,
    description text,
    sales_notes character varying(50),
    manufacturer_warranty boolean,
    seller_warranty boolean,
    adult boolean,
    age character varying(3),
    cpa boolean
);


--
-- Name: region; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.region (
    region_id integer NOT NULL,
    country_id integer,
    vk_id bigint,
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'region'
);
ALTER FOREIGN TABLE public.region ALTER COLUMN region_id OPTIONS (
    column_name 'region_id'
);
ALTER FOREIGN TABLE public.region ALTER COLUMN country_id OPTIONS (
    column_name 'country_id'
);
ALTER FOREIGN TABLE public.region ALTER COLUMN vk_id OPTIONS (
    column_name 'vk_id'
);
ALTER FOREIGN TABLE public.region ALTER COLUMN created_at OPTIONS (
    column_name 'created_at'
);
ALTER FOREIGN TABLE public.region ALTER COLUMN deleted_at OPTIONS (
    column_name 'deleted_at'
);


--
-- Name: region_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.region_text (
    region_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'region_text'
);
ALTER FOREIGN TABLE public.region_text ALTER COLUMN region_id OPTIONS (
    column_name 'region_id'
);
ALTER FOREIGN TABLE public.region_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.region_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: reserve; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reserve (
    reserve_id integer NOT NULL,
    order_id integer,
    total_qty integer DEFAULT 0 NOT NULL,
    total_price numeric(20,2) DEFAULT NULL::numeric,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    completed_at timestamp with time zone,
    CONSTRAINT reserve_order_id_check CHECK ((
CASE
    WHEN (order_id IS NOT NULL) THEN 1
    ELSE 0
END = 1))
);


--
-- Name: reserve_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reserve_item (
    reserve_item_id integer NOT NULL,
    reserve_id integer NOT NULL,
    stock_id integer,
    item_id integer NOT NULL,
    qty integer DEFAULT 0 NOT NULL,
    total_price numeric(20,2),
    item_price_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    completed_at timestamp with time zone,
    CONSTRAINT reserve_item_qty_check CHECK ((qty >= 0))
);


--
-- Name: reserve_item_reserve_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reserve_item_reserve_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reserve_item_reserve_item_id_seq1; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reserve_item_reserve_item_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reserve_item_reserve_item_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reserve_item_reserve_item_id_seq1 OWNED BY public.reserve_item.reserve_item_id;


--
-- Name: reserve_reserve_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reserve_reserve_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reserve_reserve_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reserve_reserve_id_seq OWNED BY public.reserve.reserve_id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role (
    role_id integer NOT NULL,
    title character varying(50) NOT NULL,
    alias character varying(50)
);


--
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.role.role_id;


--
-- Name: route; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.route (
    route_id integer NOT NULL
);


--
-- Name: route_route_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.route_route_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: route_route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.route_route_id_seq OWNED BY public.route.route_id;


--
-- Name: service; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service (
    service_id integer NOT NULL,
    alias public.citext,
    show_in_list boolean DEFAULT true NOT NULL,
    price numeric(20,2),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: service_service_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.service_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: service_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.service_service_id_seq OWNED BY public.service.service_id;


--
-- Name: service_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.service_text (
    service_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: setting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.setting (
    setting_id integer NOT NULL,
    setting_group public.setting_group NOT NULL,
    key public.citext NOT NULL,
    value json
);


--
-- Name: setting_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.setting_setting_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: setting_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.setting_setting_id_seq OWNED BY public.setting.setting_id;


--
-- Name: shipping; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping (
    shipping_id integer NOT NULL,
    alias character varying(20) NOT NULL,
    settings jsonb,
    only_calculation boolean NOT NULL
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping'
);
ALTER FOREIGN TABLE public.shipping ALTER COLUMN shipping_id OPTIONS (
    column_name 'shipping_id'
);
ALTER FOREIGN TABLE public.shipping ALTER COLUMN alias OPTIONS (
    column_name 'alias'
);
ALTER FOREIGN TABLE public.shipping ALTER COLUMN settings OPTIONS (
    column_name 'settings'
);
ALTER FOREIGN TABLE public.shipping ALTER COLUMN only_calculation OPTIONS (
    column_name 'only_calculation'
);


--
-- Name: shipping_city; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_city (
    shipping_id integer NOT NULL,
    city_id integer NOT NULL,
    type character varying(20)[] NOT NULL,
    local_id character varying(255),
    local_city_title character varying(255)
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_city'
);


--
-- Name: shipping_country; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_country (
    shipping_id integer NOT NULL,
    country_id integer NOT NULL,
    local_id character varying(255)
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_country'
);
ALTER FOREIGN TABLE public.shipping_country ALTER COLUMN shipping_id OPTIONS (
    column_name 'shipping_id'
);
ALTER FOREIGN TABLE public.shipping_country ALTER COLUMN country_id OPTIONS (
    column_name 'country_id'
);
ALTER FOREIGN TABLE public.shipping_country ALTER COLUMN local_id OPTIONS (
    column_name 'local_id'
);


--
-- Name: shipping_option; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_option (
    option_id integer NOT NULL,
    shipping_id integer NOT NULL,
    type character varying(20) NOT NULL,
    alias character varying(20),
    created_at timestamp with time zone,
    deleted_at timestamp with time zone
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_option'
);


--
-- Name: shipping_option_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_option_text (
    option_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(100)
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_option_text'
);
ALTER FOREIGN TABLE public.shipping_option_text ALTER COLUMN option_id OPTIONS (
    column_name 'option_id'
);
ALTER FOREIGN TABLE public.shipping_option_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.shipping_option_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: shipping_pickup; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_pickup (
    point_id integer NOT NULL,
    shipping_id integer NOT NULL,
    city_id integer NOT NULL,
    local_id character varying(255),
    coordinate point,
    possibility_to_pay_for_order boolean,
    deleted_at timestamp with time zone
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_pickup'
);
ALTER FOREIGN TABLE public.shipping_pickup ALTER COLUMN point_id OPTIONS (
    column_name 'point_id'
);
ALTER FOREIGN TABLE public.shipping_pickup ALTER COLUMN shipping_id OPTIONS (
    column_name 'shipping_id'
);
ALTER FOREIGN TABLE public.shipping_pickup ALTER COLUMN city_id OPTIONS (
    column_name 'city_id'
);
ALTER FOREIGN TABLE public.shipping_pickup ALTER COLUMN local_id OPTIONS (
    column_name 'local_id'
);
ALTER FOREIGN TABLE public.shipping_pickup ALTER COLUMN coordinate OPTIONS (
    column_name 'coordinate'
);
ALTER FOREIGN TABLE public.shipping_pickup ALTER COLUMN possibility_to_pay_for_order OPTIONS (
    column_name 'possibility_to_pay_for_order'
);
ALTER FOREIGN TABLE public.shipping_pickup ALTER COLUMN deleted_at OPTIONS (
    column_name 'deleted_at'
);


--
-- Name: shipping_pickup_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_pickup_text (
    point_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text,
    address text,
    phone character varying(100),
    work_schedule text
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_pickup_text'
);
ALTER FOREIGN TABLE public.shipping_pickup_text ALTER COLUMN point_id OPTIONS (
    column_name 'point_id'
);
ALTER FOREIGN TABLE public.shipping_pickup_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.shipping_pickup_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);
ALTER FOREIGN TABLE public.shipping_pickup_text ALTER COLUMN address OPTIONS (
    column_name 'address'
);
ALTER FOREIGN TABLE public.shipping_pickup_text ALTER COLUMN phone OPTIONS (
    column_name 'phone'
);
ALTER FOREIGN TABLE public.shipping_pickup_text ALTER COLUMN work_schedule OPTIONS (
    column_name 'work_schedule'
);


--
-- Name: shipping_tariff; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_tariff (
    tariff_id integer NOT NULL,
    shipping_id integer NOT NULL,
    local_id character varying(20) NOT NULL,
    type character varying(20),
    service_group character varying(20),
    postomat boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    deleted_at timestamp with time zone
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_tariff'
);


--
-- Name: shipping_tariff_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_tariff_text (
    tariff_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(255)
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_tariff_text'
);
ALTER FOREIGN TABLE public.shipping_tariff_text ALTER COLUMN tariff_id OPTIONS (
    column_name 'tariff_id'
);
ALTER FOREIGN TABLE public.shipping_tariff_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.shipping_tariff_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: shipping_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_text (
    shipping_id integer NOT NULL,
    lang_id integer NOT NULL,
    title character varying(100)
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_text'
);
ALTER FOREIGN TABLE public.shipping_text ALTER COLUMN shipping_id OPTIONS (
    column_name 'shipping_id'
);
ALTER FOREIGN TABLE public.shipping_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.shipping_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);


--
-- Name: shipping_zip; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.shipping_zip (
    shipping_id integer NOT NULL,
    zip_id integer NOT NULL,
    courier boolean NOT NULL
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'shipping_zip'
);
ALTER FOREIGN TABLE public.shipping_zip ALTER COLUMN shipping_id OPTIONS (
    column_name 'shipping_id'
);
ALTER FOREIGN TABLE public.shipping_zip ALTER COLUMN zip_id OPTIONS (
    column_name 'zip_id'
);
ALTER FOREIGN TABLE public.shipping_zip ALTER COLUMN courier OPTIONS (
    column_name 'courier'
);


--
-- Name: site; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site (
    site_id integer NOT NULL,
    host character varying(100),
    settings jsonb,
    aliases jsonb,
    system_host character varying(100)
);


--
-- Name: site_country_lang; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_country_lang (
    site_id integer NOT NULL,
    country_id integer NOT NULL,
    lang_id integer NOT NULL,
    is_default boolean NOT NULL
);


--
-- Name: site_delivery_site_delivery_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_delivery_site_delivery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_delivery_site_delivery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_delivery_site_delivery_id_seq OWNED BY public.delivery_site.delivery_site_id;


--
-- Name: site_site_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_site_id_seq OWNED BY public.site.site_id;


--
-- Name: sms_provider; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.sms_provider (
    provider_id integer NOT NULL,
    alias character varying(20) NOT NULL
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'sms_provider'
);
ALTER FOREIGN TABLE public.sms_provider ALTER COLUMN provider_id OPTIONS (
    column_name 'provider_id'
);
ALTER FOREIGN TABLE public.sms_provider ALTER COLUMN alias OPTIONS (
    column_name 'alias'
);


--
-- Name: stream; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stream (
    stream_id integer NOT NULL
);


--
-- Name: stream_stream_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stream_stream_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stream_stream_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stream_stream_id_seq OWNED BY public.stream.stream_id;


--
-- Name: tax_class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_class (
    tax_class_id integer NOT NULL,
    title character varying(50) NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: tax_class_tax_class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tax_class_tax_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tax_class_tax_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tax_class_tax_class_id_seq OWNED BY public.tax_class.tax_class_id;


--
-- Name: tax_rate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tax_rate (
    tax_rate_id integer NOT NULL,
    tax_class_id integer NOT NULL,
    title character varying(50) NOT NULL,
    rate numeric(6,4) DEFAULT '0'::numeric NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    is_compound boolean DEFAULT false NOT NULL,
    include_shipping boolean DEFAULT false NOT NULL,
    country_id integer,
    state_code character varying(10),
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: tax_rate_tax_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tax_rate_tax_rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tax_rate_tax_rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tax_rate_tax_rate_id_seq OWNED BY public.tax_rate.tax_rate_id;


--
-- Name: theme; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.theme (
    theme_id integer NOT NULL,
    alias character varying(50) NOT NULL,
    is_default boolean NOT NULL,
    sort integer NOT NULL,
    preview character varying(255),
    created_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'theme'
);
ALTER FOREIGN TABLE public.theme ALTER COLUMN theme_id OPTIONS (
    column_name 'theme_id'
);
ALTER FOREIGN TABLE public.theme ALTER COLUMN alias OPTIONS (
    column_name 'alias'
);
ALTER FOREIGN TABLE public.theme ALTER COLUMN is_default OPTIONS (
    column_name 'is_default'
);
ALTER FOREIGN TABLE public.theme ALTER COLUMN sort OPTIONS (
    column_name 'sort'
);
ALTER FOREIGN TABLE public.theme ALTER COLUMN preview OPTIONS (
    column_name 'preview'
);
ALTER FOREIGN TABLE public.theme ALTER COLUMN created_at OPTIONS (
    column_name 'created_at'
);
ALTER FOREIGN TABLE public.theme ALTER COLUMN deleted_at OPTIONS (
    column_name 'deleted_at'
);


--
-- Name: theme_installed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.theme_installed (
    installed_id integer NOT NULL,
    alias character varying(50) NOT NULL,
    theme_id integer,
    is_using boolean NOT NULL,
    screen_path character varying(255),
    screen_width integer,
    screen_height integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    variables json
);


--
-- Name: theme_installed_installed_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.theme_installed_installed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: theme_installed_installed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.theme_installed_installed_id_seq OWNED BY public.theme_installed.installed_id;


--
-- Name: theme_installed_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.theme_installed_text (
    installed_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text
);


--
-- Name: theme_text; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.theme_text (
    theme_id integer NOT NULL,
    lang_id integer NOT NULL,
    title text,
    description text
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'theme_text'
);
ALTER FOREIGN TABLE public.theme_text ALTER COLUMN theme_id OPTIONS (
    column_name 'theme_id'
);
ALTER FOREIGN TABLE public.theme_text ALTER COLUMN lang_id OPTIONS (
    column_name 'lang_id'
);
ALTER FOREIGN TABLE public.theme_text ALTER COLUMN title OPTIONS (
    column_name 'title'
);
ALTER FOREIGN TABLE public.theme_text ALTER COLUMN description OPTIONS (
    column_name 'description'
);


--
-- Name: transfer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transfer (
    transfer_id integer NOT NULL,
    status public.transfer_status DEFAULT 'draft'::public.transfer_status NOT NULL,
    from_location_id integer NOT NULL,
    to_location_id integer,
    completed_movement_id integer,
    cancelled_movement_id integer,
    movement_comment text,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: transfer_item; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transfer_item (
    transfer_item_id integer NOT NULL,
    transfer_id integer NOT NULL,
    item_id integer NOT NULL,
    qty integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT transfer_item_qty_check CHECK ((qty > 0))
);


--
-- Name: transfer_item_transfer_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transfer_item_transfer_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transfer_item_transfer_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transfer_item_transfer_item_id_seq OWNED BY public.transfer_item.transfer_item_id;


--
-- Name: transfer_transfer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transfer_transfer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transfer_transfer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transfer_transfer_id_seq OWNED BY public.transfer.transfer_id;


--
-- Name: typearea; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typearea (
    typearea_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: typearea_block; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typearea_block (
    block_id integer NOT NULL,
    typearea_id integer NOT NULL,
    type public.typearea_block_type NOT NULL,
    noindex boolean DEFAULT false NOT NULL,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: typearea_block_block_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.typearea_block_block_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: typearea_block_block_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.typearea_block_block_id_seq OWNED BY public.typearea_block.block_id;


--
-- Name: typearea_block_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.typearea_block_text (
    block_id integer NOT NULL,
    value text
);


--
-- Name: typearea_typearea_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.typearea_typearea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: typearea_typearea_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.typearea_typearea_id_seq OWNED BY public.typearea.typearea_id;


--
-- Name: unit_measurement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.unit_measurement (
    unit_id integer NOT NULL,
    title character varying(255) NOT NULL
);


--
-- Name: unit_measurement_unit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.unit_measurement_unit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: unit_measurement_unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.unit_measurement_unit_id_seq OWNED BY public.unit_measurement.unit_id;


--
-- Name: variant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variant (
    variant_id integer NOT NULL,
    product_id integer,
    sku public.citext,
    cases integer[],
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    size jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: variant_image; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variant_image (
    variant_image_id integer NOT NULL,
    variant_id integer NOT NULL,
    image_id integer NOT NULL,
    is_default boolean NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: variant_image_variant_image_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variant_image_variant_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variant_image_variant_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variant_image_variant_image_id_seq OWNED BY public.variant_image.variant_image_id;


--
-- Name: variant_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variant_text (
    variant_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext
);


--
-- Name: variant_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variant_variant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variant_variant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variant_variant_id_seq OWNED BY public.variant.variant_id;


--
-- Name: vw_auth_resource_flat; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_auth_resource_flat AS
 WITH RECURSIVE vw_auth_resource_flat(resource_id, parent_id, alias, title, level, tree_sort) AS (
         SELECT auth_resource.resource_id,
            auth_resource.parent_id,
            auth_resource.alias,
            auth_resource.title,
            0 AS "?column?",
            (row_number() OVER ())::text AS row_number
           FROM public.auth_resource
          WHERE (auth_resource.parent_id IS NULL)
        UNION ALL
         SELECT r.resource_id,
            r.parent_id,
            r.alias,
            r.title,
            (v.level + 1),
            ((v.tree_sort || '.'::text) || row_number() OVER ())
           FROM (public.auth_resource r
             JOIN vw_auth_resource_flat v ON ((r.parent_id = v.resource_id)))
        )
 SELECT vw_auth_resource_flat.resource_id,
    vw_auth_resource_flat.parent_id,
    vw_auth_resource_flat.alias,
    vw_auth_resource_flat.title,
    vw_auth_resource_flat.level,
    vw_auth_resource_flat.tree_sort
   FROM vw_auth_resource_flat;


--
-- Name: vw_category_flat_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_category_flat_list AS
 WITH RECURSIVE vw_category_flat_list(category_id, site_id, lang_id, level, tree_sort, joined_title) AS (
         SELECT category.category_id,
            category.site_id,
            category_text.lang_id,
            0 AS "?column?",
            to_char(category.sort, 'FM00000000'::text) AS tree_sort,
            COALESCE(category_text.title, '{{NO_NAME}}'::public.citext) AS joined_title
           FROM (public.category
             JOIN public.category_text USING (category_id))
          WHERE ((category.parent_id IS NULL) AND (category.deleted_at IS NULL))
        UNION ALL
         SELECT c2.category_id,
            c2.site_id,
            ct.lang_id,
            (vw.level + 1),
            ((vw.tree_sort || '.'::text) || to_char(c2.sort, 'FM00000000'::text)),
            ((((vw.joined_title)::text || '/'::text) || (COALESCE(ct.title, '{{NO_NAME}}'::public.citext))::text))::public.citext AS citext
           FROM ((public.category c2
             JOIN vw_category_flat_list vw ON ((c2.parent_id = vw.category_id)))
             JOIN public.category_text ct ON (((ct.category_id = c2.category_id) AND (vw.lang_id = ct.lang_id))))
          WHERE (c2.deleted_at IS NULL)
        )
 SELECT vw_category_flat_list.category_id,
    vw_category_flat_list.site_id,
    vw_category_flat_list.lang_id,
    vw_category_flat_list.level,
    vw_category_flat_list.tree_sort,
    vw_category_flat_list.joined_title
   FROM vw_category_flat_list;


--
-- Name: vw_category_option; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_category_option AS
 WITH RECURSIVE vw_category_option(category_id, parent_id, site_id, lang_id, title, url_key, deleted_at, image_id, status, created_by, level, tree_sort) AS (
         SELECT category.category_id,
            category.parent_id,
            category.site_id,
            category_text.lang_id,
            category_text.title,
            category_text.url_key,
            category.deleted_at,
            category.image_id,
            category.status,
            category.created_by,
            0 AS "?column?",
            to_char(category.sort, 'FM00000000'::text) AS tree_sort
           FROM (public.category
             JOIN public.category_text USING (category_id))
          WHERE ((category.parent_id IS NULL) AND (category.status <> 'draft'::public.publishing_status))
        UNION ALL
         SELECT c2.category_id,
            c2.parent_id,
            c2.site_id,
            ct.lang_id,
            ct.title,
            ct.url_key,
            c2.deleted_at,
            c2.image_id,
            c2.status,
            c2.created_by,
            (vw.level + 1),
            ((vw.tree_sort || '.'::text) || to_char(c2.sort, 'FM00000000'::text))
           FROM ((public.category c2
             JOIN vw_category_option vw ON ((c2.parent_id = vw.category_id)))
             JOIN public.category_text ct ON (((ct.category_id = c2.category_id) AND (ct.lang_id = vw.lang_id))))
          WHERE (c2.status <> 'draft'::public.publishing_status)
        )
 SELECT vw_category_option.category_id,
    vw_category_option.parent_id,
    vw_category_option.site_id,
    vw_category_option.lang_id,
    vw_category_option.title,
    vw_category_option.url_key,
    vw_category_option.deleted_at,
    vw_category_option.image_id,
    vw_category_option.status,
    vw_category_option.created_by,
    vw_category_option.level,
    vw_category_option.tree_sort
   FROM vw_category_option;


--
-- Name: vw_characteristic_grid; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_characteristic_grid AS
 WITH RECURSIVE vw_characteristic_grid(characteristic_id, parent_id, lang_id, group_id, title, joined_title, parent_title, alias, type, system_type, is_folder, is_hidden, default_value, help, level, sort, tree_sort) AS (
         SELECT c.characteristic_id,
            c.parent_id,
            ct.lang_id,
            c.group_id,
            ct.title,
            ct.title AS joined_title,
            NULL::public.citext AS parent_title,
            c.alias,
            c.type,
            c.system_type,
            prop.is_folder,
            prop.is_hidden,
            prop.default_value,
            ct.help,
            0 AS "?column?",
            c.sort,
            to_char(c.sort, 'FM00000000'::text) AS tree_sort
           FROM ((public.characteristic c
             JOIN public.characteristic_text ct USING (characteristic_id))
             JOIN public.characteristic_prop prop USING (characteristic_id))
          WHERE (c.parent_id IS NULL)
        UNION ALL
         SELECT c2.characteristic_id,
            c2.parent_id,
            ct.lang_id,
            c2.group_id,
            ct.title,
            ((((vw_1.joined_title)::text || ' / '::text) || (ct.title)::text))::public.citext AS citext,
            vw_1.title,
            c2.alias,
            c2.type,
            c2.system_type,
            prop.is_folder,
            prop.is_hidden,
            prop.default_value,
            ct.help,
            (vw_1.level + 1),
            c2.sort,
            ((vw_1.tree_sort || '.'::text) || to_char(c2.sort, 'FM00000000'::text))
           FROM (((public.characteristic c2
             JOIN vw_characteristic_grid vw_1 ON ((c2.parent_id = vw_1.characteristic_id)))
             JOIN public.characteristic_text ct ON (((ct.characteristic_id = c2.characteristic_id) AND (ct.lang_id = vw_1.lang_id))))
             JOIN public.characteristic_prop prop ON ((prop.characteristic_id = c2.characteristic_id)))
        )
 SELECT vw.characteristic_id,
    vw.parent_id,
    vw.lang_id,
    vw.group_id,
    vw.title,
    vw.joined_title,
    vw.parent_title,
    vw.alias,
    vw.type,
    vw.system_type,
    vw.is_folder,
    vw.is_hidden,
    vw.default_value,
    vw.help,
    vw.level,
    vw.sort,
    vw.tree_sort
   FROM vw_characteristic_grid vw;


--
-- Name: vw_city; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.vw_city AS
 SELECT city.city_id,
    city.country_id,
    city.region_id,
    city.area_id,
    city.is_important,
    country.code AS country_code,
    city_text.lang_id,
    city_text.title AS city_title,
    country_text.title AS country_title,
    region_text.title AS region_title,
    area_text.title AS area_title
   FROM (((((((public.city
     JOIN public.city_text USING (city_id))
     JOIN public.country USING (country_id))
     JOIN public.country_text ON (((country_text.country_id = country.country_id) AND (country_text.lang_id = city_text.lang_id))))
     LEFT JOIN public.region ON (((region.region_id = city.region_id) AND (region.deleted_at IS NULL))))
     LEFT JOIN public.region_text ON (((region_text.region_id = region.region_id) AND (region_text.lang_id = city_text.lang_id))))
     LEFT JOIN public.area ON (((area.area_id = city.area_id) AND (area.deleted_at IS NULL))))
     LEFT JOIN public.area_text ON (((area_text.area_id = area.area_id) AND (area_text.lang_id = city_text.lang_id))))
  WHERE ((city.deleted_at IS NULL) AND (country.deleted_at IS NULL))
  WITH NO DATA;


--
-- Name: vw_country; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.vw_country AS
 SELECT country.country_id,
    country.code,
    country_text.lang_id,
    country_text.title
   FROM (public.country
     JOIN public.country_text USING (country_id))
  WHERE (country.deleted_at IS NULL)
  WITH NO DATA;


--
-- Name: vw_delivery_city; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.vw_delivery_city AS
 SELECT DISTINCT ON (delivery_site.site_id, vw_city.city_id) delivery_site.site_id,
    vw_city.city_id
   FROM ((((public.delivery
     JOIN public.delivery_site USING (delivery_id))
     JOIN public.shipping USING (shipping_id))
     JOIN public.shipping_city USING (shipping_id))
     JOIN public.vw_city USING (city_id))
  WHERE ((delivery.deleted_at IS NULL) AND (delivery.location_shipping_id IS NULL))
UNION
 SELECT DISTINCT ON (delivery_site.site_id, vw_city.city_id) delivery_site.site_id,
    vw_city.city_id
   FROM ((((public.delivery
     JOIN public.delivery_site USING (delivery_id))
     JOIN public.shipping ON ((shipping.shipping_id = delivery.location_shipping_id)))
     JOIN public.shipping_city ON ((shipping.shipping_id = shipping_city.shipping_id)))
     JOIN public.vw_city USING (city_id))
  WHERE (delivery.deleted_at IS NULL)
UNION
 SELECT DISTINCT ON (delivery_site.site_id, vw_city.city_id) delivery_site.site_id,
    delivery_city.city_id
   FROM (((public.delivery
     JOIN public.delivery_site USING (delivery_id))
     JOIN public.delivery_city USING (delivery_site_id))
     JOIN public.vw_city USING (city_id))
  WHERE (delivery.deleted_at IS NULL)
UNION
 SELECT DISTINCT ON (delivery_site.site_id, vw_city.city_id) delivery_site.site_id,
    vw_city.city_id
   FROM ((((public.delivery
     JOIN public.delivery_site USING (delivery_id))
     JOIN public.delivery_country ON (((delivery_site.delivery_site_id = delivery_country.delivery_site_id) AND (delivery_country.all_city IS TRUE))))
     JOIN public.country USING (country_id))
     JOIN public.vw_city USING (country_id))
  WHERE ((delivery.deleted_at IS NULL) AND (NOT (EXISTS ( SELECT delivery_exclude_city.city_id
           FROM public.delivery_exclude_city
          WHERE ((delivery_exclude_city.delivery_site_id = delivery_site.delivery_site_id) AND (delivery_exclude_city.city_id = vw_city.city_id))))))
  WITH NO DATA;


--
-- Name: vw_delivery_country; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.vw_delivery_country AS
 SELECT delivery_site.site_id,
    delivery_country.country_id
   FROM ((public.delivery_country
     JOIN public.delivery_site USING (delivery_site_id))
     JOIN public.delivery USING (delivery_id))
  WHERE (delivery.deleted_at IS NULL)
UNION
 SELECT delivery_site.site_id,
    shipping_country.country_id
   FROM ((public.delivery
     JOIN public.delivery_site USING (delivery_id))
     JOIN public.shipping_country USING (shipping_id))
  WHERE ((delivery.deleted_at IS NULL) AND (delivery.location_shipping_id IS NULL))
UNION
 SELECT delivery_site.site_id,
    shipping_country.country_id
   FROM ((public.delivery
     JOIN public.delivery_site USING (delivery_id))
     JOIN public.shipping_country ON ((shipping_country.shipping_id = delivery.location_shipping_id)))
  WHERE (delivery.deleted_at IS NULL)
  WITH NO DATA;


--
-- Name: vw_inventory_item; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_inventory_item AS
 SELECT inventory_item.item_id,
        CASE
            WHEN (custom_item.custom_item_id IS NOT NULL) THEN 'custom_item'::text
            WHEN (variant.variant_id IS NOT NULL) THEN 'variant'::text
            ELSE 'product'::text
        END AS type,
        CASE
            WHEN ((track_inv_setting.value IS FALSE) OR (custom_item.custom_item_id IS NOT NULL)) THEN false
            WHEN ((COALESCE(_v_commodity_group.not_track_inventory, commodity_group.not_track_inventory) IS NOT NULL) AND (COALESCE(_v_commodity_group.not_track_inventory, commodity_group.not_track_inventory) IS TRUE)) THEN false
            ELSE true
        END AS track_inventory,
    inventory_item.available_qty,
    inventory_item.reserved_qty,
    COALESCE(_v_product.product_id, product.product_id) AS product_id,
    inventory_item.variant_id,
    inventory_item.custom_item_id,
    COALESCE(_v_product.status, product.status) AS status,
    COALESCE(_v_product.deleted_at, product.deleted_at) AS deleted_at,
    COALESCE(variant_text.lang_id, product_text.lang_id) AS lang_id,
    json_build_object('product_id', COALESCE(_v_product.product_id, product.product_id), 'sku', COALESCE(_v_product.sku, product.sku), 'has_variants', COALESCE(_v_product.has_variants, product.has_variants), 'title', COALESCE(_v_product_text.title, product_text.title), 'url_key', COALESCE(_v_product_text.url_key, product_text.url_key), 'default_category_id', COALESCE(_v_product_category_rel.category_id, product_category_rel.category_id), 'manufacturer_id', COALESCE(_v_product.manufacturer_id, product.manufacturer_id), 'tax_status', COALESCE(_v_product_prop.tax_status, product_prop.tax_status), 'tax_class_id', COALESCE(_v_product_prop.tax_class_id, product_prop.tax_class_id)) AS product,
    json_build_object('variant_id', inventory_item.variant_id, 'sku', variant.sku, 'title', variant_text.title, 'cases', variant.cases, 'size', variant.size) AS variant,
    json_build_object('custom_item_id', custom_item.custom_item_id, 'title', custom_item.title, 'price', custom_item.price) AS custom_item,
    json_build_object('group_id', COALESCE(_v_product.group_id, product.group_id), 'type', COALESCE(_v_commodity_group.type, commodity_group.type), 'not_track_inventory', COALESCE(_v_commodity_group.not_track_inventory, commodity_group.not_track_inventory), 'vat', COALESCE(_v_commodity_group.vat, commodity_group.vat), 'physical_products', COALESCE(_v_commodity_group.physical_products, commodity_group.physical_products), 'title', COALESCE(_v_commodity_group_text.title, commodity_group_text.title)) AS commodity_group,
    json_build_object('path', COALESCE(_v_image.path, image.path), 'width', COALESCE(_v_image.width, image.width), 'height', COALESCE(_v_image.height, image.height)) AS image,
    compiled_prices.prices
   FROM ((((((((((((((((((((public.inventory_item
     LEFT JOIN public.product ON ((product.product_id = inventory_item.product_id)))
     LEFT JOIN public.product_text ON ((product_text.product_id = product.product_id)))
     LEFT JOIN public.product_prop ON ((product_prop.product_id = product.product_id)))
     LEFT JOIN public.commodity_group ON ((commodity_group.group_id = product.group_id)))
     LEFT JOIN public.commodity_group_text ON (((commodity_group_text.group_id = commodity_group.group_id) AND (commodity_group_text.lang_id = product_text.lang_id))))
     LEFT JOIN public.product_image ON (((product_image.product_id = product.product_id) AND (product_image.is_default IS TRUE))))
     LEFT JOIN public.image ON ((image.image_id = product_image.image_id)))
     LEFT JOIN public.product_category_rel ON (((product_category_rel.product_id = product.product_id) AND (product_category_rel.is_default IS TRUE))))
     LEFT JOIN public.variant ON ((variant.variant_id = inventory_item.variant_id)))
     LEFT JOIN public.variant_text ON ((variant.variant_id = variant_text.variant_id)))
     LEFT JOIN public.product _v_product ON ((_v_product.product_id = variant.product_id)))
     LEFT JOIN public.product_text _v_product_text ON (((_v_product_text.product_id = _v_product.product_id) AND (_v_product_text.lang_id = variant_text.lang_id))))
     LEFT JOIN public.product_prop _v_product_prop ON ((_v_product_prop.product_id = _v_product.product_id)))
     LEFT JOIN public.commodity_group _v_commodity_group ON ((_v_commodity_group.group_id = _v_product.group_id)))
     LEFT JOIN public.commodity_group_text _v_commodity_group_text ON (((_v_commodity_group_text.group_id = _v_commodity_group.group_id) AND (_v_commodity_group_text.lang_id = variant_text.lang_id))))
     LEFT JOIN public.product_image _v_product_image ON (((_v_product_image.product_id = _v_product.product_id) AND (_v_product_image.is_default IS TRUE))))
     LEFT JOIN public.image _v_image ON ((_v_image.image_id = _v_product_image.image_id)))
     LEFT JOIN public.product_category_rel _v_product_category_rel ON (((_v_product_category_rel.product_id = _v_product.product_id) AND (_v_product_category_rel.is_default IS TRUE))))
     LEFT JOIN ( SELECT final_price.item_id,
            json_build_object('point_id', json_agg(final_price.point_id), 'price_id', json_agg(final_price.price_id), 'alias', json_agg(price.alias), 'currency_id', json_agg(final_price.currency_id), 'currency_alias', json_agg(currency.alias), 'value', json_agg(final_price.value), 'min', json_agg(final_price.min), 'max', json_agg(final_price.max), 'is_auto_generated', json_agg(final_price.is_auto_generated), 'old', json_agg(final_price.old), 'old_min', json_agg(final_price.old_min), 'old_max', json_agg(final_price.old_max)) AS prices
           FROM ((public.final_price
             JOIN public.price USING (price_id))
             JOIN public.currency USING (currency_id))
          GROUP BY final_price.item_id) compiled_prices ON ((inventory_item.item_id = compiled_prices.item_id)))
     LEFT JOIN public.custom_item ON ((custom_item.custom_item_id = inventory_item.custom_item_id))),
    ( SELECT ((setting.value)::text)::boolean AS value
           FROM public.setting
          WHERE ((setting.setting_group = 'inventory'::public.setting_group) AND (setting.key OPERATOR(public.=) 'trackInventory'::public.citext))) track_inv_setting
  WHERE ((variant.variant_id IS NOT NULL) OR (product.has_variants IS FALSE) OR (custom_item.custom_item_id IS NOT NULL));


--
-- Name: vw_item_group; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_item_group AS
 SELECT inventory_item.item_id,
    COALESCE(_v_product.group_id, product.group_id) AS group_id,
    COALESCE(_v_commodity_group.type, commodity_group.type) AS type,
    COALESCE(_v_commodity_group.not_track_inventory, commodity_group.not_track_inventory) AS not_track_inventory,
    COALESCE(_v_commodity_group.vat, commodity_group.vat) AS vat,
    COALESCE(_v_commodity_group.physical_products, commodity_group.physical_products) AS physical_products
   FROM (((((public.inventory_item
     LEFT JOIN public.product ON ((product.product_id = inventory_item.product_id)))
     LEFT JOIN public.commodity_group ON ((commodity_group.group_id = product.group_id)))
     LEFT JOIN public.variant ON ((variant.variant_id = inventory_item.variant_id)))
     LEFT JOIN public.product _v_product ON ((_v_product.product_id = variant.product_id)))
     LEFT JOIN public.commodity_group _v_commodity_group ON ((_v_commodity_group.group_id = _v_product.group_id)));


--
-- Name: vw_menu_item_tree; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_menu_item_tree AS
 WITH RECURSIVE vw_menu_item_tree(item_id, block_id, lang_id, parent_id, type, title, url, highlight, css_class, created_at, category_id, page_id, page_url_key, product_id, level, tree_sort) AS (
         SELECT menu_item.item_id,
            menu_item.block_id,
            menu_item.lang_id,
            menu_item.parent_id,
            menu_item.type,
            menu_item.title,
            menu_item.url,
            menu_item.highlight,
            menu_item.css_class,
            menu_item.created_at,
            menu_item_rel.category_id,
            menu_item_rel.page_id,
                CASE
                    WHEN (menu_item.type = 'product'::public.menu_item_type) THEN pt.url_key
                    WHEN (menu_item.type = 'category'::public.menu_item_type) THEN ct.url_key
                    ELSE p.url_key
                END AS page_url_key,
            menu_item_rel.product_id,
            0 AS "?column?",
            to_char(menu_item.sort, 'FM00000000'::text) AS tree_sort
           FROM ((((public.menu_item
             JOIN public.menu_item_rel USING (item_id))
             LEFT JOIN public.page p ON ((p.page_id = menu_item_rel.page_id)))
             LEFT JOIN public.product_text pt ON (((menu_item_rel.product_id = pt.product_id) AND (menu_item.lang_id = pt.lang_id))))
             LEFT JOIN public.category_text ct ON (((menu_item_rel.category_id = ct.category_id) AND (menu_item.lang_id = ct.lang_id))))
          WHERE (menu_item.parent_id IS NULL)
        UNION ALL
         SELECT i.item_id,
            i.block_id,
            i.lang_id,
            i.parent_id,
            i.type,
            i.title,
            i.url,
            i.highlight,
            i.css_class,
            i.created_at,
            r.category_id,
            r.page_id,
                CASE
                    WHEN (i.type = 'product'::public.menu_item_type) THEN pt.url_key
                    WHEN (i.type = 'category'::public.menu_item_type) THEN ct.url_key
                    ELSE p.url_key
                END AS page_url_key,
            r.product_id,
            (vw.level + 1),
            ((vw.tree_sort || '.'::text) || to_char(i.sort, 'FM00000000'::text))
           FROM (((((public.menu_item i
             JOIN public.menu_item_rel r USING (item_id))
             LEFT JOIN public.page p ON ((p.page_id = r.page_id)))
             LEFT JOIN public.product_text pt ON (((r.product_id = pt.product_id) AND (i.lang_id = pt.lang_id))))
             LEFT JOIN public.category_text ct ON (((r.category_id = ct.category_id) AND (i.lang_id = ct.lang_id))))
             JOIN vw_menu_item_tree vw ON ((i.parent_id = vw.item_id)))
        )
 SELECT vw_menu_item_tree.item_id,
    vw_menu_item_tree.block_id,
    vw_menu_item_tree.lang_id,
    vw_menu_item_tree.parent_id,
    vw_menu_item_tree.type,
    vw_menu_item_tree.title,
    vw_menu_item_tree.url,
    vw_menu_item_tree.highlight,
    vw_menu_item_tree.css_class,
    vw_menu_item_tree.created_at,
    vw_menu_item_tree.category_id,
    vw_menu_item_tree.page_id,
    vw_menu_item_tree.page_url_key,
    vw_menu_item_tree.product_id,
    vw_menu_item_tree.level,
    vw_menu_item_tree.tree_sort
   FROM vw_menu_item_tree;


--
-- Name: vw_my_theme; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_my_theme AS
 SELECT theme.theme_id,
    theme_installed.installed_id,
    theme_installed.alias,
    theme_installed.created_at AS installed_at,
    theme_installed.is_using,
    theme_installed.screen_path,
    theme_installed.screen_width,
    theme_installed.screen_height,
    theme.preview,
    theme_installed_text.lang_id,
    COALESCE(theme_installed_text.title, theme_text.title) AS title,
    theme_text.description,
    NULL::integer AS sort
   FROM (((public.theme_installed
     JOIN public.theme_installed_text USING (installed_id))
     LEFT JOIN public.theme USING (theme_id))
     LEFT JOIN public.theme_text ON (((theme.theme_id = theme_text.theme_id) AND (theme_text.lang_id = theme_installed_text.lang_id))))
UNION
 SELECT theme.theme_id,
    NULL::integer AS installed_id,
    theme.alias,
    NULL::timestamp with time zone AS installed_at,
    false AS is_using,
    NULL::character varying AS screen_path,
    NULL::integer AS screen_width,
    NULL::integer AS screen_height,
    theme.preview,
    theme_text.lang_id,
    theme_text.title,
    theme_text.description,
    theme.sort
   FROM (public.theme
     JOIN public.theme_text USING (theme_id))
  WHERE ((theme.deleted_at IS NULL) AND (NOT (EXISTS ( SELECT theme_installed.theme_id
           FROM public.theme_installed
          WHERE (theme_installed.theme_id = theme.theme_id)))))
  ORDER BY 5 DESC, 4 DESC NULLS LAST, 13;


--
-- Name: vw_order_status_flat_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_order_status_flat_list AS
 WITH RECURSIVE vw_order_status_flat_list(status_id, lang_id, parent_id, title, alias, background_color, stock_location, level, tree_sort) AS (
         SELECT s.status_id,
            st.lang_id,
            s.parent_id,
            st.title,
            s.alias,
            s.background_color,
            s.stock_location,
            0 AS "?column?",
            to_char(s.sort, 'FM00000000'::text) AS tree_sort
           FROM (public.order_status s
             JOIN public.order_status_text st USING (status_id))
          WHERE ((s.parent_id IS NULL) AND (s.deleted_at IS NULL))
        UNION ALL
         SELECT s2.status_id,
            st2.lang_id,
            s2.parent_id,
            st2.title,
            s2.alias,
            s2.background_color,
            s2.stock_location,
            (vw.level + 1),
            ((vw.tree_sort || '.'::text) || to_char(s2.sort, 'FM00000000'::text))
           FROM ((public.order_status s2
             JOIN vw_order_status_flat_list vw ON ((s2.parent_id = vw.status_id)))
             JOIN public.order_status_text st2 ON (((st2.status_id = s2.status_id) AND (vw.lang_id = st2.lang_id))))
          WHERE (s2.deleted_at IS NULL)
        )
 SELECT vw_order_status_flat_list.status_id,
    vw_order_status_flat_list.lang_id,
    vw_order_status_flat_list.parent_id,
    vw_order_status_flat_list.title,
    vw_order_status_flat_list.alias,
    vw_order_status_flat_list.background_color,
    vw_order_status_flat_list.stock_location,
    vw_order_status_flat_list.level,
    vw_order_status_flat_list.tree_sort
   FROM vw_order_status_flat_list;


--
-- Name: vw_page_flat_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_page_flat_list AS
 WITH RECURSIVE vw_page_flat_list(page_id, site_id, lang_id, type, level, tree_sort, joined_title) AS (
         SELECT page.page_id,
            page.site_id,
            page.lang_id,
            page.type,
            0 AS "?column?",
            to_char(page.sort, 'FM00000000'::text) AS tree_sort,
            page.title AS joined_title
           FROM public.page
          WHERE ((page.parent_id IS NULL) AND (page.deleted_at IS NULL))
        UNION ALL
         SELECT page.page_id,
            page.site_id,
            page.lang_id,
            page.type,
            (parent.level + 1),
            ((parent.tree_sort || '.'::text) || to_char(page.sort, 'FM00000000'::text)) AS tree_sort,
            ((((parent.joined_title)::text || '/'::text) || (page.title)::text))::public.citext AS joined_title
           FROM (public.page
             JOIN vw_page_flat_list parent ON ((parent.page_id = page.parent_id)))
          WHERE (page.deleted_at IS NULL)
        )
 SELECT vw_page_flat_list.page_id,
    vw_page_flat_list.site_id,
    vw_page_flat_list.lang_id,
    vw_page_flat_list.type,
    vw_page_flat_list.level,
    vw_page_flat_list.tree_sort,
    vw_page_flat_list.joined_title
   FROM vw_page_flat_list;


--
-- Name: vw_page_option; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_page_option AS
 WITH RECURSIVE vw_page_option(page_id, site_id, lang_id, parent_id, type, title, system_alias, url_key, typearea_id, deleted_at, level, tree_sort) AS (
         SELECT page.page_id,
            page.site_id,
            page.lang_id,
            page.parent_id,
            page.type,
            page.title,
            page.system_alias,
            page.url_key,
            page.typearea_id,
            page.deleted_at,
            0 AS "?column?",
            to_char(page.sort, 'FM00000000'::text) AS tree_sort
           FROM public.page
          WHERE (page.parent_id IS NULL)
        UNION ALL
         SELECT p2.page_id,
            p2.site_id,
            p2.lang_id,
            p2.parent_id,
            p2.type,
            p2.title,
            p2.system_alias,
            p2.url_key,
            p2.typearea_id,
            p2.deleted_at,
            (vw.level + 1),
            ((vw.tree_sort || '.'::text) || to_char(p2.sort, 'FM00000000'::text))
           FROM (public.page p2
             JOIN vw_page_option vw ON ((p2.parent_id = vw.page_id)))
        )
 SELECT vw_page_option.page_id,
    vw_page_option.site_id,
    vw_page_option.lang_id,
    vw_page_option.parent_id,
    vw_page_option.type,
    vw_page_option.title,
    vw_page_option.system_alias,
    vw_page_option.url_key,
    vw_page_option.typearea_id,
    vw_page_option.deleted_at,
    vw_page_option.level,
    vw_page_option.tree_sort
   FROM vw_page_option;


--
-- Name: vw_product_info; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_product_info AS
 SELECT p.product_id,
    p.sku,
    p.manufacturer_id,
    manufacturer_text.title AS manufacturer_title,
    manufacturer_text.url_key AS manufacturer_url_key,
    manufacturer.image_id AS manufacturer_image_id,
    json_build_object('path', manufacturer_img.path, 'width', manufacturer_img.width, 'height', manufacturer_img.height) AS manufacturer_img,
    p.group_id,
    p.has_variants,
    p.status,
    p.created_at,
    p.deleted_at,
    pt.lang_id,
    pt.title,
    pt.custom_title,
    pt.custom_header,
    pt.meta_description,
    pt.meta_keywords,
    pt.url_key,
    pt.description,
    pp.available_qty,
    pp.reserved_qty,
    pp.extra,
    pp.size,
    pp.characteristic,
    pp.country_of_origin,
    vw_country.title AS country_of_origin_title,
    i.item_id,
    img.path AS img_path,
    img.width AS img_width,
    img.height AS img_height,
    fp.point_id AS price_point_id,
    fp.price_id,
    fp.value AS price,
    fp.min AS price_min,
    fp.max AS price_max,
    fp.old AS price_old,
    fp.old_min AS price_old_min,
    fp.old_max AS price_old_max,
    price.alias AS price_alias,
    pg.not_track_inventory AS product_not_track_inventory,
    pcr.category_id AS default_category_id,
    category_text.title AS default_category_title
   FROM ((((((((((((((public.product p
     JOIN public.product_text pt USING (product_id))
     JOIN public.product_prop pp USING (product_id))
     JOIN public.inventory_item i USING (product_id))
     LEFT JOIN public.final_price fp ON ((fp.item_id = i.item_id)))
     LEFT JOIN public.price ON ((price.price_id = fp.price_id)))
     LEFT JOIN public.commodity_group pg ON ((pg.group_id = p.group_id)))
     LEFT JOIN public.product_image pi ON (((pi.product_id = p.product_id) AND (pi.is_default IS TRUE))))
     LEFT JOIN public.image img ON ((img.image_id = pi.image_id)))
     LEFT JOIN public.manufacturer ON ((manufacturer.manufacturer_id = p.manufacturer_id)))
     LEFT JOIN public.image manufacturer_img ON ((manufacturer.image_id = manufacturer_img.image_id)))
     LEFT JOIN public.manufacturer_text ON (((manufacturer.manufacturer_id = manufacturer_text.manufacturer_id) AND (manufacturer_text.lang_id = pt.lang_id))))
     LEFT JOIN public.product_category_rel pcr ON (((p.product_id = pcr.product_id) AND (pcr.is_default = true))))
     LEFT JOIN public.category_text ON (((pcr.category_id = category_text.category_id) AND (category_text.lang_id = pt.lang_id))))
     LEFT JOIN public.vw_country ON (((pp.country_of_origin = vw_country.country_id) AND (vw_country.lang_id = pt.lang_id))));


--
-- Name: vw_product_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_product_list AS
 SELECT product.product_id,
    product.sku,
    pt.title,
    pt.url_key,
    product.has_variants,
    product.external_id,
    inventory_item.item_id,
    manufacturer.manufacturer_id,
    json_build_object('description', pt.description, 'custom_title', pt.custom_title, 'meta_description', pt.meta_description) AS text,
    json_build_object('available_qty', product_prop.available_qty, 'reserved_qty', product_prop.reserved_qty, 'country_of_origin', product_prop.country_of_origin, 'extra', product_prop.extra, 'size', product_prop.size, 'attr_values', product_prop.characteristic, 'tax_status', product_prop.tax_status, 'tax_class_id', product_prop.tax_class_id, 'arbitrary_data', product_prop.arbitrary_data) AS props,
    json_build_object('manufacturer_id', manufacturer.manufacturer_id, 'title', manufacturer_text.title, 'url_key', manufacturer_text.url_key, 'image', manufacturer_image.path) AS manufacturer,
    json_build_object('category_id', def_category.category_id, 'title', def_category_text.title, 'url_key', def_category_text.url_key) AS default_category,
    compiled_images.images,
    json_build_object('group_id', commodity_group.group_id, 'title', commodity_group_text.title, 'is_default', commodity_group.is_default, 'physical_products', commodity_group.physical_products, 'track_inventory',
        CASE
            WHEN (commodity_group.not_track_inventory IS TRUE) THEN false
            ELSE true
        END) AS product_type,
    compiled_labels.labels,
    product.status,
    product.deleted_at,
    item_sort_price.sort_price,
        CASE
            WHEN (product_prop.available_qty > 0) THEN 1
            ELSE 0
        END AS sort_in_stock
   FROM (((((((((((((((public.product
     JOIN public.product_text pt ON ((product.product_id = pt.product_id)))
     JOIN public.lang ON ((pt.lang_id = lang.lang_id)))
     JOIN public.inventory_item ON ((inventory_item.product_id = product.product_id)))
     JOIN public.product_prop ON ((product.product_id = product_prop.product_id)))
     LEFT JOIN public.commodity_group ON ((commodity_group.group_id = product.group_id)))
     LEFT JOIN public.commodity_group_text ON (((commodity_group_text.group_id = commodity_group.group_id) AND (commodity_group_text.lang_id = lang.lang_id))))
     LEFT JOIN public.manufacturer ON (((manufacturer.manufacturer_id = product.manufacturer_id) AND (manufacturer.deleted_at IS NULL))))
     LEFT JOIN public.manufacturer_text ON (((manufacturer_text.manufacturer_id = manufacturer.manufacturer_id) AND (manufacturer_text.lang_id = lang.lang_id))))
     LEFT JOIN public.image manufacturer_image ON (((manufacturer_image.image_id = manufacturer.image_id) AND (manufacturer_image.deleted_at IS NULL))))
     LEFT JOIN public.product_category_rel def_cat_rel ON (((def_cat_rel.product_id = product.product_id) AND (def_cat_rel.is_default IS TRUE))))
     LEFT JOIN public.category def_category ON (((def_category.category_id = def_cat_rel.category_id) AND (def_category.deleted_at IS NULL) AND (def_category.status = 'published'::public.publishing_status))))
     LEFT JOIN public.category_text def_category_text ON (((def_category.category_id = def_category_text.category_id) AND (def_category_text.lang_id = lang.lang_id))))
     LEFT JOIN ( SELECT product_image.product_id,
            product_image_text.lang_id,
            json_build_object('image_id', json_agg(image.image_id ORDER BY product_image.sort), 'path', json_agg(image.path), 'width', json_agg(image.width), 'height', json_agg(image.height), 'is_default', json_agg(product_image.is_default), 'description', json_agg(product_image_text.description), 'alt', json_agg(product_image_text.alt), 'tags', json_agg(img_tags.tags)) AS images
           FROM (((public.product_image
             JOIN public.product_image_text USING (product_image_id))
             JOIN public.image USING (image_id))
             LEFT JOIN ( SELECT image_tag_rel.product_image_id,
                    json_agg(image_tag.title) AS tags
                   FROM (public.image_tag_rel
                     JOIN public.image_tag USING (image_tag_id))
                  GROUP BY image_tag_rel.product_image_id) img_tags USING (product_image_id))
          GROUP BY product_image.product_id, product_image_text.lang_id) compiled_images ON (((compiled_images.product_id = product.product_id) AND (compiled_images.lang_id = lang.lang_id))))
     LEFT JOIN ( SELECT product_label_rel.product_id,
            label_text.lang_id,
            json_build_object('label_id', json_agg(product_label_rel.label_id), 'title', json_agg(label_text.title), 'color', json_agg(label.color), 'text_color', json_agg(label.text_color), 'icon', json_agg(label.icon)) AS labels
           FROM ((public.product_label_rel
             JOIN public.label USING (label_id))
             JOIN public.label_text USING (label_id))
          GROUP BY product_label_rel.product_id, label_text.lang_id) compiled_labels ON (((compiled_labels.product_id = product.product_id) AND (compiled_labels.lang_id = lang.lang_id))))
     LEFT JOIN ( SELECT final_price.item_id,
            COALESCE(final_price.min, final_price.value) AS sort_price
           FROM (public.final_price
             JOIN public.price USING (price_id))
          WHERE ((final_price.point_id = 1) AND (price.alias OPERATOR(public.=) 'selling_price'::public.citext))) item_sort_price ON ((item_sort_price.item_id = inventory_item.item_id)))
  WHERE (lang.lang_id = 1);


--
-- Name: vw_region; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.vw_region AS
 SELECT region.region_id,
    region.country_id,
    region.vk_id,
    region_text.lang_id,
    region_text.title AS region_title,
    country.code AS country_code,
    country_text.title AS country_title
   FROM (((public.region
     JOIN public.region_text ON ((region_text.region_id = region.region_id)))
     JOIN public.country ON ((region.country_id = country.country_id)))
     JOIN public.country_text ON (((country_text.country_id = country.country_id) AND (region_text.lang_id = country_text.lang_id))))
  WHERE ((region.deleted_at IS NULL) AND (country.deleted_at IS NULL))
  WITH NO DATA;


--
-- Name: vw_search_category; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_search_category AS
 SELECT ((category.category_id * 10) + 2) AS id,
    'category'::text AS type,
    category.category_id AS local_id,
    category.site_id,
    lang.lang_id,
    lang.code AS lang_code,
    category_text.title,
    category_text.custom_title AS seo_title,
    category_text.custom_header AS seo_header,
    category_text.meta_description,
    category_text.meta_keywords,
    concat(category_text.description_top, ' ', category_text.description_bottom) AS text
   FROM ((public.category
     JOIN public.category_text USING (category_id))
     JOIN public.lang USING (lang_id))
  WHERE ((category.status = 'published'::public.publishing_status) AND (category.deleted_at IS NULL));


--
-- Name: vw_search_page; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_search_page AS
SELECT
    NULL::integer AS id,
    NULL::text AS type,
    NULL::integer AS local_id,
    NULL::integer AS site_id,
    NULL::integer AS lang_id,
    NULL::character varying(2) AS lang_code,
    NULL::public.citext AS title,
    NULL::text AS seo_title,
    NULL::text AS seo_header,
    NULL::text AS meta_description,
    NULL::text AS meta_keywords,
    NULL::text AS text;


--
-- Name: vw_search_product; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_search_product AS
 SELECT ((product.product_id * 10) + 1) AS id,
    'product'::text AS type,
    product.product_id AS local_id,
    lang.lang_id,
    lang.code AS lang_code,
    (product.sku)::text AS sku,
    product_text.title,
    (manufacturer_text.title)::text AS manufacturer_title,
    product_text.custom_title AS seo_title,
    product_text.custom_header AS seo_header,
    product_text.meta_description,
    product_text.meta_keywords,
    gt.title AS group_title,
    grouped_variants.variant_search,
    grouped_cats.title AS cats_title,
    grouped_cats.site_id,
    product_text.description AS text
   FROM ((((((((public.product
     JOIN public.product_text ON ((product.product_id = product_text.product_id)))
     JOIN public.lang ON ((product_text.lang_id = lang.lang_id)))
     LEFT JOIN public.commodity_group g ON (((g.group_id = product.group_id) AND (g.deleted_at IS NULL))))
     LEFT JOIN public.commodity_group_text gt ON (((gt.group_id = g.group_id) AND (gt.lang_id = lang.lang_id))))
     LEFT JOIN public.manufacturer ON (((manufacturer.manufacturer_id = product.manufacturer_id) AND (manufacturer.deleted_at IS NULL))))
     LEFT JOIN public.manufacturer_text ON (((manufacturer_text.manufacturer_id = manufacturer.manufacturer_id) AND (manufacturer_text.lang_id = lang.lang_id))))
     LEFT JOIN ( SELECT product_1.product_id,
            variant_text.lang_id,
            string_agg(concat(variant.sku, ' ', variant_text.title), ', '::text) AS variant_search
           FROM ((public.product product_1
             JOIN public.variant USING (product_id))
             JOIN public.variant_text USING (variant_id))
          WHERE ((product_1.deleted_at IS NULL) AND (variant.deleted_at IS NULL))
          GROUP BY product_1.product_id, variant_text.lang_id) grouped_variants ON (((grouped_variants.product_id = product.product_id) AND (grouped_variants.lang_id = lang.lang_id))))
     LEFT JOIN ( SELECT product_category_rel.product_id,
            vw_category_flat_list.site_id,
            category_text.lang_id,
            string_agg((category_text.title)::text, ', '::text) AS title
           FROM (((public.product_category_rel
             JOIN public.product product_1 USING (product_id))
             JOIN public.vw_category_flat_list USING (category_id))
             JOIN public.category_text ON (((category_text.category_id = vw_category_flat_list.category_id) AND (vw_category_flat_list.lang_id = category_text.lang_id))))
          WHERE (product_1.deleted_at IS NULL)
          GROUP BY product_category_rel.product_id, vw_category_flat_list.site_id, category_text.lang_id) grouped_cats ON (((grouped_cats.product_id = product.product_id) AND (grouped_cats.lang_id = lang.lang_id))))
  WHERE (product.deleted_at IS NULL)
  ORDER BY product.product_id;


--
-- Name: vw_shipping; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.vw_shipping AS
 SELECT shipping.shipping_id,
    shipping.alias,
    shipping.settings,
    shipping_text.title AS shipping_title,
    shipping_text.lang_id
   FROM (public.shipping
     JOIN public.shipping_text USING (shipping_id))
  WITH NO DATA;


--
-- Name: vw_shipping_city; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.vw_shipping_city AS
 SELECT shipping_city.shipping_id,
    shipping_city.city_id,
    shipping_city.type,
    shipping_city.local_id
   FROM public.shipping_city
  WITH NO DATA;


--
-- Name: zip; Type: FOREIGN TABLE; Schema: public; Owner: -
--

CREATE FOREIGN TABLE public.zip (
    zip_id integer NOT NULL,
    country_id integer NOT NULL,
    city_id integer NOT NULL,
    zip character varying(30) NOT NULL
)
SERVER delivery_server
OPTIONS (
    schema_name 'public',
    table_name 'zip'
);
ALTER FOREIGN TABLE public.zip ALTER COLUMN zip_id OPTIONS (
    column_name 'zip_id'
);
ALTER FOREIGN TABLE public.zip ALTER COLUMN country_id OPTIONS (
    column_name 'country_id'
);
ALTER FOREIGN TABLE public.zip ALTER COLUMN city_id OPTIONS (
    column_name 'city_id'
);
ALTER FOREIGN TABLE public.zip ALTER COLUMN zip OPTIONS (
    column_name 'zip'
);


--
-- Name: vw_shipping_zip; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.vw_shipping_zip AS
 SELECT shipping_zip.zip_id,
    shipping_zip.shipping_id,
    shipping_zip.courier,
    zip.country_id,
    zip.city_id,
    zip.zip
   FROM (public.shipping_zip
     JOIN public.zip USING (zip_id))
  WITH NO DATA;


--
-- Name: vw_track_inventory; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_track_inventory AS
 SELECT inventory_item.item_id,
        CASE
            WHEN ((track_inv_setting.value IS FALSE) OR (custom_item.custom_item_id IS NOT NULL)) THEN false
            WHEN ((COALESCE(_v_commodity_group.not_track_inventory, commodity_group.not_track_inventory) IS NOT NULL) AND (COALESCE(_v_commodity_group.not_track_inventory, commodity_group.not_track_inventory) IS TRUE)) THEN false
            ELSE true
        END AS track_inventory
   FROM ((((((public.inventory_item
     LEFT JOIN public.product ON ((product.product_id = inventory_item.product_id)))
     LEFT JOIN public.commodity_group ON ((commodity_group.group_id = product.group_id)))
     LEFT JOIN public.variant ON ((variant.variant_id = inventory_item.variant_id)))
     LEFT JOIN public.product _v_product ON ((_v_product.product_id = variant.product_id)))
     LEFT JOIN public.commodity_group _v_commodity_group ON ((_v_commodity_group.group_id = _v_product.group_id)))
     LEFT JOIN public.custom_item ON ((custom_item.custom_item_id = inventory_item.custom_item_id))),
    ( SELECT ((setting.value)::text)::boolean AS value
           FROM public.setting
          WHERE ((setting.setting_group = 'inventory'::public.setting_group) AND (setting.key OPERATOR(public.=) 'trackinventory'::public.citext))) track_inv_setting;


--
-- Name: warehouse; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.warehouse (
    warehouse_id integer NOT NULL,
    sort integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: warehouse_text; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.warehouse_text (
    warehouse_id integer NOT NULL,
    lang_id integer NOT NULL,
    title public.citext,
    address public.citext
);


--
-- Name: warehouse_warehouse_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.warehouse_warehouse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: warehouse_warehouse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.warehouse_warehouse_id_seq OWNED BY public.warehouse.warehouse_id;


--
-- Name: webhook; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhook (
    webhook_id integer NOT NULL,
    url character varying(255) NOT NULL,
    name character varying(100) NOT NULL,
    secret character varying(100)
);


--
-- Name: webhook_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhook_log (
    webhook_log_id integer NOT NULL,
    webhook_id integer NOT NULL,
    status_code integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: webhook_log_webhook_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.webhook_log_webhook_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webhook_log_webhook_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.webhook_log_webhook_log_id_seq OWNED BY public.webhook_log.webhook_log_id;


--
-- Name: webhook_webhook_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.webhook_webhook_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webhook_webhook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.webhook_webhook_id_seq OWNED BY public.webhook.webhook_id;


--
-- Name: admin_comment comment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_comment ALTER COLUMN comment_id SET DEFAULT nextval('public.admin_comment_comment_id_seq'::regclass);


--
-- Name: api_file_uploader id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_file_uploader ALTER COLUMN id SET DEFAULT nextval('public.api_file_uploader_id_seq'::regclass);


--
-- Name: api_token token_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_token ALTER COLUMN token_id SET DEFAULT nextval('public.api_token_token_id_seq'::regclass);


--
-- Name: article article_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.article ALTER COLUMN article_id SET DEFAULT nextval('public.article_article_id_seq'::regclass);


--
-- Name: auth_resource resource_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_resource ALTER COLUMN resource_id SET DEFAULT nextval('public.auth_resource_resource_id_seq'::regclass);


--
-- Name: auth_rule rule_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_rule ALTER COLUMN rule_id SET DEFAULT nextval('public.auth_rule_rule_id_seq'::regclass);


--
-- Name: auth_task task_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_task ALTER COLUMN task_id SET DEFAULT nextval('public.auth_task_task_id_seq'::regclass);


--
-- Name: basket basket_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket ALTER COLUMN basket_id SET DEFAULT nextval('public.basket_basket_id_seq'::regclass);


--
-- Name: basket_item basket_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_item ALTER COLUMN basket_item_id SET DEFAULT nextval('public.basket_item_basket_item_id_seq'::regclass);


--
-- Name: box box_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.box ALTER COLUMN box_id SET DEFAULT nextval('public.box_box_id_seq'::regclass);


--
-- Name: category category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: characteristic characteristic_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic ALTER COLUMN characteristic_id SET DEFAULT nextval('public.characteristic_characteristic_id_seq'::regclass);


--
-- Name: characteristic_product_val value_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_product_val ALTER COLUMN value_id SET DEFAULT nextval('public.characteristic_product_val_value_id_seq'::regclass);


--
-- Name: characteristic_type_case case_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_type_case ALTER COLUMN case_id SET DEFAULT nextval('public.characteristic_type_case_case_id_seq'::regclass);


--
-- Name: characteristic_variant_val value_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_variant_val ALTER COLUMN value_id SET DEFAULT nextval('public.characteristic_variant_val_value_id_seq'::regclass);


--
-- Name: collection collection_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection ALTER COLUMN collection_id SET DEFAULT nextval('public.collection_collection_id_seq'::regclass);


--
-- Name: collection_product_rel rel_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_product_rel ALTER COLUMN rel_id SET DEFAULT nextval('public.collection_product_rel_rel_id_seq'::regclass);


--
-- Name: commodity_group group_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commodity_group ALTER COLUMN group_id SET DEFAULT nextval('public.commodity_group_group_id_seq'::regclass);


--
-- Name: consumed_space space_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consumed_space ALTER COLUMN space_id SET DEFAULT nextval('public.consumed_space_space_id_seq'::regclass);


--
-- Name: coupon_campaign campaign_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_campaign ALTER COLUMN campaign_id SET DEFAULT nextval('public.coupon_campaign_campaign_id_seq'::regclass);


--
-- Name: coupon_code code_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_code ALTER COLUMN code_id SET DEFAULT nextval('public.coupon_code_code_id_seq'::regclass);


--
-- Name: cross_sell cross_sell_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell ALTER COLUMN cross_sell_id SET DEFAULT nextval('public.cross_sell_cross_sell_id_seq'::regclass);


--
-- Name: cross_sell_category category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell_category ALTER COLUMN category_id SET DEFAULT nextval('public.cross_sell_category_category_id_seq'::regclass);


--
-- Name: currency currency_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency ALTER COLUMN currency_id SET DEFAULT nextval('public.currency_currency_id_seq'::regclass);


--
-- Name: custom_item custom_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_item ALTER COLUMN custom_item_id SET DEFAULT nextval('public.custom_item_custom_item_id_seq'::regclass);


--
-- Name: customer_group group_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group ALTER COLUMN group_id SET DEFAULT nextval('public.customer_group_group_id_seq'::regclass);


--
-- Name: delivery delivery_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery ALTER COLUMN delivery_id SET DEFAULT nextval('public.delivery_delivery_id_seq'::regclass);


--
-- Name: delivery_city delivery_city_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_city ALTER COLUMN delivery_city_id SET DEFAULT nextval('public.delivery_city_delivery_city_id_seq'::regclass);


--
-- Name: delivery_country delivery_country_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_country ALTER COLUMN delivery_country_id SET DEFAULT nextval('public.delivery_country_delivery_country_id_seq'::regclass);


--
-- Name: delivery_site delivery_site_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_site ALTER COLUMN delivery_site_id SET DEFAULT nextval('public.site_delivery_site_delivery_id_seq'::regclass);


--
-- Name: essence essence_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.essence ALTER COLUMN essence_id SET DEFAULT nextval('public.essence_essence_id_seq'::regclass);


--
-- Name: feeds feed_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feeds ALTER COLUMN feed_id SET DEFAULT nextval('public.feeds_feed_id_seq'::regclass);


--
-- Name: filter filter_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filter ALTER COLUMN filter_id SET DEFAULT nextval('public.filter_filter_id_seq'::regclass);


--
-- Name: filter_field field_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filter_field ALTER COLUMN field_id SET DEFAULT nextval('public.filter_field_field_id_seq'::regclass);


--
-- Name: image image_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image ALTER COLUMN image_id SET DEFAULT nextval('public.image_image_id_seq'::regclass);


--
-- Name: image_tag image_tag_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_tag ALTER COLUMN image_tag_id SET DEFAULT nextval('public.image_tag_image_tag_id_seq'::regclass);


--
-- Name: inventory_item item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_item ALTER COLUMN item_id SET DEFAULT nextval('public.inventory_item_item_id_seq'::regclass);


--
-- Name: inventory_location location_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_location ALTER COLUMN location_id SET DEFAULT nextval('public.inventory_location_location_id_seq'::regclass);


--
-- Name: inventory_movement movement_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement ALTER COLUMN movement_id SET DEFAULT nextval('public.inventory_movement_movement_id_seq'::regclass);


--
-- Name: inventory_movement_item movement_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement_item ALTER COLUMN movement_item_id SET DEFAULT nextval('public.inventory_movement_item_movement_item_id_seq'::regclass);


--
-- Name: inventory_option option_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_option ALTER COLUMN option_id SET DEFAULT nextval('public.inventory_option_option_id_seq'::regclass);


--
-- Name: inventory_stock stock_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_stock ALTER COLUMN stock_id SET DEFAULT nextval('public.inventory_stock_stock_id_seq'::regclass);


--
-- Name: inventory_supply supply_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_supply ALTER COLUMN supply_id SET DEFAULT nextval('public.inventory_supply_supply_id_seq'::regclass);


--
-- Name: item_price item_price_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_price ALTER COLUMN item_price_id SET DEFAULT nextval('public.item_price_item_price_id_seq'::regclass);


--
-- Name: label label_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.label ALTER COLUMN label_id SET DEFAULT nextval('public.label_label_id_seq'::regclass);


--
-- Name: lang lang_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lang ALTER COLUMN lang_id SET DEFAULT nextval('public.lang_lang_id_seq'::regclass);


--
-- Name: manufacturer manufacturer_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer ALTER COLUMN manufacturer_id SET DEFAULT nextval('public.manufacturer_manufacturer_id_seq'::regclass);


--
-- Name: menu_block block_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_block ALTER COLUMN block_id SET DEFAULT nextval('public.menu_block_block_id_seq'::regclass);


--
-- Name: menu_item item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item ALTER COLUMN item_id SET DEFAULT nextval('public.menu_item_item_id_seq'::regclass);


--
-- Name: notification_history notification_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_history ALTER COLUMN notification_id SET DEFAULT nextval('public.notification_history_notification_id_seq'::regclass);


--
-- Name: notification_template template_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_template ALTER COLUMN template_id SET DEFAULT nextval('public.notification_template_template_id_seq'::regclass);


--
-- Name: offer offer_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offer ALTER COLUMN offer_id SET DEFAULT nextval('public.offer_offer_id_seq'::regclass);


--
-- Name: order_attrs attr_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_attrs ALTER COLUMN attr_id SET DEFAULT nextval('public.order_attrs_attr_id_seq'::regclass);


--
-- Name: order_discount discount_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_discount ALTER COLUMN discount_id SET DEFAULT nextval('public.order_discount_discount_id_seq'::regclass);


--
-- Name: order_history history_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_history ALTER COLUMN history_id SET DEFAULT nextval('public.order_history_history_id_seq'::regclass);


--
-- Name: order_service order_service_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_service ALTER COLUMN order_service_id SET DEFAULT nextval('public.order_service_order_service_id_seq'::regclass);


--
-- Name: order_source source_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_source ALTER COLUMN source_id SET DEFAULT nextval('public.order_source_source_id_seq'::regclass);


--
-- Name: order_status status_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_status ALTER COLUMN status_id SET DEFAULT nextval('public.order_status_status_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: page page_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page ALTER COLUMN page_id SET DEFAULT nextval('public.page_page_id_seq'::regclass);


--
-- Name: payment_callback payment_callback_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_callback ALTER COLUMN payment_callback_id SET DEFAULT nextval('public.payment_callback_payment_callback_id_seq'::regclass);


--
-- Name: payment_method payment_method_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method ALTER COLUMN payment_method_id SET DEFAULT nextval('public.payment_method_payment_method_id_seq'::regclass);


--
-- Name: payment_request payment_request_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_request ALTER COLUMN payment_request_id SET DEFAULT nextval('public.payment_request_payment_request_id_seq'::regclass);


--
-- Name: payment_transaction payment_transaction_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_transaction ALTER COLUMN payment_transaction_id SET DEFAULT nextval('public.payment_transaction_payment_transaction_id_seq'::regclass);


--
-- Name: person person_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person ALTER COLUMN person_id SET DEFAULT nextval('public.person_person_id_seq'::regclass);


--
-- Name: person_address address_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_address ALTER COLUMN address_id SET DEFAULT nextval('public.person_address_address_id_seq'::regclass);


--
-- Name: person_attrs attr_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_attrs ALTER COLUMN attr_id SET DEFAULT nextval('public.person_attrs_attr_id_seq'::regclass);


--
-- Name: person_token token_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_token ALTER COLUMN token_id SET DEFAULT nextval('public.person_token_token_id_seq'::regclass);


--
-- Name: point_sale point_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.point_sale ALTER COLUMN point_id SET DEFAULT nextval('public.point_sale_point_id_seq'::regclass);


--
-- Name: price price_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price ALTER COLUMN price_id SET DEFAULT nextval('public.price_price_id_seq'::regclass);


--
-- Name: product product_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq1'::regclass);


--
-- Name: product_image product_image_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image ALTER COLUMN product_image_id SET DEFAULT nextval('public.product_image_product_image_id_seq'::regclass);


--
-- Name: product_import import_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import ALTER COLUMN import_id SET DEFAULT nextval('public.product_import_import_id_seq'::regclass);


--
-- Name: product_import_imgs import_img_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_imgs ALTER COLUMN import_img_id SET DEFAULT nextval('public.product_import_imgs_import_img_id_seq'::regclass);


--
-- Name: product_import_log log_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_log ALTER COLUMN log_id SET DEFAULT nextval('public.product_import_log_log_id_seq'::regclass);


--
-- Name: product_review review_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review ALTER COLUMN review_id SET DEFAULT nextval('public.product_review_review_id_seq'::regclass);


--
-- Name: product_review_img review_img_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review_img ALTER COLUMN review_img_id SET DEFAULT nextval('public.product_review_img_review_img_id_seq'::regclass);


--
-- Name: product_variant_characteristic rel_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_characteristic ALTER COLUMN rel_id SET DEFAULT nextval('public.product_variant_characteristic_rel_id_seq'::regclass);


--
-- Name: reserve reserve_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve ALTER COLUMN reserve_id SET DEFAULT nextval('public.reserve_reserve_id_seq'::regclass);


--
-- Name: reserve_item reserve_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve_item ALTER COLUMN reserve_item_id SET DEFAULT nextval('public.reserve_item_reserve_item_id_seq1'::regclass);


--
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role ALTER COLUMN role_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- Name: route route_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route ALTER COLUMN route_id SET DEFAULT nextval('public.route_route_id_seq'::regclass);


--
-- Name: service service_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service ALTER COLUMN service_id SET DEFAULT nextval('public.service_service_id_seq'::regclass);


--
-- Name: setting setting_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting ALTER COLUMN setting_id SET DEFAULT nextval('public.setting_setting_id_seq'::regclass);


--
-- Name: site site_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site ALTER COLUMN site_id SET DEFAULT nextval('public.site_site_id_seq'::regclass);


--
-- Name: stream stream_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stream ALTER COLUMN stream_id SET DEFAULT nextval('public.stream_stream_id_seq'::regclass);


--
-- Name: tax_class tax_class_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_class ALTER COLUMN tax_class_id SET DEFAULT nextval('public.tax_class_tax_class_id_seq'::regclass);


--
-- Name: tax_rate tax_rate_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_rate ALTER COLUMN tax_rate_id SET DEFAULT nextval('public.tax_rate_tax_rate_id_seq'::regclass);


--
-- Name: theme_installed installed_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme_installed ALTER COLUMN installed_id SET DEFAULT nextval('public.theme_installed_installed_id_seq'::regclass);


--
-- Name: track_number track_number_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_number ALTER COLUMN track_number_id SET DEFAULT nextval('public.order_track_number_track_number_id_seq'::regclass);


--
-- Name: transfer transfer_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer ALTER COLUMN transfer_id SET DEFAULT nextval('public.transfer_transfer_id_seq'::regclass);


--
-- Name: transfer_item transfer_item_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer_item ALTER COLUMN transfer_item_id SET DEFAULT nextval('public.transfer_item_transfer_item_id_seq'::regclass);


--
-- Name: typearea typearea_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typearea ALTER COLUMN typearea_id SET DEFAULT nextval('public.typearea_typearea_id_seq'::regclass);


--
-- Name: typearea_block block_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typearea_block ALTER COLUMN block_id SET DEFAULT nextval('public.typearea_block_block_id_seq'::regclass);


--
-- Name: unit_measurement unit_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_measurement ALTER COLUMN unit_id SET DEFAULT nextval('public.unit_measurement_unit_id_seq'::regclass);


--
-- Name: variant variant_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant ALTER COLUMN variant_id SET DEFAULT nextval('public.variant_variant_id_seq'::regclass);


--
-- Name: variant_image variant_image_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_image ALTER COLUMN variant_image_id SET DEFAULT nextval('public.variant_image_variant_image_id_seq'::regclass);


--
-- Name: warehouse warehouse_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.warehouse ALTER COLUMN warehouse_id SET DEFAULT nextval('public.warehouse_warehouse_id_seq'::regclass);


--
-- Name: webhook webhook_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook ALTER COLUMN webhook_id SET DEFAULT nextval('public.webhook_webhook_id_seq'::regclass);


--
-- Name: webhook_log webhook_log_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook_log ALTER COLUMN webhook_log_id SET DEFAULT nextval('public.webhook_log_webhook_log_id_seq'::regclass);


--
-- Data for Name: admin_comment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_comment (comment_id, essence_id, person_id, comment, created_at) FROM stdin;
\.


--
-- Data for Name: api_file_uploader; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.api_file_uploader (id, file_id, path, chunk_position, is_initial, data, created_at, file_size) FROM stdin;
\.


--
-- Data for Name: api_token; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.api_token (token_id, name, client_id, secret, permanent_token, require_exp, created_at, deleted_at, is_system, can_manage) FROM stdin;
\.


--
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.article (article_id, site_id, lang_id, title, url_key, date, announcement, content, image_id, status, created_by, created_at, deleted_at) FROM stdin;
1	1	1	Поступление новой коллекции!	postuplenie-novoi-kollekcii	2017-10-31 06:55:00+00	В наш магазин поступила долгожданная новая коллекция! Спешите!	<p>Таким образом постоянный количественный рост и сфера нашей активности влечет за собой процесс внедрения и модернизации новых предложений. Задача организации, в особенности же рамки и место обучения кадров требуют от нас анализа систем массового участия. С другой стороны новая модель организационной деятельности позволяет оценить значение дальнейших направлений развития.</p><p>Таким образом сложившаяся структура организации способствует подготовки и реализации системы обучения кадров, соответствует насущным потребностям. Равным образом сложившаяся структура организации способствует подготовки и реализации позиций, занимаемых участниками в отношении поставленных задач. С другой стороны укрепление и развитие структуры представляет собой интересный эксперимент проверки новых предложений.</p>	298	published	\N	2017-11-14 14:30:21.400398+00	\N
2	1	1	Грандиозная распродажа!	grandioznaya-rasprodazha	2017-10-31 07:05:00+00	На все модели чехлов. Только в октябре!	<p>Таким образом постоянный количественный рост и сфера нашей активности влечет за собой процесс внедрения и модернизации новых предложений. Задача организации, в особенности же рамки и место обучения кадров требуют от нас анализа систем массового участия. С другой стороны новая модель организационной деятельности позволяет оценить значение дальнейших направлений развития.</p><p>Таким образом сложившаяся структура организации способствует подготовки и реализации системы обучения кадров, соответствует насущным потребностям. Равным образом сложившаяся структура организации способствует подготовки и реализации позиций, занимаемых участниками в отношении поставленных задач. С другой стороны укрепление и развитие структуры представляет собой интересный эксперимент проверки новых предложений.</p>	299	published	\N	2017-11-14 14:30:21.407142+00	\N
3	1	1	Режим работы магазина изменен!	rezhim-raboty-magazina-izmenen	2017-10-30 07:11:00+00	В ноябрьские праздники работаем без выходных!	<p>Таким образом постоянный количественный рост и сфера нашей активности влечет за собой процесс внедрения и модернизации новых предложений. Задача организации, в особенности же рамки и место обучения кадров требуют от нас анализа систем массового участия. С другой стороны новая модель организационной деятельности позволяет оценить значение дальнейших направлений развития.</p><p>Таким образом сложившаяся структура организации способствует подготовки и реализации системы обучения кадров, соответствует насущным потребностям. Равным образом сложившаяся структура организации способствует подготовки и реализации позиций, занимаемых участниками в отношении поставленных задач. С другой стороны укрепление и развитие структуры представляет собой интересный эксперимент проверки новых предложений.</p>	300	published	\N	2017-11-14 14:30:21.422681+00	\N
\.


--
-- Data for Name: auth_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_resource (resource_id, parent_id, alias, title) FROM stdin;
4	\N	auth	auth
5	\N	system	system
6	\N	user	user
7	4	auth:login	auth:login
8	5	system:index	system:index
9	5	system:error	system:error
10	6	user:index	user:index
11	6	user:user	user:user
12	6	user:sub	user:sub
13	6	user:sub:index	user:sub:index
14	\N	dashboard	dashboard
15	14	dashboard:admin	dashboard:admin
16	15	dashboard:admin:index	dashboard:admin:index
17	4	auth:logout	auth:logout
18	4	auth:user	auth:user
19	\N	catalog	catalog
20	19	catalog:admin	catalog:admin
21	20	catalog:admin:product	catalog:admin:product
22	20	catalog:admin:commodityGroup	catalog:admin:commodityGroup
23	20	catalog:admin:manufacturer	catalog:admin:manufacturer
25	20	catalog:admin:category	catalog:admin:category
27	20	catalog:admin:characteristic	catalog:admin:characteristic
30	\N	inventory	inventory
31	30	inventory:admin	inventory:admin
32	31	inventory:admin:warehouse	inventory:admin:warehouse
34	31	inventory:admin:option	inventory:admin:option
35	34	inventory:admin:option:changeQty	inventory:admin:option:changeQty
36	31	inventory:admin:history	inventory:admin:history
37	36	inventory:admin:history:changeQty	inventory:admin:history:changeQty
39	\N	orders	orders
40	39	orders:admin	orders:admin
41	40	orders:admin:orders	orders:admin:orders
42	39	orders:basket	orders:basket
43	40	orders:admin:orderItems	orders:admin:orderItems
44	40	orders:admin:specifyWarehouse	orders:admin:specifyWarehouse
45	\N	customer	customer
46	45	customer:admin	customer:admin
47	46	customer:admin:group	customer:admin:group
48	46	customer:admin:customer	customer:admin:customer
50	5	system:city	system:city
51	50	system:city:autocomplete	system:city:autocomplete
53	5	system:region	system:region
54	5	system:area	system:area
55	40	orders:admin:setup	orders:admin:setup
56	55	orders:admin:setup:delivery	orders:admin:setup:delivery
57	40	orders:admin:shipping	orders:admin:shipping
58	20	catalog:admin:service	catalog:admin:service
60	55	orders:admin:setup:order	orders:admin:setup:order
61	\N	cms	cms
62	61	cms:page	cms:page
63	61	cms:admin	cms:admin
64	63	cms:admin:page	cms:admin:page
65	63	cms:admin:imageManager	cms:admin:imageManager
66	63	cms:admin:image	cms:admin:image
67	61	cms:image	cms:image
68	63	cms:admin:navigation	cms:admin:navigation
69	61	cms:navigation	cms:navigation
72	20	catalog:admin:settings	catalog:admin:settings
75	20	catalog:admin:filter	catalog:admin:filter
80	5	system:search	system:search
81	20	catalog:admin:productQtyHistory	catalog:admin:productQtyHistory
82	20	catalog:admin:collection	catalog:admin:collection
85	20	catalog:admin:import	catalog:admin:import
86	\N	exchange	exchange
87	86	exchange:admin	exchange:admin
88	87	exchange:admin:oneC	exchange:admin:oneC
89	87	exchange:admin:oneCLogs	exchange:admin:oneCLogs
90	86	exchange:oneC	exchange:oneC
91	87	exchange:admin:yml	exchange:admin:yml
92	86	exchange:yml	exchange:yml
94	31	inventory:admin:stockPerWarehouse	inventory:admin:stockPerWarehouse
95	\N	delivery	delivery
96	95	delivery:admin	delivery:admin
97	96	delivery:admin:parcel	delivery:admin:parcel
98	96	delivery:admin:transmissionAct	delivery:admin:transmissionAct
99	5	system:admin	system:admin
101	99	system:admin:cms	system:admin:cms
102	5	system:cms	system:cms
103	5	system:tpl	system:tpl
104	\N	theme	theme
105	104	theme:admin	theme:admin
106	105	theme:admin:themes	theme:admin:themes
107	105	theme:admin:customize	theme:admin:customize
108	104	theme:layoutSamples	theme:layoutSamples
109	104	theme:bosses	theme:bosses
110	109	theme:bosses:logo	theme:bosses:logo
111	105	theme:admin:upload	theme:admin:upload
112	109	theme:bosses:text	theme:bosses:text
113	109	theme:bosses:block	theme:bosses:block
114	109	theme:bosses:container	theme:bosses:container
115	40	orders:admin:print	orders:admin:print
116	105	theme:admin:colors	theme:admin:colors
117	105	theme:admin:less	theme:admin:less
118	99	system:admin:company	system:admin:company
119	105	theme:admin:background	theme:admin:background
120	105	theme:admin:fonts	theme:admin:fonts
121	105	theme:admin:colorSchemes	theme:admin:colorSchemes
122	109	theme:bosses:carousel	theme:bosses:carousel
123	109	theme:bosses:externalWidget	theme:bosses:externalWidget
125	4	auth:me	auth:me
126	99	system:admin:cleanUp	system:admin:cleanUp
127	105	theme:admin:sources	theme:admin:sources
128	4	auth:restore	auth:restore
129	14	dashboard:client	dashboard:client
130	20	catalog:admin:label	catalog:admin:label
132	109	theme:bosses:collection	theme:bosses:collection
133	105	theme:admin:favicon	theme:admin:favicon
137	\N	payment	payment
138	137	payment:yandex	payment:yandex
139	138	payment:yandex:gateway	payment:yandex:gateway
140	137	payment:yandex:user	payment:yandex:user
141	109	theme:bosses:instagram	theme:bosses:instagram
142	61	cms:instagram	cms:instagram
144	5	system:sellios	system:sellios
145	144	system:sellios:account	system:sellios:account
146	144	system:sellios:payment	system:sellios:payment
147	20	catalog:admin:manufacturerImage	catalog:admin:manufacturerImage
148	99	system:admin:domain	system:admin:domain
149	105	theme:admin:email	theme:admin:email
150	55	orders:admin:setup:deliveryBox	orders:admin:setup:deliveryBox
151	31	inventory:admin:warehouseMovements	inventory:admin:warehouseMovements
152	\N	system:feature	system:feature
153	21	catalog:admin:product:simple	catalog:admin:product:simple
154	21	catalog:admin:product:characteristic	catalog:admin:product:characteristic
155	21	catalog:admin:product:variant	catalog:admin:product:variant
158	109	theme:bosses:textWithIcons	theme:bosses:textWithIcons
159	55	orders:admin:setup:discount	orders:admin:setup:discount
160	21	catalog:admin:product:imgSize	catalog:admin:product:imgSize
161	55	orders:admin:setup:sms	orders:admin:setup:sms
162	109	theme:bosses:vk	theme:bosses:vk
163	109	theme:bosses:map	theme:bosses:map
164	109	theme:bosses:socialButtons	theme:bosses:socialButtons
165	61	cms:blog	cms:blog
166	63	cms:admin:blog	cms:admin:blog
167	109	theme:bosses:blog	theme:bosses:blog
168	61	cms:form	cms:form
169	109	theme:bosses:form	theme:bosses:form
170	63	cms:admin:form	cms:admin:form
171	109	theme:bosses:product	theme:bosses:product
173	105	theme:admin:page	theme:admin:page
174	109	theme:bosses:section	theme:bosses:section
175	109	theme:bosses:cover	theme:bosses:cover
176	109	theme:bosses:imgsCombinations	theme:bosses:imgsCombinations
177	5	system:style	system:style
179	109	theme:bosses:header	theme:bosses:header
180	109	theme:bosses:review	theme:bosses:review
181	99	system:admin:comment	system:admin:comment
182	109	theme:bosses:menu	theme:bosses:menu
183	137	payment:methods	payment:methods
184	85	catalog:admin:import:yml	catalog:admin:import:yml
191	137	payment:roboKassa	payment:roboKassa
192	191	payment:roboKassa:user	payment:roboKassa:user
193	191	payment:roboKassa:gateway	payment:roboKassa:gateway
194	137	payment:result	payment:result
195	25	catalog:admin:category:products	catalog:admin:category:products
196	40	orders:admin:discount	orders:admin:discount
197	196	orders:admin:discount:codes	orders:admin:discount:codes
199	40	orders:admin:order	orders:admin:order
200	199	orders:admin:order:discount	orders:admin:order:discount
202	21	catalog:admin:product:category	catalog:admin:product:category
205	22	catalog:admin:commodityGroup:characteristic	catalog:admin:commodityGroup:characteristic
206	21	catalog:admin:product:image	catalog:admin:product:image
207	21	catalog:admin:product:additions	catalog:admin:product:additions
208	99	system:admin:seoTpl	system:admin:seoTpl
209	21	catalog:admin:product:seo	catalog:admin:product:seo
210	155	catalog:admin:product:variant:multi	catalog:admin:product:variant:multi
211	63	cms:admin:redactor	cms:admin:redactor
212	21	catalog:admin:product:bulk	catalog:admin:product:bulk
213	105	theme:admin:productPage	theme:admin:productPage
214	109	theme:bosses:productPage	theme:bosses:productPage
215	21	catalog:admin:product:crossSell	catalog:admin:product:crossSell
217	25	catalog:admin:category:form	catalog:admin:category:form
218	25	catalog:admin:category:tree	catalog:admin:category:tree
219	25	catalog:admin:category:seo	catalog:admin:category:seo
220	64	cms:admin:page:tree	cms:admin:page:tree
222	109	theme:bosses:iconWithLink	theme:bosses:iconWithLink
223	99	system:admin:site	system:admin:site
224	109	theme:bosses:itemsSwiper	theme:bosses:itemsSwiper
225	109	theme:bosses:swiperSlider	theme:bosses:swiperSlider
226	21	catalog:admin:product:export	catalog:admin:product:export
227	109	theme:bosses:imgsTiger	theme:bosses:imgsTiger
228	109	theme:bosses:bobcatGallery	theme:bosses:bobcatGallery
229	109	theme:bosses:elephantMenu	theme:bosses:elephantMenu
230	109	theme:bosses:flexHeader	theme:bosses:flexHeader
231	5	system:favicon	system:favicon
232	99	system:admin:schemaOrg	system:admin:schemaOrg
233	39	orders:review	orders:review
234	21	catalog:admin:product:reviews	catalog:admin:product:reviews
235	63	cms:admin:imageTag	cms:admin:imageTag
236	4	auth:admin	auth:admin
237	236	auth:admin:token	auth:admin:token
238	199	orders:admin:order:items	orders:admin:order:items
239	199	orders:admin:order:shipping	orders:admin:order:shipping
240	55	orders:admin:setup:orderStatus	orders:admin:setup:orderStatus
241	199	orders:admin:order:customAttrs	orders:admin:order:customAttrs
242	199	orders:admin:order:tracking	orders:admin:order:tracking
243	46	customer:admin:address	customer:admin:address
244	46	customer:admin:customAttrs	customer:admin:customAttrs
245	199	orders:admin:order:customer	orders:admin:order:customer
246	63	cms:admin:favicon	cms:admin:favicon
247	236	auth:admin:users	auth:admin:users
248	99	system:admin:mail	system:admin:mail
249	55	orders:admin:setup:notification	orders:admin:setup:notification
250	99	system:admin:webhook	system:admin:webhook
251	99	system:admin:frontend	system:admin:frontend
252	4	auth:settings	auth:settings
279	25	catalog:admin:category:iconUpload	catalog:admin:category:iconUpload
281	137	payment:admin	payment:admin
282	281	payment:admin:paymentMethod	payment:admin:paymentMethod
286	199	orders:admin:order:paymentMethod	orders:admin:order:paymentMethod
294	199	orders:admin:order:paymentTransaction	orders:admin:order:paymentTransaction
301	20	catalog:admin:feeds	catalog:admin:feeds
307	144	system:sellios:quickPay	system:sellios:quickPay
308	19	catalog:feed	catalog:feed
313	99	system:admin:tax	system:admin:tax
315	19	catalog:collection	catalog:collection
319	137	payment:paypal	payment:paypal
\.


--
-- Data for Name: auth_rule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_rule (rule_id, role_id, resource_id, task_id, is_allowed) FROM stdin;
6	1	7	\N	t
7	1	8	\N	t
8	1	9	\N	t
9	1	10	\N	t
10	1	11	\N	t
11	2	14	\N	t
12	1	17	\N	t
13	1	18	\N	t
14	2	20	\N	t
18	2	25	\N	t
21	2	31	\N	t
22	2	40	\N	t
23	1	42	\N	t
24	2	46	\N	t
25	1	50	\N	t
26	1	53	\N	t
27	1	54	\N	t
28	1	62	\N	t
29	2	63	\N	t
30	1	67	\N	t
31	1	69	\N	t
39	1	80	\N	t
41	2	87	\N	t
42	1	90	\N	t
43	1	92	\N	t
44	2	96	\N	t
45	2	99	\N	t
46	1	102	\N	t
47	1	103	\N	t
48	2	105	\N	t
49	1	108	\N	t
50	2	109	\N	t
52	3	125	\N	t
53	2	125	\N	t
54	2	126	\N	t
55	1	128	\N	t
56	3	129	\N	t
57	2	130	\N	t
59	2	133	\N	t
60	1	139	\N	t
61	3	140	\N	t
62	2	140	\N	t
63	1	142	\N	t
64	2	144	\N	t
65	2	147	\N	t
66	2	148	\N	t
67	2	150	\N	t
68	2	151	\N	t
69	1	152	\N	t
70	1	165	\N	t
71	1	168	\N	t
73	1	177	\N	t
74	3	183	\N	t
76	1	140	\N	t
77	1	183	\N	t
80	1	192	\N	t
81	2	192	\N	t
82	3	192	\N	t
83	1	193	\N	t
84	2	194	\N	t
85	3	194	\N	t
86	4	194	\N	t
87	2	129	\N	t
88	4	129	\N	t
91	1	231	\N	t
92	1	233	\N	t
93	2	236	\N	t
94	2	252	\N	t
95	5	40	\N	t
96	5	125	\N	t
97	5	\N	6	t
98	5	\N	7	t
99	6	20	\N	t
100	6	31	\N	t
101	6	125	\N	t
102	6	\N	6	t
103	6	\N	7	t
104	2	282	\N	t
105	2	286	\N	t
106	5	286	\N	t
107	2	294	\N	t
108	5	294	\N	t
109	2	301	\N	t
110	6	301	\N	t
111	1	307	\N	t
112	1	308	\N	t
113	2	313	\N	t
114	2	315	\N	t
115	6	315	\N	t
116	1	319	\N	t
117	6	181	\N	t
118	5	181	\N	t
\.


--
-- Data for Name: auth_task; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_task (task_id, resource_id, alias, title) FROM stdin;
6	252	adminLeftSidebar	adminLeftSidebar
7	15	actionIndex	actionIndex
\.


--
-- Data for Name: basket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.basket (basket_id, person_id, is_active, public_id, created_at) FROM stdin;
\.


--
-- Data for Name: basket_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.basket_item (basket_item_id, basket_id, item_id, qty, item_price_id, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: box; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.box (box_id, length, width, height, created_at, deleted_at) FROM stdin;
1	85.00	53.00	76.00	2017-04-22 16:40:24.456038	\N
2	42.50	26.50	38.00	2017-04-22 16:40:24.456038	\N
3	26.50	16.50	19.00	2017-04-22 16:40:24.456038	\N
4	22.00	18.50	5.00	2017-04-22 16:40:24.456038	\N
\.


--
-- Data for Name: box_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.box_text (box_id, lang_id, title) FROM stdin;
1	1	Очень большая
2	1	Большая
3	1	Средняя
4	1	Маленькая
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category (category_id, parent_id, site_id, sort, created_at, deleted_at, external_id, status, created_by, image_id) FROM stdin;
108	107	1	1	2017-04-22 16:29:39.94192+00	\N	\N	published	\N	\N
109	107	1	2	2017-04-22 16:30:02.649373+00	\N	\N	published	\N	\N
110	107	1	3	2017-04-22 16:30:26.133662+00	\N	\N	published	\N	\N
111	107	1	4	2017-04-22 16:31:20.681831+00	\N	\N	published	\N	\N
103	99	1	1	2017-04-22 16:21:42.979039+00	\N	\N	published	\N	\N
104	99	1	2	2017-04-22 16:21:51.284754+00	\N	\N	published	\N	\N
105	99	1	3	2017-04-22 16:21:59.150955+00	\N	\N	published	\N	\N
106	99	1	4	2017-04-22 16:22:27.62925+00	\N	\N	published	\N	\N
112	100	1	1	2017-04-24 08:30:09.114208+00	\N	\N	published	\N	\N
113	100	1	2	2017-04-24 08:30:26.916413+00	\N	\N	published	\N	\N
114	100	1	3	2017-04-24 08:30:39.622761+00	\N	\N	published	\N	\N
99	\N	1	0	2017-04-22 16:20:49.144755+00	\N	\N	published	\N	\N
100	\N	1	10	2017-04-22 16:20:56.908798+00	\N	\N	published	\N	\N
101	\N	1	20	2017-04-22 16:21:20.911782+00	\N	\N	published	\N	\N
107	\N	1	30	2017-04-22 16:29:18.181863+00	\N	\N	published	\N	\N
\.


--
-- Data for Name: category_menu_rel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category_menu_rel (category_id, block_id) FROM stdin;
99	4
103	4
104	4
105	4
106	4
100	4
112	4
113	4
114	4
101	4
107	4
108	4
109	4
110	4
111	4
\.


--
-- Data for Name: category_prop; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category_prop (category_id, use_filter, filter_id, custom_link, sub_category_policy, show_in_parent_page_menu, arbitrary_data) FROM stdin;
103	t	\N	\N	\N	t	\N
104	t	\N	\N	\N	t	\N
105	t	\N	\N	\N	t	\N
106	t	\N	\N	\N	t	\N
112	t	\N	\N	\N	t	\N
113	t	\N	\N	\N	t	\N
114	t	\N	\N	\N	t	\N
100	t	\N	\N	\N	f	\N
99	t	\N	\N	\N	f	\N
101	t	\N	\N	\N	f	\N
107	t	\N	\N	\N	f	\N
109	t	\N	\N	\N	f	\N
108	t	\N	\N	\N	f	\N
110	t	\N	\N	\N	f	\N
111	t	\N	\N	\N	f	\N
\.


--
-- Data for Name: category_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category_text (category_id, lang_id, title, custom_title, custom_header, meta_description, meta_keywords, url_key, description_top, description_bottom) FROM stdin;
103	1	iPhone 7	Чехлы для iPhone 7	Чехлы для iPhone 7	\N	\N	iphone-7	\N	\N
104	1	iPhone 7 Plus	Чехлы для iPhone 7 Plus	Чехлы для iPhone 7 Plus	\N	\N	iphone-7-plus	\N	\N
105	1	iPhone 6	Чехлы для iPhone 6	Чехлы для iPhone 6	\N	\N	iphone-6	\N	\N
106	1	iPhone 5/5s	Чехлы для iPhone 5/5s	Чехлы для iPhone 5/5s	\N	\N	iphone-5-5s	\N	\N
112	1	iPad mini 3/ mini 2/ mini	Чехлы для iPad mini 3/ mini 2/ mini	Чехлы для  iPad mini 3/ mini 2/ mini	\N	\N	ipad-mini-3-mini-2-mini	\N	\N
114	1	iPad 4/ 3/ 2	Чехлы для iPad 4/ 3/ 2	Чехлы для iPad 4/ 3/ 2	\N	\N	ipad-4-3-2	\N	\N
113	1	iPad Air 2/ Air	Чехлы для iPad Air 2/ Air	Чехлы для iPad Air 2/ Air	\N	\N	ipad-air-2-air	\N	\N
100	1	iPad cases	\N	\N	\N	\N	chekhly-na-ipad	\N	\N
99	1	iPhone cases	\N	\N	\N	\N	chekhly-na-iphone	\N	\N
101	1	Cases for Samsung	\N	\N	\N	\N	chekhly-dlya-samsung	\N	\N
107	1	Collections	Подборки чехлов	Подборки чехлов	\N	\N	podborki	\N	\N
109	1	For men	Чехлы для мужчин	Чехлы для мужчин	\N	\N	dlya-muzhchin	\N	\N
108	1	For women	Чехлы для девушек	Чехлы для девушек	\N	\N	dlya-devushek	\N	\N
110	1	With picture	Чехлы с рисунком	Чехлы с рисунком	\N	\N	s-risunkom	\N	\N
111	1	With charger	Чехлы с аккумулятором	Чехлы с аккумулятором	\N	\N	s-akkumulyatorom	\N	\N
\.


--
-- Data for Name: characteristic; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic (characteristic_id, parent_id, group_id, type, system_type, alias, sort) FROM stdin;
152157	\N	61	\N	\N	\N	50
152154	152157	61	radio	\N	is_charging_case	20
152155	152157	61	radio	\N	type_of_case	30
152156	152157	61	radio	\N	film_is_included	40
152158	152157	61	checkbox	\N	for_iphone	50
152165	152157	61	checkbox	\N	for_ipad	60
152166	152157	61	checkbox	\N	for_samsung	70
\.


--
-- Data for Name: characteristic_product_val; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic_product_val (value_id, product_id, characteristic_id, case_id) FROM stdin;
872	158	152154	603
873	158	152155	605
874	158	152156	610
875	158	152158	612
876	158	152158	613
877	158	152158	614
878	158	152158	615
883	159	152154	603
884	159	152155	605
885	159	152156	610
886	159	152158	612
887	159	152158	613
888	159	152158	614
889	159	152158	615
916	161	152154	603
917	161	152155	605
918	161	152156	610
919	161	152158	612
920	161	152158	613
921	161	152158	614
922	161	152158	615
923	162	152154	603
924	162	152155	605
925	162	152156	610
926	162	152158	612
927	162	152158	613
928	162	152158	614
929	162	152158	615
945	164	152154	603
946	164	152155	605
947	164	152156	610
948	164	152158	612
949	164	152158	613
950	164	152158	614
951	164	152158	615
956	165	152154	603
957	165	152155	605
958	165	152156	610
959	165	152158	612
960	165	152158	613
961	165	152158	614
962	165	152158	615
978	167	152154	603
979	167	152155	605
980	167	152156	610
981	167	152158	612
982	167	152158	613
983	167	152158	614
984	167	152158	615
1000	169	152154	603
1001	169	152155	609
1002	169	152156	610
1003	169	152165	616
1004	169	152165	617
1005	169	152165	618
1014	170	152165	617
1013	170	152165	616
1010	170	152154	603
1011	170	152156	610
1012	170	152155	609
1015	170	152165	618
1020	171	152154	603
1021	171	152155	609
1022	171	152156	610
1023	171	152165	616
1024	171	152165	617
1025	171	152165	618
1030	172	152154	603
1031	172	152155	609
1032	172	152156	610
1034	172	152165	617
1033	172	152165	616
1035	172	152165	618
1058	175	152154	603
1059	175	152155	606
1060	175	152156	611
1061	175	152166	622
1062	175	152166	623
1067	176	152154	603
1068	176	152155	605
1069	176	152156	611
1070	176	152166	621
1071	176	152166	622
1072	176	152166	623
1095	178	152154	604
1096	178	152155	605
1097	178	152156	611
1098	178	152158	615
1099	179	152154	604
1100	179	152155	605
1101	179	152156	611
1102	179	152158	615
1107	180	152154	604
1108	180	152155	606
1109	180	152156	611
1110	180	152158	614
1115	181	152154	604
1116	181	152155	606
1117	181	152156	611
1118	181	152166	622
1119	181	152166	623
1124	168	152154	603
1125	168	152155	605
1126	168	152156	611
1127	168	152158	612
1128	168	152158	613
1129	168	152158	614
1130	168	152158	615
1131	157	152154	603
1132	157	152155	605
1133	157	152156	611
1134	157	152158	612
1135	157	152158	613
1136	157	152158	614
1137	157	152158	615
1138	166	152154	603
1139	166	152155	605
1140	166	152156	611
1141	166	152158	612
1142	166	152158	613
1143	166	152158	614
1144	166	152158	615
1145	156	152154	603
1146	156	152155	605
1147	156	152156	611
1148	156	152158	612
1149	156	152158	613
1150	156	152158	614
1151	156	152158	615
1152	163	152154	603
1153	163	152155	605
1154	163	152156	611
1155	163	152158	612
1156	163	152158	613
1157	163	152158	614
1158	163	152158	615
1159	155	152154	603
1160	155	152155	605
1161	155	152156	611
1162	155	152158	612
1163	155	152158	613
1164	155	152158	614
1165	155	152158	615
1179	173	152154	603
1180	173	152155	605
1181	173	152156	611
1182	173	152166	619
1183	173	152166	622
1184	174	152154	603
1185	174	152155	609
1186	174	152156	611
1187	174	152166	622
1188	174	152166	623
1189	177	152154	603
1190	177	152155	609
1191	177	152156	611
1192	177	152166	620
1193	177	152166	621
1194	177	152166	622
\.


--
-- Data for Name: characteristic_product_val_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic_product_val_text (value_id, lang_id, value) FROM stdin;
1152	1	\N
1155	1	\N
1156	1	\N
980	1	\N
978	1	\N
979	1	\N
1161	1	\N
981	1	\N
982	1	\N
983	1	\N
1163	1	\N
1165	1	\N
1179	1	\N
1183	1	\N
1185	1	\N
1186	1	\N
1189	1	\N
874	1	\N
872	1	\N
875	1	\N
873	1	\N
876	1	\N
878	1	\N
877	1	\N
1191	1	\N
883	1	\N
886	1	\N
885	1	\N
884	1	\N
887	1	\N
889	1	\N
888	1	\N
1193	1	\N
984	1	\N
916	1	\N
918	1	\N
917	1	\N
919	1	\N
920	1	\N
921	1	\N
922	1	\N
923	1	\N
924	1	\N
925	1	\N
926	1	\N
927	1	\N
928	1	\N
929	1	\N
947	1	\N
946	1	\N
945	1	\N
948	1	\N
949	1	\N
950	1	\N
951	1	\N
957	1	\N
956	1	\N
959	1	\N
958	1	\N
960	1	\N
961	1	\N
962	1	\N
1001	1	\N
1000	1	\N
1002	1	\N
1003	1	\N
1004	1	\N
1005	1	\N
1011	1	\N
1014	1	\N
1012	1	\N
1010	1	\N
1013	1	\N
1015	1	\N
1020	1	\N
1021	1	\N
1022	1	\N
1023	1	\N
1024	1	\N
1025	1	\N
1030	1	\N
1032	1	\N
1031	1	\N
1034	1	\N
1033	1	\N
1035	1	\N
1154	1	\N
1060	1	\N
1061	1	\N
1058	1	\N
1059	1	\N
1062	1	\N
1153	1	\N
1067	1	\N
1068	1	\N
1069	1	\N
1070	1	\N
1071	1	\N
1072	1	\N
1157	1	\N
1158	1	\N
1159	1	\N
1160	1	\N
1162	1	\N
1164	1	\N
1095	1	\N
1096	1	\N
1097	1	\N
1098	1	\N
1099	1	\N
1100	1	\N
1101	1	\N
1102	1	\N
1107	1	\N
1108	1	\N
1109	1	\N
1110	1	\N
1116	1	\N
1115	1	\N
1117	1	\N
1119	1	\N
1118	1	\N
1125	1	\N
1124	1	\N
1126	1	\N
1127	1	\N
1128	1	\N
1129	1	\N
1130	1	\N
1131	1	\N
1132	1	\N
1133	1	\N
1134	1	\N
1135	1	\N
1136	1	\N
1137	1	\N
1138	1	\N
1139	1	\N
1140	1	\N
1141	1	\N
1142	1	\N
1143	1	\N
1144	1	\N
1145	1	\N
1146	1	\N
1147	1	\N
1150	1	\N
1149	1	\N
1148	1	\N
1151	1	\N
1180	1	\N
1181	1	\N
1182	1	\N
1184	1	\N
1187	1	\N
1188	1	\N
1190	1	\N
1192	1	\N
1194	1	\N
\.


--
-- Data for Name: characteristic_prop; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic_prop (characteristic_id, is_folder, is_hidden, default_value) FROM stdin;
152154	f	f	\N
152155	f	f	\N
152156	f	f	\N
152157	t	f	\N
152158	f	f	\N
152165	f	f	\N
152166	f	f	\N
\.


--
-- Data for Name: characteristic_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic_text (characteristic_id, lang_id, title, help) FROM stdin;
152157	1	Case characteristics	\N
152154	1	Is Charging Case?	\N
152155	1	Type of case	\N
152156	1	Film is included	\N
152158	1	For iphone	\N
152165	1	For iPad	\N
152166	1	For Samsung	\N
\.


--
-- Data for Name: characteristic_type_case; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic_type_case (case_id, characteristic_id, sort) FROM stdin;
603	152154	0
604	152154	10
605	152155	0
606	152155	10
607	152155	20
608	152155	30
609	152155	40
610	152156	0
611	152156	10
612	152158	0
613	152158	10
614	152158	20
615	152158	30
616	152165	0
617	152165	10
618	152165	20
619	152166	0
620	152166	10
621	152166	20
622	152166	30
623	152166	40
\.


--
-- Data for Name: characteristic_type_case_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic_type_case_text (case_id, lang_id, title) FROM stdin;
613	1	iPhone 7 plus
614	1	iPhone 6
612	1	iPhone 7
615	1	iPhone 5/5s
616	1	iPad Air 2/ Air
617	1	iPad mini 3/ mini 2/ mini
618	1	iPad 4/ 3/ 2
620	1	Galaxy S8+
621	1	Galaxy S7 Edge
622	1	Galaxy S7
623	1	Galaxy A
619	1	Galaxy S8
603	1	No
604	1	Yes
605	1	Clip case
606	1	Bumper case
607	1	Replacement panel
608	1	Bag
609	1	Book
610	1	No
611	1	Yes
\.


--
-- Data for Name: characteristic_variant_val; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic_variant_val (value_id, variant_id, characteristic_id, case_id, rel_type) FROM stdin;
4387	1208	152158	612	variant
4388	1209	152158	613	variant
4389	1210	152158	614	variant
4390	1211	152158	615	variant
4391	1212	152158	612	variant
4392	1213	152158	613	variant
4393	1214	152158	614	variant
4394	1215	152158	615	variant
4395	1216	152158	612	variant
4396	1217	152158	613	variant
4397	1218	152158	614	variant
4398	1219	152158	615	variant
4399	1220	152158	612	variant
4400	1221	152158	613	variant
4401	1222	152158	614	variant
4402	1223	152158	615	variant
4403	1224	152158	612	variant
4404	1225	152158	613	variant
4405	1226	152158	614	variant
4406	1227	152158	615	variant
4411	1232	152158	612	variant
4412	1233	152158	613	variant
4413	1234	152158	614	variant
4414	1235	152158	615	variant
4415	1236	152158	612	variant
4416	1237	152158	613	variant
4417	1238	152158	614	variant
4418	1239	152158	615	variant
4419	1240	152158	612	variant
4420	1241	152158	613	variant
4421	1242	152158	614	variant
4422	1243	152158	615	variant
4423	1244	152158	612	variant
4424	1245	152158	613	variant
4425	1246	152158	614	variant
4426	1247	152158	615	variant
4427	1248	152158	612	variant
4428	1249	152158	613	variant
4429	1250	152158	614	variant
4430	1251	152158	615	variant
4431	1252	152158	612	variant
4432	1253	152158	613	variant
4433	1254	152158	614	variant
4434	1255	152158	615	variant
4435	1256	152158	612	variant
4436	1257	152158	613	variant
4437	1258	152158	614	variant
4438	1259	152158	615	variant
4439	1260	152158	612	variant
4440	1261	152158	613	variant
4441	1262	152158	614	variant
4442	1263	152158	615	variant
4443	1264	152165	616	variant
4444	1265	152165	617	variant
4445	1266	152165	618	variant
4446	1267	152165	616	variant
4447	1268	152165	617	variant
4448	1269	152165	618	variant
4449	1270	152165	616	variant
4450	1271	152165	617	variant
4451	1272	152165	618	variant
4452	1273	152165	616	variant
4453	1274	152165	617	variant
4454	1275	152165	618	variant
4455	1276	152166	619	variant
4456	1277	152166	622	variant
4457	1278	152166	622	variant
4458	1279	152166	623	variant
4459	1280	152166	622	variant
4460	1281	152166	623	variant
4461	1282	152166	621	variant
4462	1283	152166	622	variant
4463	1284	152166	623	variant
4464	1285	152166	620	variant
4465	1286	152166	621	variant
4466	1287	152166	622	variant
\.


--
-- Data for Name: characteristic_variant_val_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.characteristic_variant_val_text (value_id, lang_id, value) FROM stdin;
4387	1	\N
4388	1	\N
4389	1	\N
4390	1	\N
4391	1	\N
4392	1	\N
4393	1	\N
4394	1	\N
4395	1	\N
4396	1	\N
4397	1	\N
4398	1	\N
4399	1	\N
4400	1	\N
4401	1	\N
4402	1	\N
4403	1	\N
4404	1	\N
4405	1	\N
4406	1	\N
4411	1	\N
4412	1	\N
4413	1	\N
4414	1	\N
4415	1	\N
4416	1	\N
4417	1	\N
4418	1	\N
4419	1	\N
4420	1	\N
4421	1	\N
4422	1	\N
4423	1	\N
4424	1	\N
4425	1	\N
4426	1	\N
4427	1	\N
4428	1	\N
4429	1	\N
4430	1	\N
4431	1	\N
4432	1	\N
4433	1	\N
4434	1	\N
4435	1	\N
4436	1	\N
4437	1	\N
4438	1	\N
4439	1	\N
4440	1	\N
4441	1	\N
4442	1	\N
4443	1	\N
4444	1	\N
4445	1	\N
4446	1	\N
4447	1	\N
4448	1	\N
4449	1	\N
4450	1	\N
4451	1	\N
4452	1	\N
4453	1	\N
4454	1	\N
4455	1	\N
4456	1	\N
4457	1	\N
4458	1	\N
4459	1	\N
4460	1	\N
4461	1	\N
4462	1	\N
4463	1	\N
4464	1	\N
4465	1	\N
4466	1	\N
\.


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.collection (collection_id, site_id, lang_id, title, alias, created_at, deleted_at) FROM stdin;
2	1	1	Products on the main page	main-page	2015-11-23 09:29:45.510196+00	\N
3	1	1	Best sellers	best-sellers	2017-04-24 13:00:59.874529+00	\N
\.


--
-- Data for Name: collection_product_rel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.collection_product_rel (rel_id, collection_id, product_id, sort) FROM stdin;
15	2	165	0
16	2	156	10
17	2	163	20
18	2	162	30
19	2	168	40
20	2	172	50
21	2	176	60
22	2	181	70
23	3	163	0
24	3	155	10
25	3	162	20
26	3	158	30
28	3	168	50
29	3	166	60
30	3	174	70
\.


--
-- Data for Name: commodity_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.commodity_group (group_id, type, unit_id, not_track_inventory, created_at, deleted_at, yml_export, is_default, vat, physical_products) FROM stdin;
61	material	1	t	2017-04-22 16:23:34.752487+00	\N	t	t	noVat	t
\.


--
-- Data for Name: commodity_group_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.commodity_group_text (group_id, lang_id, title) FROM stdin;
61	1	Default Product type
\.


--
-- Data for Name: consumed_space; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.consumed_space (space_id, type, volume, bucket, updated_at) FROM stdin;
\.


--
-- Data for Name: coupon_campaign; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupon_campaign (campaign_id, title, discount_type, discount_value, limit_usage_per_code, limit_usage_per_customer, min_order_amount, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: coupon_code; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupon_code (code_id, campaign_id, code, created_at) FROM stdin;
\.


--
-- Data for Name: cross_sell; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cross_sell (cross_sell_id, category_id, product_id, rel_product_id, sort) FROM stdin;
1	1	164	159	\N
2	1	164	178	\N
3	1	164	165	\N
4	1	164	169	\N
5	1	164	168	\N
7	1	164	177	\N
8	1	164	161	\N
9	1	167	159	\N
10	1	167	168	\N
11	1	167	173	\N
12	1	167	169	\N
13	1	167	178	\N
14	1	167	165	\N
15	1	167	161	\N
16	1	167	162	\N
17	1	179	155	\N
18	1	179	171	\N
19	1	179	163	\N
20	1	179	172	\N
21	1	179	176	\N
22	1	179	177	\N
23	1	179	165	\N
24	1	179	173	\N
25	1	178	168	\N
26	1	178	164	\N
27	1	178	155	\N
28	1	178	159	\N
29	1	178	175	\N
31	1	178	156	\N
32	1	178	165	\N
33	1	180	168	\N
34	1	180	176	\N
35	1	180	181	\N
36	1	180	164	\N
37	1	180	161	\N
38	1	180	177	\N
39	1	180	156	\N
40	1	180	174	\N
41	1	161	180	\N
42	1	161	169	\N
43	1	161	165	\N
44	1	161	172	\N
45	1	161	177	\N
46	1	161	175	\N
47	1	161	164	\N
48	1	161	174	\N
49	1	157	179	\N
50	1	157	167	\N
51	1	157	156	\N
52	1	157	169	\N
53	1	157	155	\N
54	1	157	164	\N
55	1	157	163	\N
56	1	157	159	\N
57	1	156	164	\N
58	1	156	162	\N
59	1	156	177	\N
60	1	156	175	\N
61	1	156	170	\N
62	1	156	168	\N
63	1	156	174	\N
64	1	156	179	\N
66	1	171	170	\N
67	1	171	159	\N
68	1	171	180	\N
69	1	171	164	\N
70	1	171	177	\N
71	1	171	158	\N
72	1	171	155	\N
73	1	163	179	\N
74	1	163	166	\N
75	1	163	157	\N
76	1	163	178	\N
77	1	163	167	\N
78	1	163	171	\N
79	1	163	180	\N
80	1	163	172	\N
81	1	155	157	\N
82	1	155	162	\N
83	1	155	161	\N
84	1	155	181	\N
85	1	155	165	\N
86	1	155	179	\N
87	1	155	171	\N
88	1	155	172	\N
89	1	162	175	\N
90	1	162	180	\N
92	1	162	174	\N
93	1	162	179	\N
94	1	162	159	\N
95	1	162	178	\N
96	1	162	165	\N
97	1	158	174	\N
98	1	158	169	\N
99	1	158	177	\N
100	1	158	165	\N
101	1	158	178	\N
103	1	158	179	\N
104	1	158	156	\N
113	1	168	161	\N
114	1	168	164	\N
115	1	168	175	\N
116	1	168	178	\N
117	1	168	173	\N
118	1	168	179	\N
119	1	168	171	\N
120	1	168	172	\N
121	1	166	180	\N
122	1	166	164	\N
123	1	166	168	\N
124	1	166	156	\N
125	1	166	155	\N
126	1	166	170	\N
127	1	166	167	\N
128	1	166	163	\N
130	1	159	179	\N
131	1	159	177	\N
132	1	159	155	\N
133	1	159	165	\N
134	1	159	161	\N
135	1	159	166	\N
136	1	159	162	\N
137	1	170	168	\N
138	1	170	181	\N
139	1	170	177	\N
140	1	170	176	\N
141	1	170	164	\N
142	1	170	163	\N
143	1	170	175	\N
144	1	170	161	\N
145	1	172	165	\N
146	1	172	179	\N
147	1	172	175	\N
148	1	172	173	\N
149	1	172	171	\N
150	1	172	157	\N
151	1	172	168	\N
152	1	172	158	\N
153	1	169	168	\N
154	1	169	179	\N
155	1	169	170	\N
156	1	169	164	\N
157	1	169	167	\N
158	1	169	166	\N
159	1	169	158	\N
160	1	169	165	\N
161	1	175	156	\N
162	1	175	157	\N
164	1	175	172	\N
165	1	175	168	\N
166	1	175	174	\N
167	1	175	163	\N
168	1	175	164	\N
169	1	176	155	\N
170	1	176	163	\N
171	1	176	157	\N
172	1	176	158	\N
173	1	176	170	\N
174	1	176	179	\N
175	1	176	156	\N
176	1	176	172	\N
177	1	181	175	\N
178	1	181	170	\N
179	1	181	179	\N
180	1	181	178	\N
181	1	181	155	\N
182	1	181	173	\N
183	1	181	180	\N
184	1	181	163	\N
185	1	165	158	\N
186	1	165	172	\N
187	1	165	175	\N
188	1	165	164	\N
189	1	165	155	\N
190	1	165	167	\N
191	1	165	166	\N
192	1	165	157	\N
193	1	173	171	\N
194	1	173	165	\N
195	1	173	180	\N
196	1	173	179	\N
197	1	173	162	\N
199	1	173	178	\N
200	1	173	161	\N
201	1	174	175	\N
202	1	174	161	\N
203	1	174	180	\N
204	1	174	176	\N
205	1	174	178	\N
206	1	174	167	\N
207	1	174	156	\N
208	1	174	171	\N
209	1	177	180	\N
210	1	177	172	\N
211	1	177	158	\N
212	1	177	171	\N
213	1	177	169	\N
214	1	177	167	\N
215	1	177	164	\N
216	1	177	175	\N
\.


--
-- Data for Name: cross_sell_category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cross_sell_category (category_id, alias, title) FROM stdin;
1	related	Frequently Bought Together
2	similar	Similar Products
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.currency (currency_id, alias, code, title) FROM stdin;
14	afn	971	Afghani
15	all	8	Lek
16	dzd	12	Algerian Dinar
32	xof	952	CFA Franc BCEAO
18	aoa	973	Kwanza
5	uah	980	Hryvnia
21	ars	32	Argentine Peso
8	amd	51	Armenian Dram
23	awg	533	Aruban Florin
7	azn	944	Azerbaijan Manat
26	bsd	44	Bahamian Dollar
27	bhd	48	Bahraini Dinar
28	bdt	50	Taka
29	bbd	52	Barbados Dollar
2	byn	933	Belarusian Ruble
31	bzd	84	Belize Dollar
33	bmd	60	Bermudian Dollar
35	btn	64	Ngultrum
36	bob	68	Boliviano
37	bov	984	Mvdol
143	mru	929	Ouguiya
39	bam	977	Convertible Mark
40	bwp	72	Pula
42	brl	986	Brazilian Real
144	mur	480	Mauritius Rupee
44	bnd	96	Brunei Dollar
45	bgn	975	Bulgarian Lev
145	xua	965	ADB Unit of Account
47	bif	108	Burundi Franc
48	cve	132	Cabo Verde Escudo
49	khr	116	Riel
51	cad	124	Canadian Dollar
52	kyd	136	Cayman Islands Dollar
146	mxn	484	Mexican Peso
147	mxv	979	Mexican Unidad de Inversion (UDI)
55	clp	152	Chilean Peso
56	clf	990	Unidad de Fomento
57	cny	156	Yuan Renminbi
4	usd	840	US Dollar
10	mdl	498	Moldovan Leu
60	cop	170	Colombian Peso
61	cou	970	Unidad de Valor Real
62	kmf	174	Comorian Franc
63	cdf	976	Congolese Franc
150	mnt	496	Tugrik
66	crc	188	Costa Rican Colon
65	nzd	554	New Zealand Dollar
68	hrk	191	Kuna
69	cup	192	Cuban Peso
70	cuc	931	Peso Convertible
71	ang	532	Netherlands Antillean Guilder
72	czk	203	Czech Koruna
74	djf	262	Djibouti Franc
76	dop	214	Dominican Peso
153	mzn	943	Mozambique Metical
78	egp	818	Egyptian Pound
79	svc	222	El Salvador Colon
154	mmk	104	Kyat
155	nad	516	Namibia Dollar
82	ern	232	Nakfa
83	szl	748	Lilangeni
84	etb	230	Ethiopian Birr
3	eur	978	Euro
86	fkp	238	Falkland Islands Pound
134	chf	756	Swiss Franc
88	fjd	242	Fiji Dollar
50	xaf	950	CFA Franc BEAC
91	gmd	270	Dalasi
92	gel	981	Lari
93	ghs	936	Ghana Cedi
94	gip	292	Gibraltar Pound
73	dkk	208	Danish Krone
178	pln	985	Zloty
180	qar	634	Qatari Rial
98	gtq	320	Quetzal
158	npr	524	Nepalese Rupee
100	gnf	324	Guinean Franc
11	tjs	972	Somoni
102	gyd	328	Guyana Dollar
103	htg	332	Gourde
168	omr	512	Rial Omani
152	mad	504	Moroccan Dirham
106	hnl	340	Lempira
107	hkd	344	Hong Kong Dollar
108	huf	348	Forint
109	isk	352	Iceland Krona
34	inr	356	Indian Rupee
111	idr	360	Rupiah
112	xdr	960	SDR (Special Drawing Right)
113	irr	364	Iranian Rial
114	iqd	368	Iraqi Dinar
181	ron	946	Romanian Leu
116	ils	376	Israeli Sheqel
117	jmd	388	Jamaican Dollar
118	jpy	392	Yen
12	uzs	860	Uzbekistan Sum
120	jod	400	Jordanian Dinar
6	kzt	398	Tenge
122	kes	404	Kenyan Shilling
169	pkr	586	Pakistan Rupee
124	kpw	408	North Korean Won
125	krw	410	Won
126	kwd	414	Kuwaiti Dinar
9	kgs	417	Som
128	lak	418	Lao Kip
129	lbp	422	Lebanese Pound
130	lsl	426	Loti
132	lrd	430	Liberian Dollar
133	lyd	434	Libyan Dinar
135	mop	446	Pataca
136	mkd	807	Denar
137	mga	969	Malagasy Ariary
138	mwk	454	Malawi Kwacha
139	myr	458	Malaysian Ringgit
140	mvr	462	Rufiyaa
161	nio	558	Cordoba Oro
131	zar	710	Rand
163	ngn	566	Naira
1	rub	643	Russian Ruble
171	pab	590	Balboa
183	rwf	646	Rwanda Franc
173	pgk	598	Kina
174	pyg	600	Guarani
175	pen	604	Sol
176	php	608	Philippine Peso
184	shp	654	Saint Helena Pound
19	xcd	951	East Caribbean Dollar
188	wst	882	Tala
189	stn	930	Dobra
190	sar	682	Saudi Riyal
192	rsd	941	Serbian Dinar
193	scr	690	Seychelles Rupee
194	sll	694	Leone
195	sgd	702	Singapore Dollar
196	sbd	90	Solomon Islands Dollar
197	sos	706	Somali Shilling
199	ssp	728	South Sudanese Pound
24	aud	36	Australian Dollar
13	gbp	826	Pound Sterling
89	xpf	953	CFP Franc
200	lkr	144	Sri Lanka Rupee
201	sdg	938	Sudanese Pound
202	srd	968	Surinam Dollar
41	nok	578	Norwegian Krone
204	sek	752	Swedish Krona
206	che	947	WIR Euro
207	chw	948	WIR Franc
208	syp	760	Syrian Pound
209	twd	901	New Taiwan Dollar
211	tzs	834	Tanzanian Shilling
212	thb	764	Baht
216	top	776	Pa'anga
217	ttd	780	Trinidad and Tobago Dollar
218	tnd	788	Tunisian Dinar
219	try	949	Turkish Lira
220	tmt	934	Turkmenistan New Manat
223	ugx	800	Uganda Shilling
225	aed	784	UAE Dirham
229	uyu	858	Peso Uruguayo
230	uyi	940	Uruguay Peso en Unidades Indexadas (UI)
231	uyw	927	Unidad Previsional
233	vuv	548	Vatu
234	ves	928	Bolívar Soberano
235	vnd	704	Dong
240	yer	886	Yemeni Rial
241	zmw	967	Zambian Kwacha
242	zwl	932	Zimbabwe Dollar
\.


--
-- Data for Name: custom_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.custom_item (custom_item_id, title, price) FROM stdin;
\.


--
-- Data for Name: customer_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_group (group_id, alias, price_id, created_at, deleted_at) FROM stdin;
1	retail_buyer	\N	2015-08-13 11:28:49.151814+00	\N
\.


--
-- Data for Name: customer_group_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.customer_group_text (group_id, lang_id, title) FROM stdin;
1	1	Розничный покупатель
\.


--
-- Data for Name: delivery; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery (delivery_id, alias, created_at, deleted_at, shipping_id, shipping_config, location_shipping_id, free_shipping_from, calc_method, img, status, created_by, tax, mark_up) FROM stdin;
20	\N	2016-07-13 15:56:36.032345+00	\N	2	{"address": "1 infinite loop, <br>Cupertino, CA 95014 <br>9:00am &mdash; 6:00pm"}	\N	\N	byShippingService	\N	published	\N	\N	\N
23	\N	2022-04-09 14:37:45.21814+00	\N	\N	{"price": 4.9}	\N	\N	single	\N	published	1	\N	\N
24	\N	2022-04-09 14:38:23.923214+00	\N	\N	{"price": 9.9}	\N	\N	single	\N	published	1	\N	\N
\.


--
-- Data for Name: delivery_city; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_city (delivery_city_id, delivery_site_id, city_id, rate) FROM stdin;
\.


--
-- Data for Name: delivery_city_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_city_text (delivery_city_id, lang_id, delivery_time) FROM stdin;
\.


--
-- Data for Name: delivery_country; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_country (delivery_country_id, delivery_site_id, country_id, all_city, rate) FROM stdin;
\.


--
-- Data for Name: delivery_country_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_country_text (delivery_country_id, lang_id, delivery_time) FROM stdin;
\.


--
-- Data for Name: delivery_exclude_city; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_exclude_city (delivery_site_id, city_id) FROM stdin;
\.


--
-- Data for Name: delivery_site; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_site (delivery_site_id, site_id, delivery_id, sort) FROM stdin;
20	1	20	20
24	1	23	30
25	1	24	40
\.


--
-- Data for Name: delivery_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.delivery_text (delivery_id, lang_id, title, description) FROM stdin;
20	1	Self-pickup from the store	\N
23	1	US Shipping	Fast shipping in 2-days. Promise!
24	1	Worldwide shipping	Your order will be fulfilled and sent to USPS in 1 day.
\.


--
-- Data for Name: essence; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.essence (essence_id, type, essence_local_id) FROM stdin;
\.


--
-- Data for Name: feeds; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.feeds (feed_id, title, type, conditions, is_protected, data, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: filter; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.filter (filter_id, title, is_default, created_at) FROM stdin;
9	Filter set for phone cases	t	2017-04-24 12:40:51.334168+00
\.


--
-- Data for Name: filter_field; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.filter_field (field_id, filter_id, type, characteristic_id, sort) FROM stdin;
45	9	price	\N	10
47	9	characteristic	152155	20
48	9	characteristic	152156	30
46	9	characteristic	152154	40
49	9	characteristic	152158	50
50	9	characteristic	152165	60
51	9	characteristic	152166	70
44	9	brand	\N	80
52	9	availability	\N	90
\.


--
-- Data for Name: final_price; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.final_price (point_id, item_id, price_id, currency_id, value, min, max, is_auto_generated, old, old_min, old_max) FROM stdin;
1	3566	8	4	6.00	\N	\N	t	\N	\N	\N
1	3567	7	4	9.90	\N	\N	t	12.99	\N	\N
1	3567	8	4	6.00	\N	\N	t	\N	\N	\N
1	3568	7	4	9.90	\N	\N	t	12.99	\N	\N
1	3568	8	4	6.00	\N	\N	t	\N	\N	\N
1	3569	7	4	9.90	\N	\N	t	12.99	\N	\N
1	3569	8	4	6.00	\N	\N	t	\N	\N	\N
1	3596	7	4	8.99	\N	\N	t	12.00	\N	\N
1	3597	7	4	8.99	\N	\N	t	12.00	\N	\N
1	3596	8	4	4.00	\N	\N	t	\N	\N	\N
1	3597	8	4	4.00	\N	\N	t	\N	\N	\N
1	3598	7	4	8.99	\N	\N	t	12.00	\N	\N
1	3598	8	4	4.00	\N	\N	t	\N	\N	\N
1	3599	7	4	8.99	\N	\N	t	12.00	\N	\N
1	3599	8	4	4.00	\N	\N	t	\N	\N	\N
1	3581	7	4	7.50	\N	\N	t	15.00	\N	\N
1	3582	7	4	7.50	\N	\N	t	15.00	\N	\N
1	3581	8	4	6.00	\N	\N	t	\N	\N	\N
1	3582	8	4	6.00	\N	\N	t	\N	\N	\N
1	3583	7	4	7.50	\N	\N	t	15.00	\N	\N
1	3583	8	4	6.00	\N	\N	t	\N	\N	\N
1	3584	7	4	7.50	\N	\N	t	15.00	\N	\N
1	3584	8	4	6.00	\N	\N	t	\N	\N	\N
1	3580	8	1	\N	6.00	6.00	t	\N	\N	\N
1	3611	7	4	9.99	\N	\N	t	12.99	\N	\N
1	3611	8	4	8.00	\N	\N	t	\N	\N	\N
1	3612	7	4	9.99	\N	\N	t	12.99	\N	\N
1	3612	8	4	8.00	\N	\N	t	\N	\N	\N
1	3613	7	4	9.99	\N	\N	t	12.99	\N	\N
1	3551	7	4	12.99	\N	\N	t	15.99	\N	\N
1	3551	8	4	8.00	\N	\N	t	\N	\N	\N
1	3552	7	4	12.99	\N	\N	t	15.99	\N	\N
1	3552	8	4	8.00	\N	\N	t	\N	\N	\N
1	3553	7	4	12.99	\N	\N	t	15.99	\N	\N
1	3553	8	4	8.00	\N	\N	t	\N	\N	\N
1	3554	7	4	12.99	\N	\N	t	15.99	\N	\N
1	3554	8	4	8.00	\N	\N	t	\N	\N	\N
1	3576	7	4	9.90	\N	\N	t	\N	\N	\N
1	3576	8	4	6.00	\N	\N	t	\N	\N	\N
1	3577	7	4	9.90	\N	\N	t	\N	\N	\N
1	3577	8	4	6.00	\N	\N	t	\N	\N	\N
1	3578	7	4	9.90	\N	\N	t	\N	\N	\N
1	3578	8	4	6.00	\N	\N	t	\N	\N	\N
1	3579	7	4	9.90	\N	\N	t	\N	\N	\N
1	3579	8	4	6.00	\N	\N	t	\N	\N	\N
1	3586	7	4	12.99	\N	\N	t	15.00	\N	\N
1	3587	7	4	12.99	\N	\N	t	15.00	\N	\N
1	3586	8	4	8.00	\N	\N	t	\N	\N	\N
1	3587	8	4	8.00	\N	\N	t	\N	\N	\N
1	3588	7	4	12.99	\N	\N	t	15.00	\N	\N
1	3588	8	4	8.00	\N	\N	t	\N	\N	\N
1	3589	7	4	12.99	\N	\N	t	15.00	\N	\N
1	3589	8	4	8.00	\N	\N	t	\N	\N	\N
1	3606	7	4	9.00	\N	\N	t	\N	\N	\N
1	3607	7	4	9.00	\N	\N	t	\N	\N	\N
1	3606	8	4	7.00	\N	\N	t	\N	\N	\N
1	3607	8	4	7.00	\N	\N	t	\N	\N	\N
1	3608	7	4	9.00	\N	\N	t	\N	\N	\N
1	3608	8	4	7.00	\N	\N	t	\N	\N	\N
1	3609	7	4	9.00	\N	\N	t	\N	\N	\N
1	3609	8	4	7.00	\N	\N	t	\N	\N	\N
1	3605	8	1	\N	7.00	7.00	t	\N	\N	\N
1	3591	7	4	9.95	\N	\N	t	\N	\N	\N
1	3591	8	4	6.95	\N	\N	t	\N	\N	\N
1	3592	7	4	9.95	\N	\N	t	\N	\N	\N
1	3592	8	4	6.95	\N	\N	t	\N	\N	\N
1	3593	7	4	9.95	\N	\N	t	\N	\N	\N
1	3593	8	4	6.95	\N	\N	t	\N	\N	\N
1	3594	7	4	9.95	\N	\N	t	\N	\N	\N
1	3594	8	4	6.95	\N	\N	t	\N	\N	\N
1	3561	7	4	8.50	\N	\N	t	\N	\N	\N
1	3562	7	4	8.50	\N	\N	t	\N	\N	\N
1	3561	8	4	6.00	\N	\N	t	\N	\N	\N
1	3562	8	4	6.00	\N	\N	t	\N	\N	\N
1	3563	7	4	8.50	\N	\N	t	\N	\N	\N
1	3563	8	4	6.00	\N	\N	t	\N	\N	\N
1	3564	7	4	8.50	\N	\N	t	\N	\N	\N
1	3564	8	4	6.00	\N	\N	t	\N	\N	\N
1	3560	8	1	\N	6.00	6.00	t	\N	\N	\N
1	3601	7	4	9.90	\N	\N	t	\N	\N	\N
1	3602	7	4	9.90	\N	\N	t	\N	\N	\N
1	3601	8	4	7.00	\N	\N	t	\N	\N	\N
1	3602	8	4	7.00	\N	\N	t	\N	\N	\N
1	3603	7	4	9.90	\N	\N	t	\N	\N	\N
1	3603	8	4	7.00	\N	\N	t	\N	\N	\N
1	3604	7	4	9.90	\N	\N	t	\N	\N	\N
1	3604	8	4	7.00	\N	\N	t	\N	\N	\N
1	3600	8	1	\N	7.00	7.00	t	\N	\N	\N
1	3547	7	4	9.00	\N	\N	t	14.00	\N	\N
1	3548	7	4	9.00	\N	\N	t	14.00	\N	\N
1	3547	8	4	7.00	\N	\N	t	\N	\N	\N
1	3548	8	4	7.00	\N	\N	t	\N	\N	\N
1	3549	7	4	9.00	\N	\N	t	14.00	\N	\N
1	3549	8	4	7.00	\N	\N	t	\N	\N	\N
1	3550	7	4	9.00	\N	\N	t	14.00	\N	\N
1	3550	8	4	7.00	\N	\N	t	\N	\N	\N
1	3545	8	1	500.00	7.00	7.00	t	\N	\N	\N
1	3556	7	4	7.00	\N	\N	t	9.00	\N	\N
1	3557	7	4	7.00	\N	\N	t	9.00	\N	\N
1	3556	8	4	6.00	\N	\N	t	\N	\N	\N
1	3557	8	4	6.00	\N	\N	t	\N	\N	\N
1	3558	7	4	7.00	\N	\N	t	9.00	\N	\N
1	3558	8	4	6.00	\N	\N	t	\N	\N	\N
1	3559	7	4	7.00	\N	\N	t	9.00	\N	\N
1	3559	8	4	6.00	\N	\N	t	\N	\N	\N
1	3555	8	1	\N	6.00	6.00	t	\N	\N	\N
1	3648	8	4	12.00	\N	\N	t	\N	\N	\N
1	3649	8	4	12.00	\N	\N	t	\N	\N	\N
1	3648	7	4	25.99	\N	\N	t	\N	\N	\N
1	3649	7	4	25.00	\N	\N	t	\N	\N	\N
1	3636	7	4	13.00	\N	\N	t	\N	\N	\N
1	3647	8	4	5.00	\N	\N	t	\N	\N	\N
1	3651	7	4	39.90	\N	\N	t	\N	\N	\N
1	3651	8	4	15.00	\N	\N	t	\N	\N	\N
1	3644	8	1	\N	5.00	8.95	t	\N	\N	\N
1	3644	7	1	\N	12.00	12.00	t	\N	\N	\N
1	3636	8	4	5.00	\N	\N	t	\N	\N	\N
1	3632	8	1	\N	5.00	9.95	t	\N	\N	\N
1	3632	7	1	\N	13.00	14.80	t	\N	\N	\N
1	3645	7	4	12.00	\N	\N	t	\N	\N	\N
1	3638	7	4	12.90	\N	\N	t	\N	\N	\N
1	3633	7	4	9.99	\N	\N	t	12.99	\N	\N
1	3633	8	4	7.00	\N	\N	t	\N	\N	\N
1	3642	7	4	14.99	\N	\N	t	18.99	\N	\N
1	3580	7	1	\N	7.50	7.50	t	\N	15.00	15.00
1	3645	8	4	8.95	\N	\N	t	\N	\N	\N
1	3634	7	4	8.99	\N	\N	t	11.99	\N	\N
1	3634	8	4	6.00	\N	\N	t	\N	\N	\N
1	3631	8	1	500.00	6.00	7.00	t	\N	\N	\N
1	3631	7	1	1000.00	8.99	9.99	t	\N	11.99	12.99
1	3635	7	4	14.80	\N	\N	t	\N	\N	\N
1	3624	8	4	9.00	\N	\N	t	\N	\N	\N
1	3638	8	4	7.00	\N	\N	t	\N	\N	\N
1	3565	8	1	\N	6.00	6.00	t	\N	\N	\N
1	3635	8	4	9.95	\N	\N	t	\N	\N	\N
1	3565	7	1	\N	9.90	9.90	t	\N	12.99	12.99
1	3642	8	4	10.00	\N	\N	t	\N	\N	\N
1	3646	7	4	12.00	\N	\N	t	\N	\N	\N
1	3639	7	4	12.90	\N	\N	t	\N	\N	\N
1	3595	8	1	\N	4.00	4.00	t	\N	\N	\N
1	3595	7	1	\N	8.99	8.99	t	\N	12.00	12.00
1	3646	8	4	8.00	\N	\N	t	\N	\N	\N
1	3639	8	4	6.00	\N	\N	t	\N	\N	\N
1	3637	8	1	\N	6.00	7.00	t	\N	\N	\N
1	3637	7	1	\N	12.90	12.90	t	\N	\N	\N
1	3613	8	4	8.00	\N	\N	t	\N	\N	\N
1	3647	7	4	12.00	\N	\N	t	\N	\N	\N
1	3643	7	4	14.99	\N	\N	t	18.99	\N	\N
1	3626	7	4	15.00	\N	\N	t	\N	\N	\N
1	3616	8	4	7.00	\N	\N	t	\N	\N	\N
1	3618	7	4	14.90	\N	\N	t	15.90	\N	\N
1	3643	8	4	10.00	\N	\N	t	\N	\N	\N
1	3640	8	1	\N	10.00	10.00	t	\N	\N	\N
1	3621	7	4	14.99	\N	\N	t	16.00	\N	\N
1	3640	7	1	\N	14.99	14.99	t	\N	18.99	18.99
1	3614	7	4	9.99	\N	\N	t	12.99	\N	\N
1	3641	7	4	14.99	\N	\N	t	18.99	\N	\N
1	3641	8	4	10.00	\N	\N	t	\N	\N	\N
1	3566	7	4	9.90	\N	\N	t	12.99	\N	\N
1	3575	8	1	\N	6.00	6.00	t	\N	\N	\N
1	3575	7	1	\N	9.90	9.90	t	\N	\N	\N
1	3625	7	4	15.00	\N	\N	t	\N	\N	\N
1	3614	8	4	8.00	\N	\N	t	\N	\N	\N
1	3626	8	4	9.00	\N	\N	t	\N	\N	\N
1	3610	8	1	\N	8.00	8.00	t	\N	\N	\N
1	3610	7	1	\N	9.99	9.99	t	\N	12.99	12.99
1	3546	8	1	500.00	8.00	8.00	t	\N	\N	\N
1	3546	7	1	900.00	12.99	12.99	t	\N	15.99	15.99
1	3623	8	1	\N	9.00	9.00	t	\N	\N	\N
1	3623	7	1	\N	15.00	15.00	t	\N	\N	\N
1	3622	7	4	14.99	\N	\N	t	16.00	\N	\N
1	3585	8	1	\N	8.00	8.00	t	\N	\N	\N
1	3605	7	1	\N	9.00	9.00	t	\N	\N	\N
1	3624	7	4	15.00	\N	\N	t	\N	\N	\N
1	3585	7	1	\N	12.99	12.99	t	\N	15.00	15.00
1	3625	8	4	9.00	\N	\N	t	\N	\N	\N
1	3590	8	1	\N	6.95	6.95	t	\N	\N	\N
1	3590	7	1	\N	9.95	9.95	t	\N	\N	\N
1	3545	7	1	900.00	9.00	9.00	t	\N	14.00	14.00
1	3617	7	4	14.90	\N	\N	t	15.90	\N	\N
1	3618	8	4	7.00	\N	\N	t	\N	\N	\N
1	3600	7	1	\N	9.90	9.90	t	\N	\N	\N
1	3616	7	4	14.90	\N	\N	t	15.90	\N	\N
1	3615	8	1	\N	7.00	7.00	t	\N	\N	\N
1	3560	7	1	\N	8.50	8.50	t	\N	\N	\N
1	3615	7	1	\N	14.90	14.90	t	\N	15.90	15.90
1	3620	7	4	14.99	\N	\N	t	16.00	\N	\N
1	3629	7	4	14.99	\N	\N	t	18.99	\N	\N
1	3630	7	4	14.99	\N	\N	t	18.99	\N	\N
1	3617	8	4	7.00	\N	\N	t	\N	\N	\N
1	3555	7	1	\N	7.00	7.00	t	\N	9.00	9.00
1	3620	8	4	8.00	\N	\N	t	\N	\N	\N
1	3621	8	4	8.00	\N	\N	t	\N	\N	\N
1	3622	8	4	8.00	\N	\N	t	\N	\N	\N
1	3628	7	4	14.99	\N	\N	t	18.99	\N	\N
1	3619	8	1	\N	8.00	8.00	t	\N	\N	\N
1	3619	7	1	\N	14.99	14.99	t	\N	16.00	16.00
1	3650	7	4	45.00	\N	\N	t	\N	\N	\N
1	3650	8	4	20.00	\N	\N	t	\N	\N	\N
1	3628	8	4	10.00	\N	\N	t	\N	\N	\N
1	3629	8	4	10.00	\N	\N	t	\N	\N	\N
1	3630	8	4	10.00	\N	\N	t	\N	\N	\N
1	3627	8	1	\N	10.00	10.00	t	\N	\N	\N
1	3627	7	1	\N	14.99	14.99	t	\N	18.99	18.99
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.image (image_id, site_id, lang_id, name, size, path, width, height, used_in, created_at, deleted_at, mime_type) FROM stdin;
206	1	1	photo.jpeg	50808	images/76/cd/a3f369097570c9a1dea6f8333803.jpeg	511	512	{manufacturer}	2017-04-23 10:03:56.267024+00	\N	image/jpeg
207	1	1	loveMei.png	62057	images/d4/71/70901570ccfdd55ceef9d66508f9.png	511	391	{manufacturer}	2017-04-23 10:05:15.180751+00	\N	image/png
208	1	1	spigen.png	4130	images/a6/6d/b439f0c671af28330ffc76f4ee01.png	464	102	{manufacturer}	2017-04-23 10:06:08.158402+00	\N	image/png
209	1	1	anymode_large.jpeg	15092	images/90/9d/0ebaa202ce868ecafb2f4d2ed9a3.jpeg	480	172	{manufacturer}	2017-04-23 10:06:56.761346+00	\N	image/jpeg
210	1	1	elementcase_logo_100H.png	8739	images/ae/7d/8a78a1f5f51504181d4780888f1a.png	478	100	{manufacturer}	2017-04-23 10:08:34.686971+00	\N	image/png
211	1	1	3a.jpeg	732245	images/3d/cc/5b4d9f48f71b958c7b4fa850bb0c.jpeg	886	1501	{product}	2017-04-23 10:12:39.445187+00	\N	image/jpeg
212	1	1	3a.jpeg	771915	images/3f/cb/2da8b3d892b069a64f76b48560dd.jpeg	1501	1501	{product}	2017-04-23 10:26:04.866256+00	\N	image/jpeg
213	1	1	3b.jpeg	260254	images/71/48/4bcc3d63eaf65eb4b65e904a904d.jpeg	1051	1051	{product}	2017-04-23 10:28:42.404453+00	\N	image/jpeg
214	1	1	06a3e83c1ff66bba74e6c42a0079b140.jpeg	601253	images/77/a6/f116626e0b649cbfd2d4f6652ca5.jpeg	1501	1501	{product}	2017-04-24 06:47:10.516197+00	\N	image/jpeg
215	1	1	0fdf6ec1a223b83fe2e8115e00555f3c.jpeg	243805	images/66/19/1ebf20697aeb0d43716500b1291c.jpeg	1051	1051	{product}	2017-04-24 06:47:14.757518+00	\N	image/jpeg
216	1	1	2ae6cb902eb13498090de8fd4e417f18.jpeg	518686	images/6f/ad/eb339bb1b4c994fb9384a25ad494.jpeg	1501	1501	{product}	2017-04-24 06:57:28.340605+00	\N	image/jpeg
217	1	1	ee65c585d4ac2efd901260dce36b6618.jpeg	159089	images/60/2b/128a6f53e723b243109d5f8c941a.jpeg	1051	1051	{product}	2017-04-24 06:57:32.998558+00	\N	image/jpeg
218	1	1	7a.jpeg	775315	images/ea/61/d9ade852ee5027185bb0c9b3d786.jpeg	1501	1501	{product}	2017-04-24 07:33:44.77924+00	\N	image/jpeg
219	1	1	7b.jpeg	233103	images/56/56/f04d1fe7242cb61b8ffdd05caf0f.jpeg	1051	1051	{product}	2017-04-24 07:33:58.491612+00	\N	image/jpeg
220	1	1	7f12e00b8169839a13b743237d742a86.jpeg	802632	images/e8/11/0e121a813117f0cee6b518eb790d.jpeg	1501	1501	{product}	2017-04-24 07:39:13.50331+00	\N	image/jpeg
221	1	1	eb33cf5f7a91534045e0c3f89fe8ba76.jpeg	254979	images/02/96/263b9fbc82877f7bb73e09c5966d.jpeg	1051	1051	{product}	2017-04-24 07:39:24.085374+00	\N	image/jpeg
224	1	1	19b.jpeg	226935	images/61/23/e68dc959ad6d1165d9c7d57f40b9.jpeg	1051	1051	{product}	2017-04-24 07:45:26.616584+00	\N	image/jpeg
225	1	1	19a.jpeg	359985	images/c4/b6/398ed7ba4334cf657e7de12486d3.jpeg	1501	1501	{product}	2017-04-24 07:45:26.657155+00	\N	image/jpeg
226	1	1	21b.jpeg	90581	images/19/8a/edc71f630f689a1b40cc2f01dcd0.jpeg	1051	1051	{product}	2017-04-24 07:52:01.6925+00	\N	image/jpeg
227	1	1	21a.jpeg	231669	images/26/0e/7b0f95f7e69ea79069aca4d613df.jpeg	1501	1501	{product}	2017-04-24 07:52:01.83198+00	\N	image/jpeg
228	1	1	22b.jpeg	107638	images/5b/8c/d52ec924457a48cac3c8534c659d.jpeg	1051	1051	{product}	2017-04-24 07:54:32.024297+00	\N	image/jpeg
229	1	1	22a.jpeg	301576	images/2d/df/34781b8456ab97fa501023d2db92.jpeg	1501	1501	{product}	2017-04-24 07:54:32.173728+00	\N	image/jpeg
230	1	1	79258de58806089c9aa2ba6bf80097ff.jpeg	205024	images/d3/c8/bec562f274498c47674d8750ed4c.jpeg	1051	1051	{product}	2017-04-24 07:59:37.942968+00	\N	image/jpeg
231	1	1	28ad50a64213046001ca3dbe76025f70.jpeg	648224	images/b7/2f/8c939b27fb115f47b30b517f922e.jpeg	1501	1501	{product}	2017-04-24 07:59:38.05397+00	\N	image/jpeg
232	1	1	764aacdf5744e92ea6bd0ae94100c711.jpeg	189427	images/49/54/c4db23339fc41237bab64127ff69.jpeg	1051	1051	{product}	2017-04-24 08:02:34.028832+00	\N	image/jpeg
233	1	1	d92a4288c09fd1736a3c5c8e17edbc14.jpeg	589437	images/42/8c/fc30842678a18574925d97e9aa91.jpeg	1501	1501	{product}	2017-04-24 08:02:34.254748+00	\N	image/jpeg
234	1	1	bca370169affeaefb6528b7b10091727.jpeg	173766	images/02/17/5771ce0840b4c8e951588a6b75d7.jpeg	1051	1051	{product}	2017-04-24 08:08:27.038374+00	\N	image/jpeg
235	1	1	d0e63bba7f7279e2cdc95d87766505ba.jpeg	472146	images/7b/82/4682f2e114c341d6779122ce1fa9.jpeg	1501	1501	{product}	2017-04-24 08:08:27.173319+00	\N	image/jpeg
236	1	1	c8b988fd10f85a58a7d0876f712506c9.jpeg	502593	images/b8/7b/5bf852662576ad0acf1e1166e168.jpeg	1501	1501	{product}	2017-04-24 08:11:26.266517+00	\N	image/jpeg
237	1	1	d44dbd21b0ea39c58ff2240e6c15f343.jpeg	745794	images/80/3f/8f005e32857ffbf182c58eb009b9.jpeg	1501	1501	{product}	2017-04-24 08:13:24.879455+00	\N	image/jpeg
239	1	1	5b.jpeg	23984	images/57/8c/d426badc8b80dfa7d4812e1e1765.jpeg	600	600	{product}	2017-04-24 09:37:30.876+00	\N	image/jpeg
238	1	1	5a.jpeg	16397	images/f6/ad/44f434c1a3817224482a15cce8b7.jpeg	600	600	{product}	2017-04-24 09:37:30.875837+00	\N	image/jpeg
240	1	1	5b.jpeg	23984	images/4c/cd/654dea365ec72d048b890afe42c4.jpeg	600	600	{product}	2017-04-24 09:37:40.451103+00	\N	image/jpeg
241	1	1	4b.jpeg	16296	images/48/08/21b56959f683ebe3f4edc122bd47.jpeg	600	600	{product}	2017-04-24 09:43:39.261778+00	\N	image/jpeg
242	1	1	4a.jpeg	18241	images/73/3c/48f8016e3ad220cad8e755af8c26.jpeg	600	600	{product}	2017-04-24 09:43:39.262845+00	\N	image/jpeg
243	1	1	4a.jpeg	18241	images/be/ac/65424993485e2d022a3502d76b7f.jpeg	600	600	{product}	2017-04-24 09:45:59.083872+00	\N	image/jpeg
244	1	1	4b.jpeg	16296	images/6f/80/e3b5a636546295f8f42a5555d91e.jpeg	600	600	{product}	2017-04-24 09:52:37.216203+00	\N	image/jpeg
245	1	1	4a.jpeg	18241	images/10/57/921575eccde8433334a79992a165.jpeg	600	600	{product}	2017-04-24 09:52:37.294093+00	\N	image/jpeg
246	1	1	3b.jpeg	23582	images/0f/ea/50c905a15c758952b2730e8863ca.jpeg	600	600	{product}	2017-04-24 09:52:38.069058+00	\N	image/jpeg
247	1	1	3a.jpeg	18376	images/df/97/152eb928b2047f4fc8cf2353ba2a.jpeg	600	600	{product}	2017-04-24 09:59:12.309054+00	\N	image/jpeg
248	1	1	3b.jpeg	23582	images/c7/27/692be3c08f9fa06b369badd0c398.jpeg	600	600	{product}	2017-04-24 09:59:12.3131+00	\N	image/jpeg
249	1	1	5b.jpeg	23984	images/12/a6/312a3ab7ba084c8fe6bf00655dc4.jpeg	600	600	{product}	2017-04-24 09:59:14.651377+00	\N	image/jpeg
250	1	1	5a.jpeg	16397	images/4e/6b/6e25a96c32d47de7ef60ad08cbdf.jpeg	600	600	{product}	2017-04-24 09:59:14.75288+00	\N	image/jpeg
251	1	1	4b.jpeg	16296	images/92/13/a7edff1ee56e457f4a23bafe3cb2.jpeg	600	600	{product}	2017-04-24 10:05:20.633322+00	\N	image/jpeg
252	1	1	4a.jpeg	18241	images/31/2c/0f8cde74adeeec262de936d7ac2b.jpeg	600	600	{product}	2017-04-24 10:05:22.917097+00	\N	image/jpeg
253	1	1	3b.jpeg	23582	images/16/76/534727b4683cdce487c634e3f913.jpeg	600	600	{product}	2017-04-24 10:05:25.171416+00	\N	image/jpeg
254	1	1	3a.jpeg	18376	images/1d/56/6e27d93dae997a0122379806de15.jpeg	600	600	{product}	2017-04-24 10:05:27.387977+00	\N	image/jpeg
255	1	1	5b.jpeg	23984	images/63/ec/c58485e36302253dbea5f1f4ac14.jpeg	600	600	{product}	2017-04-24 10:05:29.601992+00	\N	image/jpeg
256	1	1	3b.jpeg	23582	images/2e/82/1f3fb49e832792aaadbf7031490a.jpeg	600	600	{product}	2017-04-24 10:21:45.731153+00	\N	image/jpeg
257	1	1	3a.jpeg	18376	images/d7/cf/2a294d7108fd8f1cd13b147af962.jpeg	600	600	{product}	2017-04-24 10:21:46.14196+00	\N	image/jpeg
258	1	1	1b.jpeg	18877	images/c2/ca/7e93a3a34b1fb67347ad16501eb5.jpeg	600	600	{product}	2017-04-24 10:28:51.345359+00	\N	image/jpeg
259	1	1	1a.jpeg	24229	images/45/e8/a4d2e72bf9d9202e02de7a4f6777.jpeg	600	600	{product}	2017-04-24 10:28:51.755427+00	\N	image/jpeg
260	1	1	hq.jpeg	33994	images/5c/86/16c8af9ea61552b6cbe56042a1bc.jpeg	504	504	{product}	2017-04-24 10:40:20.958227+00	\N	image/jpeg
261	1	1	hq2.jpeg	31007	images/8a/74/6ed0ae9af5475628b8b7018f0e9c.jpeg	504	504	{product}	2017-04-24 10:40:21.275582+00	\N	image/jpeg
262	1	1	hq3.jpeg	33961	images/31/dd/3e993f91a5af1846dbf21e82e271.jpeg	504	504	{product}	2017-04-24 10:40:21.538861+00	\N	image/jpeg
263	1	1	hq4.jpeg	81624	images/31/f7/cca18e7b2e09e2c350b916e1d03e.jpeg	725	725	{product}	2017-04-24 10:42:28.2018+00	\N	image/jpeg
264	1	1	hq41.jpeg	140017	images/3b/04/0ffc13555443cd3956b8ef04b76b.jpeg	759	759	{product}	2017-04-24 10:42:28.494222+00	\N	image/jpeg
265	1	1	hq42.jpeg	154239	images/18/a3/d552150b25e778727618995eccb8.jpeg	772	772	{product}	2017-04-24 10:42:28.757275+00	\N	image/jpeg
266	1	1	hq51.jpeg	33836	images/2a/9a/91344c994d33f23cea1787fd1528.jpeg	504	504	{product}	2017-04-24 10:45:23.727916+00	\N	image/jpeg
267	1	1	hq52.jpeg	32500	images/67/0d/e0681b7fd131446ac9c4d30ae2cc.jpeg	504	504	{product}	2017-04-24 10:45:23.958087+00	\N	image/jpeg
268	1	1	hq53.jpeg	58484	images/6e/48/8f7a4014228a5f188f7b74d7f1d2.jpeg	504	504	{product}	2017-04-24 10:45:24.202105+00	\N	image/jpeg
269	1	1	hq61.jpeg	78624	images/7b/f7/1ccd3ea235093d00f731c4f3920b.jpeg	725	725	{product}	2017-04-24 10:47:45.134874+00	\N	image/jpeg
270	1	1	hq62.jpeg	74671	images/e2/15/9bb81c482dc6f537f855662226de.jpeg	725	725	{product}	2017-04-24 10:47:45.431335+00	\N	image/jpeg
271	1	1	hq63.jpeg	53335	images/c8/9d/a379b2cd739fb514e0f171734650.jpeg	725	725	{product}	2017-04-24 10:47:45.692941+00	\N	image/jpeg
272	1	1	hq71.jpeg	197044	images/3e/08/b005a99a6abeb6739765cbfeaf9a.jpeg	725	725	{product}	2017-04-24 10:49:48.95311+00	\N	image/jpeg
273	1	1	hq72.jpeg	192066	images/e9/ad/e8f92cb3ec505d76c59b76affab9.jpeg	815	815	{product}	2017-04-24 10:49:49.260423+00	\N	image/jpeg
274	1	1	hq73.jpeg	189214	images/c4/17/ec6f041a20decd9e1f0022024faf.jpeg	767	767	{product}	2017-04-24 10:49:49.532659+00	\N	image/jpeg
275	1	1	hq7.jpeg	143000	images/b0/f1/2001d76be00a6f8d0adfb70b018b.jpeg	372	725	{product}	2017-04-24 10:49:49.760219+00	\N	image/jpeg
276	1	1	hq.jpeg	81507	images/93/e5/6d76b691b30f877b533cda65cb56.jpeg	725	725	{product}	2017-04-24 12:08:59.492252+00	\N	image/jpeg
277	1	1	hq11.jpeg	122403	images/dd/c7/1c9d8c3faa9bddd2a6956696a9c3.jpeg	725	725	{product}	2017-04-24 12:08:59.850276+00	\N	image/jpeg
278	1	1	hq12.jpeg	120030	images/81/de/554e1e25ee02a156fd33a8ac1ae2.jpeg	725	725	{product}	2017-04-24 12:09:00.158735+00	\N	image/jpeg
279	1	1	hq21.jpeg	83358	images/bd/56/286e3d68096052756e4cc209adcf.jpeg	725	725	{product}	2017-04-24 12:12:48.251383+00	\N	image/jpeg
280	1	1	hq22.jpeg	126651	images/fe/47/748a6ce872cfaacacd579fcae3a8.jpeg	725	725	{product}	2017-04-24 12:12:48.554341+00	\N	image/jpeg
281	1	1	hq23.jpeg	110238	images/70/da/edd94f183d954a9f407b69e39619.jpeg	725	725	{product}	2017-04-24 12:12:48.852902+00	\N	image/jpeg
282	1	1	hq31.jpeg	69279	images/6b/22/e2a813547476d03afb9aedba4780.jpeg	725	725	{product}	2017-04-24 12:15:56.495499+00	\N	image/jpeg
283	1	1	hq32.jpeg	118467	images/a1/ae/ace20b14fe947ff13822f97a82ac.jpeg	725	725	{product}	2017-04-24 12:15:56.882122+00	\N	image/jpeg
284	1	1	hq33.jpeg	239740	images/7a/d7/4c521a00abcbb3c33578fb23b0e8.jpeg	870	870	{product}	2017-04-24 12:15:57.514801+00	\N	image/jpeg
285	1	1	hq51.jpeg	97518	images/c6/1e/dc031b19981275880fabf2346fb3.jpeg	725	725	{product}	2017-04-24 12:30:21.625065+00	\N	image/jpeg
286	1	1	hq52.jpeg	133200	images/f0/88/10c3a350940b6b48e9ba5bcef38b.jpeg	725	725	{product}	2017-04-24 12:30:22.009574+00	\N	image/jpeg
287	1	1	hq53.jpeg	144351	images/31/18/bcea09082a820b2425eca7a882be.jpeg	861	861	{product}	2017-04-24 12:30:22.369914+00	\N	image/jpeg
288	1	1	caseWithMobile.jpg	152628	images/93/31/764b5531e19e4804eeed3bea38a9.jpg	1280	450	{carousel}	2017-04-24 13:21:31.792132+00	\N	image/jpeg
289	1	1	newColorCases.jpg	68047	images/86/f0/7e37896d55dc3cb1c93a54e7206a.jpg	1280	440	{carousel}	2017-04-24 13:31:59.018403+00	\N	image/jpeg
290	1	1	phoneInCase.jpg	85945	images/96/93/0363828ff2066d2723e5e34d03e0.jpg	1140	400	{carousel}	2017-04-24 13:49:34.625372+00	\N	image/jpeg
291	1	1	2c596b28cf82f0ac35003f6f2f81.jpg	93970	instagram/67/66/2c596b28cf82f0ac35003f6f2f81.jpg	640	640	{instagram}	2017-04-24 15:09:50.192627+00	\N	image/jpeg
292	1	1	1651d86524d14b6dc5a7fc74db36.jpg	69649	instagram/03/cb/1651d86524d14b6dc5a7fc74db36.jpg	640	640	{instagram}	2017-04-24 15:09:52.304631+00	\N	image/jpeg
293	1	1	3bf933f00e5fd83a7bdfb2064125.jpg	34190	instagram/8e/5a/3bf933f00e5fd83a7bdfb2064125.jpg	640	640	{instagram}	2017-04-24 15:09:53.027842+00	\N	image/jpeg
294	1	1	32062b7c760695f22a0db7751930.jpg	82291	instagram/52/82/32062b7c760695f22a0db7751930.jpg	640	640	{instagram}	2017-04-24 15:09:53.91309+00	\N	image/jpeg
295	1	1	d511eb3db18ac3805c8e16d18963.jpg	27776	instagram/34/70/d511eb3db18ac3805c8e16d18963.jpg	640	640	{instagram}	2017-04-24 15:09:54.589475+00	\N	image/jpeg
296	1	1	c370477f0fcd5fb5d3b96e308cb8.jpg	23530	instagram/70/b7/c370477f0fcd5fb5d3b96e308cb8.jpg	640	640	{instagram}	2017-04-24 15:09:55.391902+00	\N	image/jpeg
297	1	1	f56693a5ea0398364bc3b7b22250.jpg	46800	instagram/4f/ab/f56693a5ea0398364bc3b7b22250.jpg	640	640	{instagram}	2017-04-24 15:09:56.282432+00	\N	image/jpeg
298	1	1	516531457.jpg	600924	images/95/c5/ba26f567bd0b4ca4dd221d209c95.jpg	1000	667	{blog}	2017-11-14 14:30:21.393266+00	\N	image/jpeg
299	1	1	516531458.jpg	460494	images/ed/32/1d24cbddcc136b50995b1b5df9d2.jpg	3987	3987	{blog}	2017-11-14 14:30:21.403689+00	\N	image/jpeg
300	1	1	516531458.jpg	472162	images/26/6c/651e776ff0660df6cb30db3af84e.jpg	1000	625	{blog}	2017-11-14 14:30:21.416439+00	\N	image/jpeg
\.


--
-- Data for Name: image_tag; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.image_tag (image_tag_id, title) FROM stdin;
\.


--
-- Data for Name: image_tag_rel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.image_tag_rel (image_tag_id, product_image_id) FROM stdin;
\.


--
-- Data for Name: inventory_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_item (item_id, product_id, variant_id, available_qty, reserved_qty, custom_item_id) FROM stdin;
3623	171	\N	0	0	\N
3546	156	\N	0	0	\N
3545	155	\N	0	0	\N
3555	157	\N	0	0	\N
3560	158	\N	0	0	\N
3565	159	\N	0	0	\N
3575	161	\N	0	0	\N
3580	162	\N	0	0	\N
3585	163	\N	0	0	\N
3590	164	\N	0	0	\N
3595	165	\N	0	0	\N
3600	166	\N	0	0	\N
3605	167	\N	0	0	\N
3610	168	\N	0	0	\N
3615	169	\N	0	0	\N
3619	170	\N	0	0	\N
3627	172	\N	0	0	\N
3631	173	\N	0	0	\N
3632	174	\N	0	0	\N
3637	175	\N	0	0	\N
3640	176	\N	0	0	\N
3644	177	\N	0	0	\N
3633	\N	1276	19	0	\N
3634	\N	1277	19	0	\N
3635	\N	1278	25	0	\N
3636	\N	1279	10	0	\N
3645	\N	1285	20	0	\N
3638	\N	1280	100	0	\N
3586	\N	1240	10	0	\N
3587	\N	1241	10	0	\N
3588	\N	1242	10	0	\N
3589	\N	1243	10	0	\N
3624	\N	1270	10	0	\N
3625	\N	1271	10	0	\N
3626	\N	1272	10	0	\N
3591	\N	1244	30	0	\N
3592	\N	1245	30	0	\N
3593	\N	1246	30	0	\N
3594	\N	1247	30	0	\N
3561	\N	1220	10	0	\N
3562	\N	1221	10	0	\N
3563	\N	1222	10	0	\N
3564	\N	1223	10	0	\N
3601	\N	1252	10	0	\N
3602	\N	1253	10	0	\N
3603	\N	1254	10	0	\N
3604	\N	1255	10	0	\N
3616	\N	1264	10	0	\N
3617	\N	1265	10	0	\N
3618	\N	1266	10	0	\N
3547	\N	1208	15	0	\N
3639	\N	1281	100	0	\N
3548	\N	1209	15	0	\N
3549	\N	1210	15	0	\N
3550	\N	1211	15	0	\N
3556	\N	1216	20	0	\N
3557	\N	1217	20	0	\N
3558	\N	1218	20	0	\N
3559	\N	1219	20	0	\N
3651	181	\N	20	0	\N
3646	\N	1286	15	0	\N
3647	\N	1287	20	0	\N
3650	180	\N	20	0	\N
3648	178	\N	25	0	\N
3649	179	\N	20	0	\N
3579	\N	1235	10	0	\N
3606	\N	1256	0	0	\N
3607	\N	1257	0	0	\N
3608	\N	1258	0	0	\N
3609	\N	1259	0	0	\N
3642	\N	1283	15	0	\N
3643	\N	1284	15	0	\N
3641	\N	1282	15	0	\N
3566	\N	1224	10	0	\N
3620	\N	1267	10	0	\N
3567	\N	1225	10	0	\N
3568	\N	1226	10	0	\N
3621	\N	1268	10	0	\N
3569	\N	1227	10	0	\N
3596	\N	1248	10	0	\N
3622	\N	1269	10	0	\N
3597	\N	1249	10	0	\N
3598	\N	1250	10	0	\N
3599	\N	1251	10	0	\N
3581	\N	1236	10	0	\N
3582	\N	1237	10	0	\N
3583	\N	1238	10	0	\N
3628	\N	1273	10	0	\N
3584	\N	1239	10	0	\N
3611	\N	1260	14	0	\N
3629	\N	1274	10	0	\N
3612	\N	1261	14	0	\N
3613	\N	1262	14	0	\N
3630	\N	1275	10	0	\N
3614	\N	1263	14	0	\N
3551	\N	1212	0	0	\N
3552	\N	1213	0	0	\N
3553	\N	1214	0	0	\N
3554	\N	1215	0	0	\N
3576	\N	1232	10	0	\N
3577	\N	1233	10	0	\N
3578	\N	1234	10	0	\N
\.


--
-- Data for Name: inventory_location; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_location (location_id, warehouse_id) FROM stdin;
1123	14
1124	15
\.


--
-- Data for Name: inventory_movement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_movement (movement_id, reason_id, person_id, reserve_id, props, notes, ts, order_id) FROM stdin;
1361	1	1	\N	\N	\N	2017-04-24 12:30:49.448267+00	\N
1360	1	1	\N	\N	\N	2017-04-24 12:16:11.413258+00	\N
1359	1	1	\N	\N	\N	2017-04-24 12:13:15.82644+00	\N
1358	1	1	\N	\N	\N	2017-04-24 12:10:48.526904+00	\N
1357	1	1	\N	\N	\N	2017-04-24 10:51:36.546667+00	\N
1356	1	1	\N	\N	\N	2017-04-24 10:48:18.32498+00	\N
1355	1	1	\N	\N	\N	2017-04-24 10:45:57.766122+00	\N
1354	1	1	\N	\N	\N	2017-04-24 10:43:37.066156+00	\N
1353	1	1	\N	\N	\N	2017-04-24 10:43:17.856515+00	\N
1352	1	1	\N	\N	\N	2017-04-24 10:29:15.432326+00	\N
1350	1	1	\N	\N	\N	2017-04-24 10:22:13.11671+00	\N
1349	1	1	\N	\N	\N	2017-04-24 10:15:20.204327+00	\N
1348	1	1	\N	\N	\N	2017-04-24 09:40:39.572957+00	\N
1347	1	1	\N	\N	\N	2017-04-24 08:13:48.165807+00	\N
1346	1	1	\N	\N	\N	2017-04-24 08:11:57.414682+00	\N
1345	1	1	\N	\N	\N	2017-04-24 08:09:02.428171+00	\N
1344	1	1	\N	\N	\N	2017-04-24 08:03:25.785189+00	\N
1343	1	1	\N	\N	\N	2017-04-24 08:00:03.119791+00	\N
1342	1	1	\N	\N	\N	2017-04-24 07:54:57.679747+00	\N
1341	1	1	\N	\N	\N	2017-04-24 07:52:28.286012+00	\N
1339	1	1	\N	\N	\N	2017-04-24 07:45:56.912124+00	\N
1338	1	1	\N	\N	\N	2017-04-24 07:41:59.431296+00	\N
1337	1	1	\N	\N	\N	2017-04-24 07:39:49.615217+00	\N
1336	1	1	\N	\N	\N	2017-04-24 07:36:17.055663+00	\N
1335	1	1	\N	\N	\N	2017-04-24 06:56:58.631735+00	\N
1334	1	1	\N	\N	\N	2017-04-24 06:53:45.374558+00	\N
1333	1	1	\N	\N	\N	2017-04-24 06:53:12.905795+00	\N
1332	1	1	\N	\N	\N	2017-04-23 10:35:27.123132+00	\N
1362	10	1	\N	\N	\N	2022-03-26 09:54:13.058452+00	\N
1364	10	1	\N	\N	\N	2022-03-26 09:59:23.55158+00	\N
1365	10	1	\N	\N	\N	2022-03-26 09:59:26.088801+00	\N
1368	10	1	\N	\N	\N	2022-03-26 10:06:02.604322+00	\N
1369	10	1	\N	\N	\N	2022-03-26 10:06:23.47843+00	\N
1370	10	1	\N	\N	\N	2022-03-26 10:07:21.97008+00	\N
1371	10	1	\N	\N	\N	2022-03-26 10:07:32.197357+00	\N
1372	10	1	\N	\N	\N	2022-03-26 10:07:42.839471+00	\N
1373	10	1	\N	\N	\N	2022-03-26 10:08:57.388381+00	\N
1374	10	1	\N	\N	\N	2022-03-26 10:09:07.847505+00	\N
1375	10	1	\N	\N	\N	2022-03-26 10:10:13.163721+00	\N
1376	10	1	\N	\N	\N	2022-03-26 10:10:38.688026+00	\N
1377	10	1	\N	\N	\N	2022-03-26 10:11:53.887669+00	\N
1378	10	1	\N	\N	\N	2022-03-26 10:12:58.661427+00	\N
1379	10	1	\N	\N	\N	2022-03-26 10:16:38.973796+00	\N
1380	10	1	\N	\N	\N	2022-03-26 10:17:50.921422+00	\N
1381	10	1	\N	\N	\N	2022-03-26 10:19:43.989987+00	\N
1382	10	1	\N	\N	\N	2022-03-26 10:20:39.242113+00	\N
1383	10	1	\N	\N	\N	2022-03-26 10:21:25.821132+00	\N
1384	10	1	\N	\N	\N	2022-03-26 10:23:01.398232+00	\N
1385	10	1	\N	\N	\N	2022-03-26 10:24:18.987693+00	\N
1386	10	1	\N	\N	\N	2022-03-26 10:25:55.022135+00	\N
1387	10	1	\N	\N	\N	2022-03-26 10:29:07.362497+00	\N
1388	10	1	\N	\N	\N	2022-03-26 10:30:34.452984+00	\N
1389	10	1	\N	\N	\N	2022-03-26 10:31:53.724228+00	\N
1390	10	1	\N	\N	\N	2022-03-26 10:42:20.800628+00	\N
1391	10	1	\N	\N	\N	2022-03-26 10:43:33.023888+00	\N
1392	10	1	\N	\N	\N	2022-03-26 10:45:41.250853+00	\N
1393	10	1	\N	\N	\N	2022-03-26 10:46:59.410255+00	\N
1395	10	1	\N	\N	\N	2022-03-26 10:50:49.011873+00	\N
1397	10	1	\N	\N	\N	2022-03-26 10:52:16.481912+00	\N
1399	10	1	\N	\N	\N	2022-03-26 10:54:04.985455+00	\N
1401	10	1	\N	\N	\N	2022-04-12 15:54:28.212623+00	\N
\.


--
-- Data for Name: inventory_movement_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_movement_item (movement_item_id, movement_id, item_id, from_location_id, to_location_id, available_qty_diff, reserved_qty_diff) FROM stdin;
999	1332	3545	1123	1123	5	\N
1000	1333	3545	1123	1123	-5	\N
1001	1333	3547	1123	1123	3	\N
1002	1333	3548	1123	1123	3	\N
1003	1333	3549	1123	1123	3	\N
1004	1333	3550	1123	1123	3	\N
1005	1334	3551	1123	1123	5	\N
1006	1334	3552	1123	1123	5	\N
1007	1334	3553	1123	1123	5	\N
1008	1334	3554	1123	1123	5	\N
1009	1335	3556	1123	1123	2	\N
1010	1335	3557	1123	1123	2	\N
1011	1335	3558	1123	1123	2	\N
1012	1335	3559	1123	1123	2	\N
1013	1336	3561	1123	1123	3	\N
1014	1336	3562	1123	1123	3	\N
1015	1336	3563	1123	1123	3	\N
1016	1336	3564	1123	1123	3	\N
1017	1337	3566	1123	1123	3	\N
1018	1337	3567	1123	1123	3	\N
1019	1337	3568	1123	1123	3	\N
1020	1337	3569	1123	1123	3	\N
1025	1339	3576	1123	1123	1	\N
1026	1339	3577	1123	1123	1	\N
1027	1339	3578	1123	1123	1	\N
1028	1339	3579	1123	1123	1	\N
1029	1341	3581	1123	1123	1	\N
1030	1341	3582	1123	1123	1	\N
1031	1341	3583	1123	1123	1	\N
1032	1341	3584	1123	1123	1	\N
1033	1342	3586	1123	1123	1	\N
1034	1342	3587	1123	1123	1	\N
1035	1342	3588	1123	1123	1	\N
1036	1342	3589	1123	1123	1	\N
1037	1343	3591	1123	1123	2	\N
1038	1343	3592	1123	1123	2	\N
1039	1343	3593	1123	1123	2	\N
1040	1343	3594	1123	1123	2	\N
1041	1344	3596	1123	1123	1	\N
1042	1344	3597	1123	1123	1	\N
1043	1344	3598	1123	1123	1	\N
1044	1344	3599	1123	1123	1	\N
1045	1345	3601	1123	1123	1	\N
1046	1345	3602	1123	1123	1	\N
1047	1345	3603	1123	1123	1	\N
1048	1345	3604	1123	1123	1	\N
1049	1346	3606	1123	1123	1	\N
1050	1346	3607	1123	1123	1	\N
1051	1346	3608	1123	1123	1	\N
1052	1346	3609	1123	1123	1	\N
1053	1347	3611	1123	1123	1	\N
1054	1347	3612	1123	1123	1	\N
1055	1347	3613	1123	1123	1	\N
1056	1347	3614	1123	1123	1	\N
1057	1348	3616	1123	1123	1	\N
1058	1348	3617	1123	1123	1	\N
1059	1348	3618	1123	1123	1	\N
1060	1349	3620	1123	1123	1	\N
1061	1349	3621	1123	1123	1	\N
1062	1349	3622	1123	1123	1	\N
1063	1350	3624	1123	1123	1	\N
1064	1350	3625	1123	1123	1	\N
1065	1350	3626	1123	1123	1	\N
1066	1352	3628	1123	1123	1	\N
1067	1352	3629	1123	1123	1	\N
1068	1352	3630	1123	1123	1	\N
1069	1353	3633	1123	1123	1	\N
1070	1353	3634	1123	1123	1	\N
1071	1354	3635	1123	1123	1	\N
1072	1354	3636	1123	1123	1	\N
1073	1355	3638	1123	1123	1	\N
1074	1355	3639	1123	1123	1	\N
1075	1356	3641	1123	1123	1	\N
1076	1356	3642	1123	1123	1	\N
1077	1356	3643	1123	1123	1	\N
1078	1357	3645	1123	1123	2	\N
1079	1357	3646	1123	1123	2	\N
1080	1357	3647	1123	1123	2	\N
1081	1358	3648	1123	1123	2	\N
1082	1359	3649	1123	1123	2	\N
1083	1360	3650	1123	1123	1	\N
1084	1361	3651	1123	1123	1	\N
1085	1362	3651	1123	1123	19	\N
1086	1364	3633	1123	1123	18	\N
1087	1365	3634	1123	1123	18	\N
1088	1368	3635	1123	1123	24	\N
1089	1369	3636	1123	1123	9	\N
1090	1370	3645	1123	1123	18	\N
1091	1371	3646	1123	1123	13	\N
1092	1372	3647	1123	1123	18	\N
1093	1373	3638	1123	1123	99	\N
1094	1374	3639	1123	1123	99	\N
1095	1375	3641	1123	1123	14	\N
1096	1376	3642	1123	1123	14	\N
1097	1376	3642	1124	1124	10	\N
1098	1376	3643	1123	1123	14	\N
1099	1376	3643	1124	1124	10	\N
1100	1376	3641	1124	1124	10	\N
1101	1377	3566	1123	1123	7	\N
1102	1377	3566	1124	1124	10	\N
1103	1377	3567	1123	1123	7	\N
1104	1377	3567	1124	1124	10	\N
1105	1377	3568	1123	1123	7	\N
1106	1377	3568	1124	1124	10	\N
1107	1377	3569	1123	1123	7	\N
1108	1377	3569	1124	1124	10	\N
1109	1378	3596	1123	1123	9	\N
1110	1378	3596	1124	1124	10	\N
1111	1378	3597	1123	1123	9	\N
1112	1378	3597	1124	1124	10	\N
1113	1378	3598	1123	1123	9	\N
1114	1378	3598	1124	1124	10	\N
1115	1378	3599	1123	1123	9	\N
1116	1378	3599	1124	1124	10	\N
1117	1379	3581	1123	1123	9	\N
1118	1379	3581	1124	1124	10	\N
1119	1379	3582	1123	1123	9	\N
1120	1379	3582	1124	1124	10	\N
1121	1379	3583	1123	1123	9	\N
1122	1379	3583	1124	1124	10	\N
1123	1379	3584	1123	1123	9	\N
1124	1379	3584	1124	1124	10	\N
1125	1380	3611	1123	1123	13	\N
1126	1380	3611	1124	1124	5	\N
1127	1380	3612	1123	1123	13	\N
1128	1380	3612	1124	1124	5	\N
1129	1380	3613	1123	1123	13	\N
1130	1380	3613	1124	1124	5	\N
1131	1380	3614	1123	1123	13	\N
1132	1380	3614	1124	1124	5	\N
1133	1381	3551	1123	1123	-5	\N
1134	1381	3551	1124	1124	10	\N
1135	1381	3552	1123	1123	-5	\N
1136	1381	3552	1124	1124	10	\N
1137	1381	3553	1123	1123	-5	\N
1138	1381	3553	1124	1124	10	\N
1139	1381	3554	1123	1123	-5	\N
1140	1381	3554	1124	1124	10	\N
1141	1382	3576	1123	1123	9	\N
1142	1382	3576	1124	1124	5	\N
1143	1382	3577	1123	1123	9	\N
1144	1382	3577	1124	1124	5	\N
1145	1382	3578	1123	1123	9	\N
1146	1382	3578	1124	1124	5	\N
1147	1382	3579	1123	1123	9	\N
1148	1382	3579	1124	1124	5	\N
1149	1383	3586	1123	1123	9	\N
1150	1383	3587	1123	1123	9	\N
1151	1383	3588	1123	1123	9	\N
1152	1383	3589	1123	1123	9	\N
1153	1384	3606	1123	1123	-1	\N
1154	1384	3606	1124	1124	10	\N
1155	1384	3607	1123	1123	-1	\N
1156	1384	3607	1124	1124	10	\N
1157	1384	3608	1123	1123	-1	\N
1158	1384	3608	1124	1124	10	\N
1159	1384	3609	1123	1123	-1	\N
1160	1384	3609	1124	1124	10	\N
1161	1385	3624	1123	1123	9	\N
1162	1385	3625	1123	1123	9	\N
1163	1385	3626	1123	1123	9	\N
1164	1386	3591	1123	1123	28	\N
1165	1386	3592	1123	1123	28	\N
1166	1386	3593	1123	1123	28	\N
1167	1386	3594	1123	1123	28	\N
1168	1387	3561	1123	1123	7	\N
1169	1387	3562	1123	1123	7	\N
1170	1387	3563	1123	1123	7	\N
1171	1387	3564	1123	1123	7	\N
1172	1388	3601	1123	1123	9	\N
1173	1388	3602	1123	1123	9	\N
1174	1388	3603	1123	1123	9	\N
1175	1388	3604	1123	1123	9	\N
1176	1389	3616	1123	1123	9	\N
1177	1389	3617	1123	1123	9	\N
1178	1389	3618	1123	1123	9	\N
1179	1390	3547	1123	1123	12	\N
1180	1390	3548	1123	1123	12	\N
1181	1390	3549	1123	1123	12	\N
1182	1390	3550	1123	1123	12	\N
1183	1391	3620	1123	1123	9	\N
1184	1391	3620	1124	1124	15	\N
1185	1391	3621	1123	1123	9	\N
1186	1391	3621	1124	1124	15	\N
1187	1391	3622	1123	1123	9	\N
1188	1391	3622	1124	1124	15	\N
1189	1392	3556	1123	1123	18	\N
1190	1392	3557	1123	1123	18	\N
1191	1392	3558	1123	1123	18	\N
1192	1392	3559	1123	1123	18	\N
1193	1393	3628	1123	1123	9	\N
1194	1393	3628	1124	1124	10	\N
1195	1393	3629	1123	1123	9	\N
1196	1393	3629	1124	1124	10	\N
1197	1393	3630	1123	1123	9	\N
1198	1393	3630	1124	1124	10	\N
1199	1395	3650	1123	1123	19	\N
1200	1397	3648	1123	1123	23	\N
1201	1399	3649	1123	1123	18	\N
1202	1401	3579	1124	1124	-5	\N
1203	1401	3606	1124	1124	-10	\N
1204	1401	3607	1124	1124	-10	\N
1205	1401	3608	1124	1124	-10	\N
1206	1401	3609	1124	1124	-10	\N
1207	1401	3642	1124	1124	-10	\N
1208	1401	3643	1124	1124	-10	\N
1209	1401	3641	1124	1124	-10	\N
1210	1401	3566	1124	1124	-10	\N
1211	1401	3620	1124	1124	-15	\N
1212	1401	3567	1124	1124	-10	\N
1213	1401	3568	1124	1124	-10	\N
1214	1401	3621	1124	1124	-15	\N
1215	1401	3569	1124	1124	-10	\N
1216	1401	3596	1124	1124	-10	\N
1217	1401	3622	1124	1124	-15	\N
1218	1401	3597	1124	1124	-10	\N
1219	1401	3598	1124	1124	-10	\N
1220	1401	3599	1124	1124	-10	\N
1221	1401	3581	1124	1124	-10	\N
1222	1401	3582	1124	1124	-10	\N
1223	1401	3583	1124	1124	-10	\N
1224	1401	3628	1124	1124	-10	\N
1225	1401	3584	1124	1124	-10	\N
1226	1401	3611	1124	1124	-5	\N
1227	1401	3629	1124	1124	-10	\N
1228	1401	3612	1124	1124	-5	\N
1229	1401	3613	1124	1124	-5	\N
1230	1401	3630	1124	1124	-10	\N
1231	1401	3614	1124	1124	-5	\N
1232	1401	3551	1124	1124	-10	\N
1233	1401	3552	1124	1124	-10	\N
1234	1401	3553	1124	1124	-10	\N
1235	1401	3554	1124	1124	-10	\N
1236	1401	3576	1124	1124	-5	\N
1237	1401	3577	1124	1124	-5	\N
1238	1401	3578	1124	1124	-5	\N
\.


--
-- Data for Name: inventory_option; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_option (option_id, category, alias, sort, created_at, deleted_at) FROM stdin;
1	changeQty	\N	5	2015-07-06 09:38:42.820537+00	\N
2	changeQty	\N	10	2015-07-06 09:39:05.971277+00	\N
3	systemChangeQty	availableToReserve	15	2015-08-06 08:05:38.273705+00	\N
4	systemChangeQty	rmFromReserve	25	2015-08-10 06:50:53.295041+00	\N
5	systemChangeQty	reserveSetQty	35	2015-08-10 10:35:11.306604+00	\N
6	systemChangeQty	reservedToOutside	45	2015-09-01 11:58:16.233074+00	\N
7	systemChangeQty	outsideToReserved	55	2015-09-01 13:48:44.046966+00	\N
8	systemChangeQty	importChangeQty	65	2016-04-09 14:03:23.708218+00	\N
9	systemChangeQty	warehouseMovement	75	2017-04-22 13:40:24.546849+00	\N
10	systemChangeQty	editProductForm	80	2017-07-08 17:47:54.579649+00	\N
11	systemChangeQty	availableToOutside	90	2020-01-13 15:53:21.873023+00	\N
14	systemChangeQty	outsideToAvailable	100	2020-01-13 15:53:21.916726+00	\N
15	systemChangeQty	apiRequest	110	2023-12-17 21:58:59.575915+00	\N
\.


--
-- Data for Name: inventory_option_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_option_text (option_id, lang_id, title) FROM stdin;
3	1	Product reservation
4	1	Cancellation of a reservation
5	1	Change in reserve quantity
1	1	Stock Top-up
2	1	Stock Reduction
8	1	Stock level updates during import
9	1	Inventory Transfer Between Warehouses
10	1	Editing a product
11	1	Product shipment
6	1	Product shipment from a reserve
7	1	Shipment cancellation
14	1	Refund
15	1	API movement
\.


--
-- Data for Name: inventory_price; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_price (item_id, price_id, value, currency_id, old) FROM stdin;
3545	7	900.00	1	\N
3545	8	500.00	1	\N
3546	7	900.00	1	\N
3546	8	500.00	1	\N
3631	7	1000.00	1	\N
3631	8	500.00	1	\N
3634	8	6.00	4	\N
3634	7	8.99	4	11.99
3635	7	14.80	4	\N
3635	8	9.95	4	\N
3636	7	13.00	4	\N
3636	8	5.00	4	\N
3645	7	12.00	4	\N
3645	8	8.95	4	\N
3646	7	12.00	4	\N
3646	8	8.00	4	\N
3647	7	12.00	4	\N
3647	8	5.00	4	\N
3638	8	7.00	4	\N
3639	7	12.90	4	\N
3639	8	6.00	4	\N
3566	7	9.90	4	12.99
3566	8	6.00	4	\N
3567	7	9.90	4	12.99
3567	8	6.00	4	\N
3568	7	9.90	4	12.99
3568	8	6.00	4	\N
3569	7	9.90	4	12.99
3569	8	6.00	4	\N
3596	8	4.00	4	\N
3597	7	8.99	4	12.00
3597	8	4.00	4	\N
3598	7	8.99	4	12.00
3598	8	4.00	4	\N
3599	7	8.99	4	12.00
3599	8	4.00	4	\N
3581	8	6.00	4	\N
3582	8	6.00	4	\N
3583	7	7.50	4	15.00
3583	8	6.00	4	\N
3584	7	7.50	4	15.00
3584	8	6.00	4	\N
3611	7	9.99	4	12.99
3611	8	8.00	4	\N
3612	7	9.99	4	12.99
3612	8	8.00	4	\N
3613	8	8.00	4	\N
3614	7	9.99	4	12.99
3614	8	8.00	4	\N
3551	8	8.00	4	\N
3552	7	12.99	4	15.99
3552	8	8.00	4	\N
3553	8	8.00	4	\N
3554	7	12.99	4	15.99
3554	8	8.00	4	\N
3576	7	9.90	4	\N
3577	7	9.90	4	\N
3577	8	6.00	4	\N
3578	7	9.90	4	\N
3578	8	6.00	4	\N
3579	7	9.90	4	\N
3579	8	6.00	4	\N
3586	7	12.99	4	15.00
3586	8	8.00	4	\N
3587	7	12.99	4	15.00
3587	8	8.00	4	\N
3588	8	8.00	4	\N
3589	8	8.00	4	\N
3606	7	9.00	4	\N
3606	8	7.00	4	\N
3607	7	9.00	4	\N
3607	8	7.00	4	\N
3608	7	9.00	4	\N
3608	8	7.00	4	\N
3609	7	9.00	4	\N
3609	8	7.00	4	\N
3624	7	15.00	4	\N
3624	8	9.00	4	\N
3625	7	15.00	4	\N
3625	8	9.00	4	\N
3626	7	15.00	4	\N
3626	8	9.00	4	\N
3591	8	6.95	4	\N
3592	7	9.95	4	\N
3592	8	6.95	4	\N
3593	7	9.95	4	\N
3593	8	6.95	4	\N
3594	7	9.95	4	\N
3594	8	6.95	4	\N
3561	7	8.50	4	\N
3561	8	6.00	4	\N
3562	7	8.50	4	\N
3562	8	6.00	4	\N
3563	7	8.50	4	\N
3564	7	8.50	4	\N
3564	8	6.00	4	\N
3601	7	9.90	4	\N
3601	8	7.00	4	\N
3602	7	9.90	4	\N
3602	8	7.00	4	\N
3603	7	9.90	4	\N
3603	8	7.00	4	\N
3604	7	9.90	4	\N
3604	8	7.00	4	\N
3616	8	7.00	4	\N
3617	7	14.90	4	15.90
3617	8	7.00	4	\N
3618	7	14.90	4	15.90
3618	8	7.00	4	\N
3547	7	9.00	4	14.00
3547	8	7.00	4	\N
3548	7	9.00	4	14.00
3549	8	7.00	4	\N
3550	7	9.00	4	14.00
3550	8	7.00	4	\N
3620	7	14.99	4	16.00
3620	8	8.00	4	\N
3621	7	14.99	4	16.00
3621	8	8.00	4	\N
3622	7	14.99	4	16.00
3622	8	8.00	4	\N
3556	8	6.00	4	\N
3557	7	7.00	4	9.00
3557	8	6.00	4	\N
3558	7	7.00	4	9.00
3558	8	6.00	4	\N
3559	7	7.00	4	9.00
3559	8	6.00	4	\N
3628	8	10.00	4	\N
3629	7	14.99	4	18.99
3629	8	10.00	4	\N
3630	7	14.99	4	18.99
3630	8	10.00	4	\N
3651	7	39.90	4	\N
3651	8	15.00	4	\N
3633	7	9.99	4	12.99
3633	8	7.00	4	\N
3638	7	12.90	4	\N
3642	7	14.99	4	18.99
3642	8	10.00	4	\N
3643	7	14.99	4	18.99
3643	8	10.00	4	\N
3641	7	14.99	4	18.99
3641	8	10.00	4	\N
3596	7	8.99	4	12.00
3581	7	7.50	4	15.00
3582	7	7.50	4	15.00
3613	7	9.99	4	12.99
3551	7	12.99	4	15.99
3553	7	12.99	4	15.99
3576	8	6.00	4	\N
3588	7	12.99	4	15.00
3589	7	12.99	4	15.00
3591	7	9.95	4	\N
3563	8	6.00	4	\N
3616	7	14.90	4	15.90
3548	8	7.00	4	\N
3549	7	9.00	4	14.00
3556	7	7.00	4	9.00
3628	7	14.99	4	18.99
3650	7	45.00	4	\N
3650	8	20.00	4	\N
3648	7	25.99	4	\N
3648	8	12.00	4	\N
3649	7	25.00	4	\N
3649	8	12.00	4	\N
\.


--
-- Data for Name: inventory_stock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_stock (stock_id, location_id, item_id, supply_id, available_qty, reserved_qty) FROM stdin;
1447	1123	3545	\N	0	0
1513	1123	3628	\N	10	0
1514	1123	3629	\N	10	0
1515	1123	3630	\N	10	0
1530	1123	3650	\N	20	0
1528	1123	3648	\N	25	0
1529	1123	3649	\N	20	0
1531	1123	3651	\N	20	0
1516	1123	3633	\N	19	0
1517	1123	3634	\N	19	0
1518	1123	3635	\N	25	0
1519	1123	3636	\N	10	0
1525	1123	3645	\N	20	0
1526	1123	3646	\N	15	0
1527	1123	3647	\N	20	0
1520	1123	3638	\N	100	0
1521	1123	3639	\N	100	0
1522	1123	3641	\N	15	0
1523	1123	3642	\N	15	0
1524	1123	3643	\N	15	0
1464	1123	3566	\N	10	0
1465	1123	3567	\N	10	0
1466	1123	3568	\N	10	0
1467	1123	3569	\N	10	0
1488	1123	3596	\N	10	0
1489	1123	3597	\N	10	0
1490	1123	3598	\N	10	0
1491	1123	3599	\N	10	0
1476	1123	3581	\N	10	0
1477	1123	3582	\N	10	0
1478	1123	3583	\N	10	0
1479	1123	3584	\N	10	0
1500	1123	3611	\N	14	0
1501	1123	3612	\N	14	0
1502	1123	3613	\N	14	0
1503	1123	3614	\N	14	0
1452	1123	3551	\N	0	0
1453	1123	3552	\N	0	0
1454	1123	3553	\N	0	0
1455	1123	3554	\N	0	0
1472	1123	3576	\N	10	0
1473	1123	3577	\N	10	0
1474	1123	3578	\N	10	0
1475	1123	3579	\N	10	0
1480	1123	3586	\N	10	0
1481	1123	3587	\N	10	0
1482	1123	3588	\N	10	0
1483	1123	3589	\N	10	0
1496	1123	3606	\N	0	0
1497	1123	3607	\N	0	0
1498	1123	3608	\N	0	0
1499	1123	3609	\N	0	0
1510	1123	3624	\N	10	0
1511	1123	3625	\N	10	0
1512	1123	3626	\N	10	0
1484	1123	3591	\N	30	0
1485	1123	3592	\N	30	0
1486	1123	3593	\N	30	0
1487	1123	3594	\N	30	0
1460	1123	3561	\N	10	0
1461	1123	3562	\N	10	0
1462	1123	3563	\N	10	0
1463	1123	3564	\N	10	0
1492	1123	3601	\N	10	0
1493	1123	3602	\N	10	0
1494	1123	3603	\N	10	0
1495	1123	3604	\N	10	0
1504	1123	3616	\N	10	0
1505	1123	3617	\N	10	0
1506	1123	3618	\N	10	0
1448	1123	3547	\N	15	0
1449	1123	3548	\N	15	0
1450	1123	3549	\N	15	0
1451	1123	3550	\N	15	0
1507	1123	3620	\N	10	0
1508	1123	3621	\N	10	0
1509	1123	3622	\N	10	0
1456	1123	3556	\N	20	0
1457	1123	3557	\N	20	0
1458	1123	3558	\N	20	0
1459	1123	3559	\N	20	0
1558	1124	3579	\N	0	0
1559	1124	3606	\N	0	0
1560	1124	3607	\N	0	0
1561	1124	3608	\N	0	0
1562	1124	3609	\N	0	0
1532	1124	3642	\N	0	0
1533	1124	3643	\N	0	0
1534	1124	3641	\N	0	0
1535	1124	3566	\N	0	0
1563	1124	3620	\N	0	0
1536	1124	3567	\N	0	0
1537	1124	3568	\N	0	0
1564	1124	3621	\N	0	0
1538	1124	3569	\N	0	0
1539	1124	3596	\N	0	0
1565	1124	3622	\N	0	0
1540	1124	3597	\N	0	0
1541	1124	3598	\N	0	0
1542	1124	3599	\N	0	0
1543	1124	3581	\N	0	0
1544	1124	3582	\N	0	0
1545	1124	3583	\N	0	0
1566	1124	3628	\N	0	0
1546	1124	3584	\N	0	0
1547	1124	3611	\N	0	0
1567	1124	3629	\N	0	0
1548	1124	3612	\N	0	0
1549	1124	3613	\N	0	0
1568	1124	3630	\N	0	0
1550	1124	3614	\N	0	0
1551	1124	3551	\N	0	0
1552	1124	3552	\N	0	0
1553	1124	3553	\N	0	0
1554	1124	3554	\N	0	0
1555	1124	3576	\N	0	0
1556	1124	3577	\N	0	0
1557	1124	3578	\N	0	0
\.


--
-- Data for Name: inventory_supply; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.inventory_supply (supply_id) FROM stdin;
\.


--
-- Data for Name: item_price; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.item_price (item_price_id, price_id, basic_price, final_price, discount_amount, discount_percent) FROM stdin;
1	7	91.00	91.00	\N	\N
3	7	30.00	30.00	\N	\N
4	7	4.00	4.00	\N	\N
5	7	15.00	15.00	\N	\N
6	7	15.00	15.00	\N	\N
8	7	8.00	8.00	\N	\N
9	7	15.00	15.00	\N	\N
10	7	15.00	15.00	\N	\N
2	7	100.00	100.00	\N	\N
7	7	15.00	15.00	\N	\N
11	7	15.00	15.00	\N	\N
12	7	91.00	91.00	\N	\N
14	7	15.00	15.00	\N	\N
15	7	15.00	15.00	\N	\N
13	7	15.00	15.00	\N	\N
16	7	15.00	15.00	\N	\N
17	7	15.00	10.00	5.00	\N
18	7	15.00	9.70	5.00	2.00
19	7	15.00	15.00	\N	\N
20	7	15.00	15.00	\N	\N
67	7	15.00	15.00	\N	\N
59	7	91.00	91.00	\N	\N
60	7	91.00	91.00	\N	\N
61	7	91.00	91.00	\N	\N
224	7	75.00	75.00	\N	\N
68	7	15.00	15.00	\N	\N
69	7	15.00	15.00	\N	\N
229	\N	\N	17.00	\N	\N
230	\N	\N	300.00	\N	\N
231	7	30.00	30.00	\N	\N
233	\N	\N	300.00	\N	\N
234	\N	\N	101.00	\N	\N
237	\N	\N	100.00	\N	\N
238	\N	\N	77.00	\N	\N
232	7	100.00	100.00	\N	\N
236	7	91.00	91.00	\N	\N
263	7	91.00	91.00	\N	\N
264	7	100.00	100.00	\N	\N
322	7	100.00	100.00	\N	\N
186	7	100.00	100.00	\N	\N
226	7	75.00	75.00	\N	\N
363	\N	\N	300.00	\N	\N
364	\N	\N	70.00	\N	\N
367	\N	\N	77.00	\N	\N
366	\N	\N	300.00	\N	\N
361	7	100.00	100.00	\N	\N
368	\N	\N	0.00	\N	\N
370	\N	\N	100.00	\N	\N
371	\N	\N	77.00	\N	\N
227	7	75.00	75.00	\N	\N
228	7	75.00	75.00	\N	\N
321	7	100.00	90.00	10.00	\N
372	\N	\N	77.00	\N	\N
373	\N	\N	10.00	\N	\N
374	\N	\N	200.00	\N	\N
375	7	74.05	74.05	\N	\N
376	7	74.05	74.05	\N	\N
377	7	100.00	100.00	\N	\N
378	7	100.00	100.00	\N	\N
379	7	100.00	100.00	\N	\N
380	7	100.00	100.00	\N	\N
381	\N	74.05	74.05	\N	\N
382	7	100.00	100.00	\N	\N
383	\N	74.05	74.05	\N	\N
384	7	100.00	100.00	\N	\N
385	\N	74.05	74.05	\N	\N
386	7	100.00	100.00	\N	\N
387	\N	74.05	74.05	\N	\N
388	7	100.00	100.00	\N	\N
389	\N	74.05	74.05	\N	\N
390	7	100.00	100.00	\N	\N
391	\N	74.05	74.05	\N	\N
392	7	100.00	100.00	\N	\N
393	7	100.00	100.00	\N	\N
394	7	100.00	100.00	\N	\N
395	\N	74.05	74.05	\N	\N
396	7	100.00	100.00	\N	\N
397	7	100.00	100.00	\N	\N
398	7	100.00	100.00	\N	\N
399	\N	74.05	74.05	\N	\N
400	7	100.00	100.00	\N	\N
401	\N	74.05	74.05	\N	\N
402	\N	74.05	74.05	\N	\N
403	7	100.00	100.00	\N	\N
404	7	100.00	100.00	\N	\N
405	\N	74.05	74.05	\N	\N
406	7	100.00	100.00	\N	\N
407	\N	74.05	74.05	\N	\N
408	7	100.00	100.00	\N	\N
409	7	100.00	100.00	\N	\N
410	\N	74.05	74.05	\N	\N
365	7	100.00	100.00	\N	\N
411	7	100.00	100.00	\N	\N
412	\N	\N	300.00	\N	\N
413	7	100.00	100.00	\N	\N
414	\N	\N	300.00	\N	\N
416	\N	\N	100.00	\N	\N
415	7	100.00	100.00	\N	\N
418	\N	\N	200.00	\N	\N
419	\N	74.05	74.05	\N	\N
420	\N	74.05	74.05	\N	\N
421	\N	\N	300.00	\N	\N
423	7	100.00	100.00	\N	\N
424	\N	\N	\N	\N	\N
425	7	100.00	100.00	\N	\N
426	7	100.00	100.00	\N	\N
427	\N	\N	\N	\N	\N
428	7	100.00	100.00	\N	\N
429	\N	\N	\N	\N	\N
430	7	100.00	100.00	\N	\N
431	7	100.00	100.00	\N	\N
432	7	100.00	100.00	\N	\N
433	\N	\N	300.00	\N	\N
435	\N	\N	300.00	\N	\N
436	7	100.00	100.00	\N	\N
438	7	100.00	100.00	\N	\N
434	7	100.00	100.00	\N	\N
439	\N	\N	77.00	\N	\N
440	7	100.00	100.00	\N	\N
441	7	100.00	100.00	\N	\N
443	7	100.00	100.00	\N	\N
451	\N	\N	\N	\N	\N
456	7	100.00	100.00	\N	\N
457	7	100.00	100.00	\N	\N
458	7	100.00	100.00	\N	\N
459	7	100.00	100.00	\N	\N
460	7	91.00	91.00	\N	\N
461	7	15000000.05	15000000.05	\N	\N
369	7	100.00	100.00	\N	\N
454	7	100.00	100.00	\N	\N
469	7	30.00	30.00	\N	\N
465	7	100.00	100.00	\N	\N
455	\N	\N	0.00	\N	\N
448	7	100.00	100.00	\N	\N
449	\N	\N	0.00	\N	\N
362	7	100.00	100.00	\N	\N
466	7	100.00	100.00	\N	\N
467	7	100.00	100.00	\N	\N
468	\N	74.05	74.05	\N	\N
417	\N	74.05	74.05	\N	\N
422	7	100.00	100.00	\N	\N
452	7	100.00	100.00	\N	\N
463	7	74.05	74.05	\N	\N
464	7	10.00	10.00	\N	\N
453	\N	\N	300.00	\N	\N
446	7	100.00	100.00	\N	\N
444	7	100.00	100.00	\N	\N
445	\N	\N	0.00	\N	\N
450	7	100.00	100.00	\N	\N
447	\N	\N	0.00	\N	\N
70	7	100.00	90.00	\N	10.00
470	\N	74.05	74.05	\N	\N
471	\N	74.05	74.05	\N	\N
472	\N	\N	300.00	\N	\N
473	7	300.00	300.00	\N	\N
474	7	500.00	500.00	\N	\N
475	7	15000000.05	15000000.05	\N	\N
476	7	74.05	74.05	\N	\N
477	7	74.05	74.05	\N	\N
478	7	74.05	74.05	\N	\N
479	7	100.00	100.00	\N	\N
480	\N	74.05	74.05	\N	\N
481	7	100.00	100.00	\N	\N
482	7	300.00	300.00	\N	\N
483	7	100.00	100.00	\N	\N
484	7	500.00	500.00	\N	\N
485	7	300.00	300.00	\N	\N
486	\N	74.05	74.05	\N	\N
487	\N	\N	300.00	\N	\N
488	7	100.00	100.00	\N	\N
492	\N	\N	300.00	\N	\N
491	\N	74.05	74.05	\N	\N
489	7	500.00	500.00	\N	\N
490	7	300.00	300.00	\N	\N
493	\N	\N	77.00	\N	\N
494	7	100.00	100.00	\N	\N
495	7	100.00	100.00	\N	\N
496	7	100.00	100.00	\N	\N
497	7	100.00	100.00	\N	\N
498	\N	74.05	74.05	\N	\N
499	7	300.00	300.00	\N	\N
500	7	100.00	100.00	\N	\N
501	\N	74.05	74.05	\N	\N
502	\N	\N	200.00	\N	\N
503	7	2490.00	2490.00	\N	\N
504	7	2490.00	2490.00	\N	\N
505	\N	\N	100.00	\N	\N
506	\N	\N	77.00	\N	\N
507	7	4590.00	4590.00	\N	\N
508	\N	\N	200.00	\N	\N
509	7	4590.00	4590.00	\N	\N
510	\N	\N	139.00	\N	\N
511	7	990.00	990.00	\N	\N
512	7	1190.00	1190.00	\N	\N
513	\N	\N	144.00	\N	\N
514	7	1190.00	1190.00	\N	\N
515	\N	\N	243.00	\N	\N
518	\N	\N	102.00	\N	\N
519	7	759.00	759.00	\N	\N
520	7	890.00	890.00	\N	\N
521	\N	\N	251.00	\N	\N
522	7	1790.00	1790.00	\N	\N
523	7	4590.00	4590.00	\N	\N
524	\N	\N	171.00	\N	\N
525	7	1190.00	1190.00	\N	\N
526	7	1190.00	1190.00	\N	\N
527	\N	\N	146.00	\N	\N
528	7	2799.00	2799.00	\N	\N
529	7	759.00	759.00	\N	\N
530	\N	\N	162.00	\N	\N
531	7	2799.00	2799.00	\N	\N
532	\N	\N	206.00	\N	\N
533	7	1190.00	1190.00	\N	\N
534	7	2690.00	2690.00	\N	\N
535	\N	\N	212.00	\N	\N
536	7	4590.00	4590.00	\N	\N
537	\N	\N	236.00	\N	\N
538	7	1190.00	1190.00	\N	\N
539	\N	\N	286.00	\N	\N
540	7	890.00	890.00	\N	\N
541	\N	\N	137.00	\N	\N
542	7	3990.00	3990.00	\N	\N
543	\N	\N	280.00	\N	\N
544	7	890.00	890.00	\N	\N
545	\N	\N	272.00	\N	\N
546	7	3790.00	3790.00	\N	\N
547	\N	\N	294.00	\N	\N
548	7	990.00	990.00	\N	\N
549	\N	\N	209.00	\N	\N
550	7	1190.00	1190.00	\N	\N
551	\N	\N	106.00	\N	\N
552	7	990.00	990.00	\N	\N
553	7	1350.00	1350.00	\N	\N
554	\N	\N	225.00	\N	\N
555	7	2799.00	2799.00	\N	\N
556	\N	\N	205.00	\N	\N
557	7	5450.00	5450.00	\N	\N
558	\N	\N	166.00	\N	\N
516	7	1190.00	1190.00	\N	\N
517	7	2290.00	2290.00	\N	\N
\.


--
-- Data for Name: label; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.label (label_id, color, text_color, icon, remove_after, created_at, deleted_at) FROM stdin;
2	#fbca04	#000000	fire	\N	2017-04-23 10:09:47.008495+00	\N
1	#b60205	#ffffff	flag	\N	2017-04-23 10:09:03.025843+00	\N
4	#0e8a16	#000000	\N	\N	2017-04-24 12:57:58.125999+00	\N
3	#bfd4f2	#000000	heart	\N	2017-04-23 10:10:07.525525+00	\N
\.


--
-- Data for Name: label_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.label_text (label_id, lang_id, title) FROM stdin;
2	1	Hot!
1	1	New!
4	1	Best choice
3	1	Sale
\.


--
-- Data for Name: lang; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lang (lang_id, code, is_backend) FROM stdin;
1	en	t
\.


--
-- Data for Name: lang_title; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.lang_title (lang_id, in_lang_id, title) FROM stdin;
1	1	Русский
\.


--
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.manufacturer (manufacturer_id, created_at, layout, deleted_at, image_id, status, created_by) FROM stdin;
32	2017-04-23 10:01:30.075906+00	\N	\N	207	published	\N
33	2017-04-23 10:05:56.955038+00	\N	\N	208	published	\N
34	2017-04-23 10:06:48.607627+00	\N	\N	209	published	\N
35	2017-04-23 10:08:24.874617+00	\N	\N	210	published	\N
\.


--
-- Data for Name: manufacturer_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.manufacturer_text (manufacturer_id, lang_id, title, custom_title, custom_header, meta_description, meta_keywords, url_key, description) FROM stdin;
32	1	Love MEI	\N	\N	\N	\N	love-mei	\N
33	1	Spigen	\N	\N	\N	\N	spigen	\N
34	1	Anymode	\N	\N	\N	\N	anymode	\N
35	1	Element Case	\N	\N	\N	\N	element-case	\N
\.


--
-- Data for Name: menu_block; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menu_block (block_id, site_id, key, created_at) FROM stdin;
1	1	top	2015-09-18 12:24:43.497772+00
3	1	bottom	2015-09-18 13:20:30.688738+00
4	1	category	2015-09-22 11:28:55.626837+00
5	1	bottomFaq	2015-11-18 14:43:07.399414+00
6	1	faq	2015-11-18 15:00:58.063649+00
7	1	important	2019-11-18 15:48:08.982941+00
\.


--
-- Data for Name: menu_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menu_item (item_id, block_id, lang_id, parent_id, type, title, url, sort, created_at, highlight, css_class) FROM stdin;
30	1	1	\N	page	О компании	\N	0	2017-04-24 14:04:46.012883+00	f	\N
31	1	1	\N	page	Доставка	\N	10	2017-04-24 14:04:56.302173+00	f	\N
32	1	1	\N	page	Оплата	\N	20	2017-04-24 14:05:01.980705+00	f	\N
33	3	1	\N	page	О компании	\N	0	2017-04-24 14:05:26.989456+00	f	\N
34	3	1	\N	page	Доставка	\N	10	2017-04-24 14:05:37.451255+00	f	\N
35	3	1	\N	page	Оплата	\N	20	2017-04-24 14:05:44.279031+00	f	\N
36	3	1	\N	page	Условия возврата	\N	30	2017-04-24 14:05:56.202433+00	f	\N
37	7	1	\N	url	Главная	/	0	2019-11-18 15:48:09.003158+00	f	\N
38	7	1	\N	url	Оптовикам	#	10	2019-11-18 15:48:09.028709+00	f	\N
39	7	1	\N	url	Покупка в кредит	#	20	2019-11-18 15:48:09.030643+00	f	\N
40	7	1	\N	url	Акции!	#	30	2019-11-18 15:48:09.03332+00	f	\N
\.


--
-- Data for Name: menu_item_rel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menu_item_rel (item_id, category_id, page_id, product_id) FROM stdin;
30	\N	20	\N
31	\N	21	\N
32	\N	25	\N
33	\N	20	\N
34	\N	21	\N
35	\N	25	\N
36	\N	23	\N
37	\N	\N	\N
38	\N	\N	\N
39	\N	\N	\N
40	\N	\N	\N
\.


--
-- Data for Name: notification_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notification_history (notification_id, recipient, type, essence_id, text, sent_at) FROM stdin;
\.


--
-- Data for Name: notification_template; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notification_template (template_id, status_id, transport, subject, template, event_type) FROM stdin;
1	\N	email	Thank you for your order!	<div>\n<h1 class="text-center">Thank you for your order!</h1>\n<p>Your order id is <b>#{{{ORDER_ID}}}</b>.</p>\n<p class="text-center">\n<a href="{{{ORDER_URL}}}" alt="Order link" target="_blank" class="cta-btn">\n\tView order\n</a>\n</p>\n{{{ITEMS_LIST}}}\n</div>	created
\.


--
-- Data for Name: offer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offer (offer_id, product_id, price, created_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: order_attrs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_attrs (attr_id, title, key, type, options, hint, sort) FROM stdin;
\.


--
-- Data for Name: order_discount; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_discount (discount_id, order_id, title, discount_type, value, source, code_id, created_at) FROM stdin;
\.


--
-- Data for Name: order_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_history (history_id, order_id, status_id, person_id, changed_at) FROM stdin;
\.


--
-- Data for Name: order_prop; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_prop (order_id, client_comment, custom_attrs) FROM stdin;
\.


--
-- Data for Name: order_service; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_service (order_service_id, order_id, service_id, qty, total_price, item_price_id, is_delivery, created_at) FROM stdin;
\.


--
-- Data for Name: order_service_delivery; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_service_delivery (order_service_id, delivery_id, title, text_info, data) FROM stdin;
\.


--
-- Data for Name: order_source; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_source (source_id, alias, sort, created_at, deleted_at) FROM stdin;
1	site	0	2015-07-23 11:30:04.856417+00	\N
2	phone	10	2015-07-23 11:30:22.509735+00	\N
4	sale_in_office	20	2015-09-03 14:01:06.625785+00	\N
5	one_click	30	2018-07-02 20:09:06.149309+00	\N
\.


--
-- Data for Name: order_source_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_source_text (source_id, lang_id, title) FROM stdin;
1	1	Сайт
2	1	Телефон
4	1	Продажа в офисе
5	1	В один клик
\.


--
-- Data for Name: order_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_status (status_id, parent_id, alias, background_color, stock_location, sort, created_at, deleted_at) FROM stdin;
10	\N	in_progress	F2DEDE	inside	10	2015-09-02 04:44:24.632104+00	\N
11	\N	sent	DFF0D8	outside	20	2015-09-02 04:44:24.632104+00	\N
14	\N	completed	84C569	outside	30	2015-09-02 10:47:30.277251+00	\N
13	\N	ready_to_ship	D9EDF7	inside	15	2015-09-02 10:47:30.277251+00	\N
9	\N	new	C0605E	inside	0	2015-09-02 04:44:24.632104+00	\N
15	\N	cancelled	FCF8E3	basket	40	2015-09-02 10:47:30.277251+00	\N
16	\N	refund	FFCC99	basket	50	2020-01-13 15:53:21.946609+00	\N
\.


--
-- Data for Name: order_status_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_status_text (status_id, lang_id, title) FROM stdin;
9	1	New
10	1	Processing
13	1	Ready to be shipped
14	1	Completed
15	1	Cancelled
11	1	Shipped
16	1	Refunded
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (order_id, source_id, status_id, point_id, customer_id, basket_id, payment_method_id, service_total_price, service_total_qty, total_price, created_by, created_at, confirmed_at, paid_at, payment_mark_up, discount_for_order, got_cash_at, publishing_status, public_id, tax_amount, tax_calculations) FROM stdin;
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.page (page_id, site_id, lang_id, parent_id, type, title, system_alias, url_key, typearea_id, route_id, sort, created_at, deleted_at) FROM stdin;
20	1	1	\N	page	О компании	\N	o-kompanii	222	\N	0	2017-04-24 14:00:28.961501+00	\N
21	1	1	\N	page	Доставка	\N	dostavka	223	\N	10	2017-04-24 14:01:16.781509+00	\N
25	1	1	\N	page	Оплата	\N	oplata	226	\N	20	2017-04-24 14:04:24.416215+00	\N
23	1	1	\N	page	Условия возврата	\N	usloviya-vozvrata	225	\N	30	2017-04-24 14:03:14.786959+00	\N
24	1	1	\N	folder	Статьи	\N	stati	\N	\N	40	2017-04-24 14:03:24.288161+00	\N
22	1	1	24	page	Как выбрать чехол на каждый день?	\N	kak-vybrat-chekhol-na-kazhdyi-den	224	\N	0	2017-04-24 14:02:28.023271+00	\N
\.


--
-- Data for Name: page_props; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.page_props (page_id, custom_title, custom_header, meta_description, meta_keywords) FROM stdin;
21	\N	\N	\N	\N
20	\N	\N	\N	\N
23	\N	\N	\N	\N
24	\N	\N	\N	\N
25	\N	\N	\N	\N
22	\N	\N	\N	\N
\.


--
-- Data for Name: payment_callback; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_callback (payment_callback_id, payment_transaction_id, response, created_at) FROM stdin;
\.


--
-- Data for Name: payment_method; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_method (payment_method_id, site_id, payment_gateway_id, for_all_delivery, config, mark_up, sort, created_at, deleted_at) FROM stdin;
1	1	1	t	\N	0.000	10	2017-04-22 13:41:14.869022+00	\N
\.


--
-- Data for Name: payment_method_delivery; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_method_delivery (payment_method_id, delivery_site_id) FROM stdin;
\.


--
-- Data for Name: payment_method_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_method_text (payment_method_id, lang_id, title) FROM stdin;
1	1	Cash on delivery
\.


--
-- Data for Name: payment_request; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_request (payment_request_id, payment_transaction_id, request, created_at) FROM stdin;
\.


--
-- Data for Name: payment_transaction; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payment_transaction (payment_transaction_id, payment_method_id, status, mark_up_amount, total_amount, currency_id, external_id, order_id, person_id, data, error, created_at) FROM stdin;
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person (person_id, site_id, email, registered_at, created_at, deleted_at, is_owner, status, created_by, public_id) FROM stdin;
1	1	info@sellios.ru	2022-10-03 06:52:13.666961+00	2022-10-03 06:52:13.666961+00	\N	t	published	\N	17aea6b4-5268-4e76-bf11-744674e253b0
\.


--
-- Data for Name: person_address; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_address (address_id, person_id, type, is_default, first_name, last_name, company, address_line_1, address_line_2, city, state, country_id, zip, phone, comment, created_at, public_id) FROM stdin;
\.


--
-- Data for Name: person_attrs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_attrs (attr_id, title, key, type, options, hint, sort) FROM stdin;
\.


--
-- Data for Name: person_auth; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_auth (person_id, pass, email_confirmed) FROM stdin;
1	$2a$06$iHLQE1scR4s6FFC54LOVA.TJFYy0957Vi6EW7e56V3ggCPrP9IUoy	\N
\.


--
-- Data for Name: person_profile; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_profile (person_id, first_name, last_name, patronymic, group_id, phone, receive_marketing_info, comment, custom_attrs) FROM stdin;
1	\N	\N	\N	\N	\N	f	\N	\N
\.


--
-- Data for Name: person_role_rel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_role_rel (person_id, role_id) FROM stdin;
1	1
1	2
\.


--
-- Data for Name: person_search; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_search (person_id, search) FROM stdin;
1	info@sellios.ru,   , , , 
\.


--
-- Data for Name: person_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_settings (person_id, settings) FROM stdin;
1	{"showSwitcherBar": true}
\.


--
-- Data for Name: person_token; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_token (token_id, person_id, type, token_1, token_2, ip, valid_till, created_at) FROM stdin;
8447	1	url	gQbiCnfNJeDxNfnXtO4UaDXrzr7PCZ	9516991862	\N	\N	2017-04-22 14:22:04.221944+00
8459	1	rememberMe	ScXIUgFllyi9M9nS2U36zg5qA1BoQA	2944671244	\N	\N	2017-04-25 14:19:34.663016+00
8460	1	url	5KvoFVe65yjRv2zFqWagC8LDquJcr4	5809576788	\N	\N	2022-03-26 09:05:05.715521+00
8461	1	rememberMe	anpEhOPGs9tSrZ13aWWz5GtLpsz6rV	3865989801	\N	\N	2022-03-26 09:06:50.287144+00
8462	1	url	9rgjnIWCJLEHLwLFjI1gXSmikOaSAH	4584077074	\N	\N	2022-04-09 14:25:17.78102+00
8464	1	rememberMe	qanNoisr010Elcyn7GO20bYZtjKCSK	0791662995	\N	\N	2022-04-09 16:06:04.824427+00
8465	1	url	Skxy63B9ETGM3S3Fu5E1yL2FMQzj2B	4710326286	\N	\N	2022-04-12 15:53:41.154143+00
8466	1	rememberMe	bsEObaCPx49zTkAeetoWbmtEkep7ih	9016242478	\N	\N	2022-04-12 15:54:04.774763+00
8467	1	url	t8UvhpsOCjHUu3llDlUMN8EOr3nk9B	6634144926	\N	\N	2022-10-03 06:52:13.680328+00
\.


--
-- Data for Name: person_visitor; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.person_visitor (person_id, user_agent) FROM stdin;
1	\N
\.


--
-- Data for Name: point_sale; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.point_sale (point_id, site_id) FROM stdin;
1	1
\.


--
-- Data for Name: price; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price (price_id, alias, sort, created_at, deleted_at, has_old_price) FROM stdin;
8	purchase_price	10	2015-07-21 13:33:20.781253+00	\N	f
7	selling_price	0	2015-07-21 13:33:20.781253+00	\N	t
\.


--
-- Data for Name: price_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.price_text (price_id, lang_id, title) FROM stdin;
8	1	Cost per item
7	1	Price
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product (product_id, sku, manufacturer_id, group_id, created_at, deleted_at, has_variants, external_id, status, created_by) FROM stdin;
181	3271820	33	61	2017-04-24 12:29:58.07026+00	\N	f	\N	published	\N
173	SCC-001	32	61	2017-04-24 10:40:03.624209+00	\N	t	\N	published	\N
174	SOB-002	32	61	2017-04-24 10:41:41.694638+00	\N	t	\N	published	\N
177	sob-008	33	61	2017-04-24 10:49:33.476642+00	\N	t	\N	published	\N
175	SPK-003	32	61	2017-04-24 10:45:00.561435+00	\N	t	\N	published	\N
176	stc-008	32	61	2017-04-24 10:47:31.69301+00	\N	t	\N	published	\N
165	iphone-case-explorer-wanted	34	61	2017-04-24 08:02:23.326909+00	\N	t	\N	published	\N
159	girl-with-cake	34	61	2017-04-24 07:38:52.936647+00	\N	t	\N	published	\N
162	iphone-case-fuck	34	61	2017-04-24 07:51:49.803382+00	\N	t	\N	published	\N
168	iphone-case-lovely-girl	34	61	2017-04-24 08:13:18.682434+00	\N	t	\N	published	\N
156	santa-matrioshka	34	61	2017-04-24 06:45:30.664956+00	\N	t	\N	published	\N
161	strength-above-all	\N	61	2017-04-24 07:45:16.609766+00	\N	t	\N	published	\N
163	the-amity-affliction	34	61	2017-04-24 07:54:23.266075+00	\N	t	\N	published	\N
167	iphone-case-blonde-with-wineglass	34	61	2017-04-24 08:11:18.762501+00	\N	t	\N	published	\N
171	ipad-case-turquoise	35	61	2017-04-24 10:21:32.45417+00	\N	t	\N	published	\N
164	iphone-case-red	34	61	2017-04-24 07:59:28.856169+00	\N	t	\N	published	\N
158	iphone-case-cake	34	61	2017-04-24 07:33:17.179777+00	\N	t	\N	published	\N
166	iphone-case-cakes-and-girl	34	61	2017-04-24 08:08:16.35046+00	\N	t	\N	published	\N
169	ipad-case-pink	\N	61	2017-04-24 09:35:36.909812+00	\N	t	\N	published	\N
155	pink-with-girl	34	61	2017-04-23 10:12:08.226367+00	\N	t	\N	published	\N
170	ipad-case-gray	35	61	2017-04-24 09:42:34.81508+00	\N	t	\N	published	\N
157	iphone-notebook	34	61	2017-04-24 06:55:55.512357+00	\N	t	\N	published	\N
172	ipad-case-black	35	61	2017-04-24 10:28:38.110148+00	\N	t	\N	published	\N
180	2667209	33	61	2017-04-24 12:15:28.137451+00	\N	f	\N	published	\N
178	3201725	33	61	2017-04-24 12:08:26.514028+00	\N	f	\N	published	\N
179	32017252	33	61	2017-04-24 12:12:37.059327+00	\N	f	\N	published	\N
\.


--
-- Data for Name: product_category_rel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_category_rel (category_id, product_id, is_default, sort) FROM stdin;
103	155	t	\N
109	155	f	\N
110	155	f	\N
104	155	f	\N
105	155	f	\N
106	155	f	\N
103	156	t	\N
104	156	f	\N
105	156	f	\N
106	156	f	\N
109	156	f	\N
110	156	f	\N
103	157	t	\N
104	157	f	\N
105	157	f	\N
106	157	f	\N
110	157	f	\N
109	157	f	\N
108	157	f	\N
103	158	t	\N
104	158	f	\N
105	158	f	\N
106	158	f	\N
108	158	f	\N
110	158	f	\N
103	159	t	\N
104	159	f	\N
105	159	f	\N
106	159	f	\N
103	161	t	\N
104	161	f	\N
105	161	f	\N
106	161	f	\N
109	161	f	\N
110	161	f	\N
103	162	t	\N
104	162	f	\N
105	162	f	\N
106	162	f	\N
103	163	t	\N
104	163	f	\N
105	163	f	\N
106	163	f	\N
109	162	f	\N
110	162	f	\N
109	163	f	\N
110	163	f	\N
103	164	t	\N
104	164	f	\N
105	164	f	\N
106	164	f	\N
109	164	f	\N
108	164	f	\N
103	165	t	\N
104	165	f	\N
105	165	f	\N
106	165	f	\N
110	165	f	\N
103	166	t	\N
104	166	f	\N
105	166	f	\N
106	166	f	\N
108	166	f	\N
110	166	f	\N
103	167	t	\N
104	167	f	\N
105	167	f	\N
106	167	f	\N
108	167	f	\N
110	167	f	\N
103	168	t	\N
104	168	f	\N
105	168	f	\N
106	168	f	\N
108	168	f	\N
110	168	f	\N
112	169	t	\N
113	169	f	\N
114	169	f	\N
112	170	t	\N
113	170	f	\N
114	170	f	\N
112	171	t	\N
113	171	f	\N
114	171	f	\N
112	172	t	\N
113	172	f	\N
114	172	f	\N
101	173	t	\N
101	174	t	\N
101	175	t	\N
101	176	t	\N
101	177	t	\N
111	178	t	\N
106	178	f	\N
106	179	t	\N
111	179	f	\N
105	180	t	\N
111	180	f	\N
101	181	t	\N
111	181	f	\N
107	157	f	\N
107	158	f	\N
107	164	f	\N
107	166	f	\N
107	167	f	\N
107	168	f	\N
107	155	f	\N
107	156	f	\N
107	161	f	\N
107	162	f	\N
107	163	f	\N
107	165	f	\N
107	178	f	\N
107	179	f	\N
107	180	f	\N
107	181	f	\N
99	155	f	\N
99	156	f	\N
99	157	f	\N
99	158	f	\N
99	159	f	\N
99	161	f	\N
99	162	f	\N
99	163	f	\N
99	164	f	\N
99	165	f	\N
99	166	f	\N
99	167	f	\N
99	168	f	\N
99	180	f	\N
99	178	f	\N
99	179	f	\N
100	169	f	\N
100	170	f	\N
100	171	f	\N
100	172	f	\N
\.


--
-- Data for Name: product_image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_image (product_image_id, product_id, image_id, is_default, sort, source_url) FROM stdin;
149	170	241	f	10	\N
151	170	243	t	0	\N
120	155	212	t	0	\N
121	155	213	f	10	\N
123	156	215	f	10	\N
122	156	214	t	0	\N
124	157	216	t	0	\N
125	157	217	f	10	\N
127	158	219	f	10	\N
126	158	218	t	0	\N
164	171	256	f	10	\N
129	159	221	f	10	\N
128	159	220	t	0	\N
165	171	257	t	0	\N
190	180	282	f	10	\N
192	180	284	f	20	\N
132	161	224	f	0	\N
191	180	283	t	0	\N
133	161	225	t	10	\N
166	172	258	f	10	\N
134	162	226	f	0	\N
167	172	259	t	0	\N
135	162	227	t	10	\N
136	163	228	f	0	\N
137	163	229	t	10	\N
169	173	261	f	10	\N
138	164	230	f	0	\N
170	173	262	f	20	\N
139	164	231	t	10	\N
168	173	260	t	0	\N
140	165	232	f	0	\N
141	165	233	t	10	\N
194	181	286	f	10	\N
172	174	264	f	10	\N
173	174	265	f	20	\N
171	174	263	t	0	\N
195	181	287	f	20	\N
143	166	235	t	0	\N
142	166	234	f	10	\N
193	181	285	t	0	\N
175	175	267	f	10	\N
144	167	236	t	0	\N
176	175	268	f	20	\N
174	175	266	t	0	\N
145	168	237	t	0	\N
148	169	240	f	10	\N
147	169	238	t	0	\N
178	176	270	f	10	\N
179	176	271	f	20	\N
177	176	269	t	0	\N
181	177	273	f	10	\N
182	177	274	f	20	\N
180	177	272	t	0	\N
187	179	279	f	10	\N
189	179	281	f	20	\N
188	179	280	t	0	\N
184	178	276	f	10	\N
186	178	278	f	20	\N
185	178	277	t	0	\N
\.


--
-- Data for Name: product_image_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_image_text (product_image_id, lang_id, description, alt) FROM stdin;
120	1	\N	\N
121	1	\N	\N
122	1	\N	\N
123	1	\N	\N
124	1	\N	\N
125	1	\N	\N
126	1	\N	\N
127	1	\N	\N
128	1	\N	\N
129	1	\N	\N
132	1	\N	\N
133	1	\N	\N
134	1	\N	\N
135	1	\N	\N
136	1	\N	\N
137	1	\N	\N
138	1	\N	\N
139	1	\N	\N
140	1	\N	\N
141	1	\N	\N
164	1	\N	\N
165	1	\N	\N
142	1	\N	\N
143	1	\N	\N
144	1	\N	\N
145	1	\N	\N
147	1	\N	\N
148	1	\N	\N
166	1	\N	\N
167	1	\N	\N
168	1	\N	\N
169	1	\N	\N
170	1	\N	\N
171	1	\N	\N
172	1	\N	\N
173	1	\N	\N
174	1	\N	\N
175	1	\N	\N
176	1	\N	\N
177	1	\N	\N
149	1	\N	\N
151	1	\N	\N
178	1	\N	\N
179	1	\N	\N
180	1	\N	\N
181	1	\N	\N
182	1	\N	\N
187	1	\N	\N
188	1	\N	\N
189	1	\N	\N
184	1	\N	\N
185	1	\N	\N
186	1	\N	\N
190	1	\N	\N
191	1	\N	\N
192	1	\N	\N
193	1	\N	\N
194	1	\N	\N
195	1	\N	\N
\.


--
-- Data for Name: product_import; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_import (import_id, site_id, lang_id, person_id, type, run, source_type, file_name, file_path, url, settings, created_at, deleted_at, cloud_path) FROM stdin;
\.


--
-- Data for Name: product_import_imgs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_import_imgs (import_id, url, product_id, status, reason, import_img_id) FROM stdin;
\.


--
-- Data for Name: product_import_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_import_log (log_id, import_id, file_name, file_path, status, started_at, completed_at, result) FROM stdin;
\.


--
-- Data for Name: product_import_rel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_import_rel (log_id, product_id, category_id, status, message, variant_id) FROM stdin;
\.


--
-- Data for Name: product_label_rel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_label_rel (label_id, product_id, created_at) FROM stdin;
1	155	2017-04-23 10:12:08.402916+00
2	156	2017-04-24 06:45:30.772748+00
3	157	2017-04-24 06:55:55.763239+00
3	159	2017-04-24 07:40:15.90437+00
2	163	2017-04-24 07:54:23.312456+00
1	163	2017-04-24 07:54:23.314497+00
3	156	2017-04-24 12:44:16.255223+00
2	162	2017-04-24 12:49:51.732801+00
3	162	2017-04-24 12:49:51.735002+00
2	158	2017-04-24 12:50:16.533317+00
1	158	2017-04-24 12:50:16.535946+00
2	168	2017-04-24 12:53:48.783007+00
2	166	2017-04-24 12:53:58.380628+00
2	159	2017-04-24 12:54:05.437445+00
2	170	2017-04-24 12:54:53.404704+00
3	172	2017-04-24 12:55:08.202414+00
2	169	2017-04-24 12:55:16.142876+00
2	173	2017-04-24 12:56:42.693045+00
3	173	2017-04-24 12:56:42.696333+00
1	175	2017-04-24 12:56:55.488187+00
3	176	2017-04-24 12:57:25.061222+00
4	181	2017-04-24 12:58:01.403773+00
4	165	2017-04-24 13:06:30.256732+00
\.


--
-- Data for Name: product_prop; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_prop (product_id, available_qty, reserved_qty, layout, country_of_origin, extra, size, characteristic, tax_status, tax_class_id, arbitrary_data) FROM stdin;
181	20	0	\N	\N	\N	{"weight": 0.4}	{"for_samsung": [623], "type_of_case": [606], "film_is_included": [611], "is_charging_case": [604]}	taxable	\N	\N
173	38	0	\N	\N	\N	{"weight": 0.1}	{"for_samsung": [622], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
174	35	0	\N	\N	\N	{"weight": 0.1}	{"for_samsung": [623], "type_of_case": [609], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
177	55	0	\N	\N	\N	{"weight": 0.1}	{"for_samsung": [622], "type_of_case": [609], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
175	200	0	\N	\N	\N	{"weight": 0.1}	{"for_samsung": [623], "type_of_case": [606], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
176	45	0	\N	\N	\N	{"weight": 0.1}	{"for_samsung": [623], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
165	40	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
159	40	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
162	40	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
168	56	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
156	0	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
161	40	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
163	40	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
167	0	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
171	30	0	\N	\N	\N	{"weight": 0.1}	{"for_ipad": [618], "type_of_case": [609], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
164	120	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
158	40	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
166	40	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
169	30	0	\N	\N	\N	{}	{"for_ipad": [618], "type_of_case": [609], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
155	60	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
170	30	0	\N	\N	\N	{"weight": 0.1}	{"for_ipad": [618], "type_of_case": [609], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
157	80	0	\N	\N	\N	{"weight": 0.1}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [603]}	taxable	\N	\N
172	30	0	\N	\N	\N	{"weight": 0.1}	{"for_ipad": [618], "type_of_case": [609], "film_is_included": [610], "is_charging_case": [603]}	taxable	\N	\N
180	20	0	\N	\N	\N	{"weight": 0.3}	{"for_iphone": [614], "type_of_case": [606], "film_is_included": [611], "is_charging_case": [604]}	taxable	\N	\N
178	25	0	\N	\N	\N	{"weight": 0.3}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [604]}	taxable	\N	\N
179	20	0	\N	\N	\N	{"weight": 0.3}	{"for_iphone": [615], "type_of_case": [605], "film_is_included": [611], "is_charging_case": [604]}	taxable	\N	\N
\.


--
-- Data for Name: product_review; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_review (review_id, order_id, product_id, name, rating, text, status, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: product_review_img; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_review_img (review_img_id, review_id, image_id, sort, created_at) FROM stdin;
\.


--
-- Data for Name: product_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_text (product_id, lang_id, title, custom_title, custom_header, meta_description, meta_keywords, url_key, description) FROM stdin;
156	1	Case Santa matryoshka	\N	\N	\N	\N	chekhol-santa-matreshka	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
167	1	Case Blonde with a glass	\N	\N	\N	\N	chekhol-blondinka-s-bokalom	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
161	1	Case Strength above all	\N	\N	\N	\N	chekhol-strength-above-all	<p "="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
169	1	Case Pink	\N	\N	\N	\N	chekhol-rozovyi	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
172	1	Case Black	\N	\N	\N	\N	chekhol-chernyi	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
179	1	Battery Case Spigen MetPower for Apple iPhone 5/5S Gray	\N	\N	\N	\N	chekhol-akkumulyator-spigen-metpower-dlya-apple-iphone-5-5s-seryi	<p "="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
176	1	Samsung transparent case	\N	\N	\N	\N	samsung-transparent-case	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
163	1	Case The Amity Affliction	\N	\N	\N	\N	chekhol-the-amity-affliction	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
164	1	Case Red	\N	\N	\N	\N	chekhol-krasnyi	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
178	1	Battery Case Spigen MetPower for Apple iPhone 5/5s Silver	\N	\N	\N	\N	chekhol-akkumulyator-spigen-metpower-dlya-apple-iphone-5-5s-serebristyi	<p "="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
180	1	Battery Case Odoyo Power+Shell for iPhone 6/6S	\N	\N	\N	\N	chekhol-akkumulyator-odoyo-power-shell-dlya-iphone-6-6s	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
162	1	Case Fuck	\N	\N	\N	\N	chekhol-fuck	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
158	1	Case Brownie	\N	\N	\N	\N	chekhol-pirozhnoe	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
171	1	Case Turquoise	\N	\N	\N	\N	chekhol-biryuzovyi	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
157	1	Case Notebook	\N	\N	\N	\N	chekhol-tetrad	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
155	1	Case Pink with girl	\N	\N	\N	\N	chekhol-rozovyi-s-devushkoi	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
173	1	Samsung clear cover	\N	\N	\N	\N	samsung-clear-cover	<p "="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
174	1	Samsung orange book	\N	\N	\N	\N	samsung-orange-book	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
159	1	Girl with a cake	\N	\N	\N	\N	devushka-s-tortom	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
168	1	Case Lovely girl	\N	\N	\N	\N	chekhol-lovely-girl	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
166	1	Case Cakes and girl	\N	\N	\N	\N	chekhol-pirozhnye-i-devushka	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
177	1	Samsung orange book	\N	\N	\N	\N	samsung-orange-book-1	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
181	1	Samsung Backpack для Galaxy S7 Edge (black)	\N	\N	\N	\N	samsung-backpack-dlya-galaxy-s7-edge-chernyi	<p>\r\n    \r\n   </p><p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a \r\nposuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. \r\nSuspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante \r\ngravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel \r\nfelis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec \r\nmolestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing \r\nelit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan \r\nmassa, vel dictum ante.\r\n</p><p></p>
170	1	Case Gray	\N	\N	\N	\N	chekhol-seryi	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
165	1	Case Explorer wanted	\N	\N	\N	\N	chekhol-explorer-wanted	<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
175	1	Samsung pink cover	\N	\N	\N	\N	samsung-pink-cover	<p "="">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a posuere arcu, vitae dignissim tortor. Aliquam pharetra luctus ultrices. Suspendisse vitae dui nibh. Nam maximus tristique dolor, at porta ante gravida quis. Cras vehicula at arcu sit amet vestibulum. Aliquam vel felis viverra, mollis elit in, mollis ligula. Quisque convallis dui nec molestie bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus felis id suscipit venenatis. Duis eget accumsan massa, vel dictum ante.</p>
\.


--
-- Data for Name: product_variant_characteristic; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variant_characteristic (rel_id, product_id, characteristic_id, rel_type, sort) FROM stdin;
611	155	152158	variant	0
612	156	152158	variant	10
613	157	152158	variant	20
614	158	152158	variant	30
615	159	152158	variant	40
617	161	152158	variant	60
618	162	152158	variant	70
619	163	152158	variant	80
620	164	152158	variant	90
621	165	152158	variant	100
622	166	152158	variant	110
623	167	152158	variant	120
624	168	152158	variant	130
625	169	152165	variant	140
626	170	152165	variant	150
627	171	152165	variant	160
628	172	152165	variant	170
629	173	152166	variant	180
630	174	152166	variant	190
631	175	152166	variant	200
632	176	152166	variant	210
633	177	152166	variant	220
\.


--
-- Data for Name: product_yml; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_yml (product_id, yml_export, vendor_code, model, title, description, sales_notes, manufacturer_warranty, seller_warranty, adult, age, cpa) FROM stdin;
155	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
156	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
157	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
158	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
159	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
161	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
163	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
164	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
166	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
168	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
169	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
172	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
173	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
175	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
176	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
177	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
178	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
180	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
181	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: reserve; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reserve (reserve_id, order_id, total_qty, total_price, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: reserve_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reserve_item (reserve_item_id, reserve_id, stock_id, item_id, qty, total_price, item_price_id, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role (role_id, title, alias) FROM stdin;
1	Guest	guest
2	Admin	admin
3	Client	client
4	Guest buyer	guest-buyer
5	Orders manager	orders-manager
6	Content manager	content-manager
\.


--
-- Data for Name: route; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.route (route_id) FROM stdin;
\.


--
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.service (service_id, alias, show_in_list, price, created_at, deleted_at) FROM stdin;
1	delivery	f	\N	2015-08-20 16:18:19.230084+00	\N
\.


--
-- Data for Name: service_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.service_text (service_id, lang_id, title) FROM stdin;
1	1	Доставка
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.setting (setting_id, setting_group, key, value) FROM stdin;
1	inventory	trackInventory	true
1006	system	defaultCountry	1
1008	orders	need_order_confirmation	false
1005	orders	new_order_status_id	9
1019	cms	siteMap	{"path":null,"date":null}
1022	system	favicon	""
1023	system	analytics	\N
1025	cms	openGraph	{"description":"","img":""}
1024	cms	headerInjection	""
1026	cms	semanticMarkup	{"name":"","telephone":"","email":"","address":{"country":"","region":"","city":"","postalCode":"","street":""},"geo":{"lat":"","long":""},"show":false}
1021	system	cleanUp	[]
1027	system	userAgreement	"Согласие на обработку персональных данных.\\n\\nНастоящим в соответствии с Федеральным законом №152-ФЗ “О персональных данных” от 27.07.2006 года свободно, своей волей и в своем интересе выражаю свое безусловное согласие на обработку моих персональных данных [НАЗВАНИЕ КОМПАНИИ], зарегистрированным в соответствии с законодательством РФ по адресу: [АДРЕС РЕГИСТРАЦИИ] (далее по тексту - Оператор).\\nПерсональные данные - любая информация, относящаяся к определенному или определяемому на основании такой информации физическому лицу.\\n\\nНастоящие согласие выдано мною на обработку следующих персональных данных:\\n- Имя\\n- Фамилия\\n- Телефон\\n- Адрес\\n- Email\\n\\nСогласие дано Оператору для совершения следующих действий с моими персональными данными с использованием средств автоматизации и/или без использования таких средств: сбор, систематизация, накопление, хранение, уточнение (обновление, изменение), использование, обезличивание, передача третьим лицам для указанных ниже целей, а также осуществление любых иных действий, предусмотренным действующим законодательством РФ как неавтоматизированным, так и неавтоматизированным способами.\\n\\nДанное согласие дается Оператору и третьему лицу(-ам) Почта России, курьерская компания BoxBerry, курьерская компания СДЭК для обработки моих персональных данных в следующих целях:\\nприобретение товаров\\nдоставка товаров\\nнаправление в мой адрес информации, в том числе рекламной о мероприятиях, товарах, услугах, работах Оператора\\n\\nНастоящее согласие действует до момента его отзыва путем отправки письма на адрес [АДРЕС ЭЛЕКТРОННОЙ ПОЧТЫ]. В случае отзыва мною согласия на обработку персональных данных Оператор вправе продолжить обработку персональных данных без моего согласия при наличии оснований, указанных в пунктах 2-11 части 1 статьи 6, части 2 статьи 10 и части 2 статьи 11 Федерального закона 152-ФЗ “О персональных данных” от 26.06.2006 г.\\n"
1017	delivery	settings	{"defaultProductWeight":"0.5","defaultProductDimensions":{"width":"5","height":"2","length":"10"},"useDimensions":true,"postInfo":{"fullname":"Николай Семенов","address":"пр. Науки 12, Москва","postcode":"180001"},"hideDeliveryTime":false}
1028	orders	minOrderAmount	""
1030	orders	smsNotifications	false
1031	cms	blog	{"title":"","header":"","description":"","keywords":""}
1013	cms	mainPage	{"title":"Чехлы для iPhone, iPad и Samsung","description":"Купить чехлы и аксессуары для Apple и Samsung","keywords":"Чехлы для iPhone. Чехлы для Samsung."}
1032	system	redirectSystemToPrimary	false
1029	system	imgProportion	"scf"
1016	exchange	yml	{"settings":{"cpa":true,"store":true,"pickup":true,"delivery":true,"hideOutOfStock":true,"exportVariants":true,"showDescription":true,"utmLabels":true},"isAvailable":true}
1037	catalog	productPage	{"show":{"sku":true,"benefit":true,"inStock":false,"qtyInput":true,"sizeTable":false},"dropDownIfCases":5,"sizeTable":null,"langs":{}}
1035	catalog	category	{"sort":[{"type":"availability","mode":"asc","props":{}},{"type":"price","mode":"asc","props":{}},{"type":"name","mode":"asc","props":{}}],"limit":28,"sub_category_policy":"subGoods","productsAos":"zoomIn"}
1020	system	company	{"name":"Brand Shop","torg12":{"accountantName":"","deliveredByName":"","deliveredByPosition":"","deliveryAllowedByName":"","deliveryAllowedByPosition":""},"address":"пр. Науки 17, Москва","company":"ООО \\"Супер Магазин\\"","taxNumber":"1773457812","bankDetails":""}
1038	system	faviconNew	\N
1039	orders	requestForReview	{"isActive":false,"sendOnStatusId":14,"sendDelay":86400,"repeatRequestQty":1,"repeatDelay":604800}
3	system	currency	{"alias":"usd"}
1042	system	customerJWTSecret	\N
1036	system	seoTemplates	{"product":{"title":"Buy a cheap {{title}}. Fast worldwide shipping!","metaDescription":"Buy {{title}}, {{sku}}, from {{price}} Fast worldwide shipping!{{shortDescription}}"},"category":{"title":"{{title}} - buy online with free shipping","metaDescription":"Check out our {{title}} for the best prices. Worldwide shipping."}}
1040	mail	template	{"logo":"","signature":"<p>\\r\\n\\t\\t\\t\\t\\tBest regards,<br>\\r\\n\\t\\t\\t\\t\\tSupport team.<br>\\r\\n\\t\\t\\t\\t\\tEmail: <a href=\\"mailto:info@boundless-commerce.com\\">info@boundless-commerce.com</a><br>\\r\\n\\t\\t\\t\\t\\tAddress: 1500 Example str., Los Angeles, CA 94043\\r\\n\\t\\t\\t\\t</p>"}
1045	cms	wixSiteDraftSettings	{}
1046	cms	wixSiteLiveSettings	{}
1018	cms	robots.txt	"\\n\\t\\t\\tUser-Agent: *\\n\\t\\t\\tDisallow:\\n\\t\\t\\tHost: i1.node\\n\\t\\t\\tSitemap: http://i1.node/sitemap.xml\\n\\t\\t"
1012	mail	settings	{"from":"info@boundless-commerce.com","replyTo":"info@sellios.ru"}
1014	system	csvDelimiters	{"delimiter":",","quote":"\\"","escape":"\\"","encoding":"utf8"}
1048	system	tax	{"turnedOn":false,"pricesEnteredWithTax":false,"calculateTaxBasedOn":"storeLocation","taxTitle":"Tax"}
1041	system	frontendUrls	{"loginUrl":"/auth/login","site":"http://localhost:3000","productUrl":"/product/{ALIAS_OR_ID}","orderUrl":"/thank-you/{PUBLIC_ID}/{STATE}","categoryUrl":"/category/{ALIAS_OR_ID}"}
1034	system	locale	{"phone":{"mask":"P0X (000) 000-0000XXXX","placeholder":"+1 (555) 123-4567"},"money":{"decimal":".","thousand":",","precision":2,"format":"%v %s","symbol":"$"},"date":{"dateShort":"MM/dd/yy","dateMedium":"dd-MMM-yyyy","dateLong":"MMMM d, yyyy","dateTimeShort":"MM/dd/yy HH:mm","dateTimeMedium":"dd-MMM-yyyy HH:mm","dateTimeLong":"MMMM d, yyyy HH:mm","time":"HH:mm"}}
1033	orders	checkoutPage	{"contactFields":{"phone":{"show":false,"required":false},"email":{"show":true,"required":true}},"logo":null,"accountPolicy":"guest-and-login","customerNameRequired":["last"],"addressLine2":"hidden","companyName":"optional","footerLinks":[{"title":"Refund policy","url":"/page/refund-policy"},{"title":"Privacy policy","url":"/page/privacy-policy"},{"title":"Terms of service","url":"/page/terms-of-service"}]}
\.


--
-- Data for Name: site; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.site (site_id, host, settings, aliases, system_host) FROM stdin;
1	i1.node	{"useHttps": true, "langUrlPrefix": false}	["i1-static.node"]	i1.node
\.


--
-- Data for Name: site_country_lang; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.site_country_lang (site_id, country_id, lang_id, is_default) FROM stdin;
1	1	1	t
\.


--
-- Data for Name: stream; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stream (stream_id) FROM stdin;
\.


--
-- Data for Name: tax_class; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tax_class (tax_class_id, title, is_default, created_at) FROM stdin;
1	Standard rates	t	2023-12-17 21:58:59.172751+00
\.


--
-- Data for Name: tax_rate; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tax_rate (tax_rate_id, tax_class_id, title, rate, priority, is_compound, include_shipping, country_id, state_code, created_at) FROM stdin;
1	1	Tax	0.0000	0	f	f	\N	\N	2023-12-17 21:58:59.177931+00
\.


--
-- Data for Name: theme_installed; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.theme_installed (installed_id, alias, theme_id, is_using, screen_path, screen_width, screen_height, created_at, variables) FROM stdin;
\.


--
-- Data for Name: theme_installed_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.theme_installed_text (installed_id, lang_id, title) FROM stdin;
\.


--
-- Data for Name: track_number; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.track_number (track_number_id, order_id, track_number, created_at) FROM stdin;
\.


--
-- Data for Name: transfer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transfer (transfer_id, status, from_location_id, to_location_id, completed_movement_id, cancelled_movement_id, movement_comment, created_at) FROM stdin;
\.


--
-- Data for Name: transfer_item; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.transfer_item (transfer_item_id, transfer_id, item_id, qty, created_at) FROM stdin;
\.


--
-- Data for Name: typearea; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.typearea (typearea_id, created_at) FROM stdin;
175	2017-04-22 16:20:49.260256+00
176	2017-04-22 16:20:56.914254+00
177	2017-04-22 16:21:20.937341+00
178	2017-04-22 16:21:33.54914+00
179	2017-04-22 16:21:43.177982+00
180	2017-04-22 16:21:51.290766+00
181	2017-04-22 16:21:59.158636+00
182	2017-04-22 16:22:27.638422+00
183	2017-04-22 16:29:18.222004+00
184	2017-04-22 16:29:39.951915+00
185	2017-04-22 16:30:02.659442+00
186	2017-04-22 16:30:26.143135+00
187	2017-04-22 16:31:20.690432+00
188	2017-04-23 10:01:30.284236+00
189	2017-04-23 10:05:56.96314+00
190	2017-04-23 10:06:48.675795+00
191	2017-04-23 10:08:25.019415+00
192	2017-04-23 10:12:08.411449+00
193	2017-04-24 06:45:30.780803+00
194	2017-04-24 06:55:55.767581+00
195	2017-04-24 07:33:17.360996+00
196	2017-04-24 07:38:52.987554+00
197	2017-04-24 07:41:18.64698+00
198	2017-04-24 07:45:16.707707+00
199	2017-04-24 07:51:49.850656+00
200	2017-04-24 07:54:23.319764+00
201	2017-04-24 07:59:28.918935+00
202	2017-04-24 08:02:23.377517+00
203	2017-04-24 08:08:16.395704+00
204	2017-04-24 08:11:19.02248+00
205	2017-04-24 08:13:18.734198+00
206	2017-04-24 08:30:09.181966+00
207	2017-04-24 08:30:26.930669+00
208	2017-04-24 08:30:39.632498+00
209	2017-04-24 09:35:37.028142+00
210	2017-04-24 09:42:35.299811+00
211	2017-04-24 10:21:32.49898+00
212	2017-04-24 10:28:38.188465+00
213	2017-04-24 10:40:03.676073+00
214	2017-04-24 10:41:41.726711+00
215	2017-04-24 10:45:00.58906+00
216	2017-04-24 10:47:31.721912+00
217	2017-04-24 10:49:33.506852+00
218	2017-04-24 12:08:26.704799+00
219	2017-04-24 12:12:37.093348+00
220	2017-04-24 12:15:28.173732+00
221	2017-04-24 12:29:58.169905+00
222	2017-04-24 14:00:29.187546+00
223	2017-04-24 14:01:16.808547+00
224	2017-04-24 14:02:28.034901+00
225	2017-04-24 14:03:14.801842+00
226	2017-04-24 14:04:24.430405+00
\.


--
-- Data for Name: typearea_block; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.typearea_block (block_id, typearea_id, type, noindex, sort, created_at, deleted_at) FROM stdin;
288	175	text	f	10	2017-04-22 16:20:49.265908+00	\N
289	176	text	f	10	2017-04-22 16:20:56.918213+00	\N
290	177	text	f	10	2017-04-22 16:21:20.94158+00	\N
291	178	text	f	10	2017-04-22 16:21:33.556458+00	\N
292	179	text	f	10	2017-04-22 16:21:43.30353+00	\N
293	180	text	f	10	2017-04-22 16:21:51.296593+00	\N
294	181	text	f	10	2017-04-22 16:21:59.162865+00	\N
295	182	text	f	10	2017-04-22 16:22:27.643727+00	\N
296	183	text	f	10	2017-04-22 16:29:18.229659+00	\N
297	184	text	f	10	2017-04-22 16:29:39.957164+00	\N
298	185	text	f	10	2017-04-22 16:30:02.663466+00	\N
299	186	text	f	10	2017-04-22 16:30:26.146911+00	\N
300	187	text	f	10	2017-04-22 16:31:20.695253+00	\N
301	188	text	f	10	2017-04-23 10:01:30.290881+00	\N
302	189	text	f	10	2017-04-23 10:05:56.96805+00	\N
303	190	text	f	10	2017-04-23 10:06:48.678956+00	\N
304	191	text	f	10	2017-04-23 10:08:25.033013+00	\N
305	192	text	f	10	2017-04-23 10:12:08.417102+00	\N
306	193	text	f	10	2017-04-24 06:45:30.785565+00	\N
307	194	text	f	10	2017-04-24 06:55:55.773564+00	\N
308	195	text	f	10	2017-04-24 07:33:17.368727+00	\N
309	196	text	f	10	2017-04-24 07:38:52.993136+00	\N
310	197	text	f	10	2017-04-24 07:41:18.652214+00	\N
311	198	text	f	10	2017-04-24 07:45:16.714864+00	\N
312	199	text	f	10	2017-04-24 07:51:49.85541+00	\N
313	200	text	f	10	2017-04-24 07:54:23.324092+00	\N
314	201	text	f	10	2017-04-24 07:59:28.924871+00	\N
315	202	text	f	10	2017-04-24 08:02:23.385477+00	\N
316	203	text	f	10	2017-04-24 08:08:16.400875+00	\N
317	204	text	f	10	2017-04-24 08:11:19.027248+00	\N
318	205	text	f	10	2017-04-24 08:13:18.73777+00	\N
319	206	text	f	10	2017-04-24 08:30:09.190026+00	\N
320	207	text	f	10	2017-04-24 08:30:26.939834+00	\N
321	208	text	f	10	2017-04-24 08:30:39.639787+00	\N
322	209	text	f	10	2017-04-24 09:35:37.034449+00	\N
323	210	text	f	10	2017-04-24 09:42:35.310249+00	\N
324	211	text	f	10	2017-04-24 10:21:32.50518+00	\N
325	212	text	f	10	2017-04-24 10:28:38.194659+00	\N
326	213	text	f	10	2017-04-24 10:40:03.684861+00	\N
327	214	text	f	10	2017-04-24 10:41:41.731343+00	\N
328	215	text	f	10	2017-04-24 10:45:00.594894+00	\N
329	216	text	f	10	2017-04-24 10:47:31.726113+00	\N
330	217	text	f	10	2017-04-24 10:49:33.510648+00	\N
331	218	text	f	10	2017-04-24 12:08:26.708792+00	\N
332	219	text	f	10	2017-04-24 12:12:37.097731+00	\N
333	220	text	f	10	2017-04-24 12:15:28.178656+00	\N
334	221	text	f	10	2017-04-24 12:29:58.174103+00	\N
335	222	text	f	10	2017-04-24 14:00:29.19373+00	\N
336	223	text	f	10	2017-04-24 14:01:16.814236+00	\N
337	224	text	f	10	2017-04-24 14:02:28.042664+00	\N
338	225	text	f	10	2017-04-24 14:03:14.805288+00	\N
339	226	text	f	10	2017-04-24 14:04:24.433861+00	\N
\.


--
-- Data for Name: typearea_block_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.typearea_block_text (block_id, value) FROM stdin;
296	\N
310	<p>Повседневная практика показывает, что консультация с широким активом \r\nпредставляет собой интересный эксперимент проверки системы обучения \r\nкадров, соответствует насущным потребностям.       \r\n   Разнообразный и богатый опыт дальнейшее развитие различных форм \r\nдеятельности требуют от нас анализа направлений прогрессивного развития.\r\n       \r\n   Таким образом постоянное информационно-пропагандистское обеспечение \r\nнашей деятельности в значительной степени обуславливает создание \r\nсоответствующий условий активизации.</p>
301	\N
306	<p>Задача организации, в особенности же новая модель организационной \r\nдеятельности требуют от нас анализа форм развития.       \r\n   Значимость этих проблем настолько очевидна, что начало повседневной \r\nработы по формированию позиции представляет собой интересный эксперимент\r\n проверки модели развития.       \r\n   Разнообразный и богатый опыт постоянный количественный рост и сфера \r\nнашей активности обеспечивает широкому кругу (специалистов) участие в \r\nформировании направлений прогрессивного развития.</p>
302	\N
313	<p>Равным образом рамки и место обучения кадров позволяет оценить значение \r\nдальнейших направлений развития.       \r\n   Разнообразный и богатый опыт постоянный количественный рост и сфера \r\nнашей активности способствует подготовки и реализации форм развития.    \r\n   \r\n   Разнообразный и богатый опыт начало повседневной работы по \r\nформированию позиции играет важную роль в формировании систем массового \r\nучастия.</p>
303	\N
297	\N
304	\N
298	\N
299	\N
300	\N
288	\N
292	\N
311	<p "="">\r\n    \r\n   Равным образом новая модель организационной деятельности требуют \r\nопределения и уточнения направлений прогрессивного развития.       \r\n   Таким образом постоянное информационно-пропагандистское обеспечение \r\nнашей деятельности обеспечивает широкому кругу (специалистов) участие в \r\nформировании дальнейших направлений развития.       \r\n   С другой стороны укрепление и развитие структуры играет важную роль в\r\n формировании существенных финансовых и административных условий.       \r\n   Повседневная практика показывает, что начало повседневной работы по \r\nформированию позиции представляет собой интересный эксперимент проверки \r\nсоответствующий условий активизации.       \r\n   Равным образом постоянный количественный рост и сфера нашей \r\nактивности влечет за собой процесс внедрения и модернизации форм \r\nразвития.   </p>
291	\N
309	<p>Повседневная практика показывает, что новая модель организационной \r\nдеятельности представляет собой интересный эксперимент проверки \r\nсущественных финансовых и административных условий.       \r\n   Идейные соображения высшего порядка, а также постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности требуют от\r\n нас анализа соответствующий условий активизации.       \r\n   Равным образом рамки и место обучения кадров представляет собой \r\nинтересный эксперимент проверки позиций, занимаемых участниками в \r\nотношении поставленных задач.       \r\n   Не следует, однако забывать, что постоянный количественный рост и \r\nсфера нашей активности способствует подготовки и реализации системы \r\nобучения кадров, соответствует насущным потребностям.</p>
293	\N
294	\N
295	\N
289	\N
320	\N
290	\N
312	<p>Таким образом укрепление и развитие структуры требуют от нас анализа \r\nформ развития.       \r\n   Разнообразный и богатый опыт реализация намеченных плановых заданий \r\nвлечет за собой процесс внедрения и модернизации системы обучения \r\nкадров, соответствует насущным потребностям.       \r\n   Разнообразный и богатый опыт начало повседневной работы по \r\nформированию позиции влечет за собой процесс внедрения и модернизации \r\nформ развития.       \r\n   С другой стороны укрепление и развитие структуры требуют определения и\r\n уточнения системы обучения кадров, соответствует насущным потребностям.\r\n       \r\n   Таким образом постоянное информационно-пропагандистское обеспечение \r\nнашей деятельности в значительной степени обуславливает создание систем \r\nмассового участия.       \r\n   Таким образом консультация с широким активом позволяет оценить \r\nзначение форм развития.</p>
308	<p>Задача организации, в особенности же постоянный количественный рост и \r\nсфера нашей активности позволяет выполнять важные задания по разработке \r\nсущественных финансовых и административных условий.       \r\n   Повседневная практика показывает, что постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности играет \r\nважную роль в формировании соответствующий условий активизации.       \r\n   Повседневная практика показывает, что реализация намеченных плановых \r\nзаданий способствует подготовки и реализации направлений прогрессивного \r\nразвития.       \r\n   Идейные соображения высшего порядка, а также постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности требуют от\r\n нас анализа форм развития.       \r\n   С другой стороны дальнейшее развитие различных форм деятельности \r\nвлечет за собой процесс внедрения и модернизации систем массового \r\nучастия.</p>
314	<p>Значимость этих проблем настолько очевидна, что дальнейшее развитие \r\nразличных форм деятельности обеспечивает широкому кругу (специалистов) \r\nучастие в формировании соответствующий условий активизации.       \r\n   Задача организации, в особенности же начало повседневной работы по \r\nформированию позиции влечет за собой процесс внедрения и модернизации \r\nсистемы обучения кадров, соответствует насущным потребностям.</p>
323	<p>Значимость этих проблем настолько очевидна, что начало повседневной \r\nработы по формированию позиции представляет собой интересный эксперимент\r\n проверки форм развития.       \r\n   Не следует, однако забывать, что сложившаяся структура организации \r\nвлечет за собой процесс внедрения и модернизации модели развития.       \r\n   Повседневная практика показывает, что рамки и место обучения кадров \r\nпозволяет оценить значение соответствующий условий активизации.       \r\n   С другой стороны постоянное информационно-пропагандистское \r\nобеспечение нашей деятельности влечет за собой процесс внедрения и \r\nмодернизации соответствующий условий активизации.       \r\n   Повседневная практика показывает, что начало повседневной работы по \r\nформированию позиции влечет за собой процесс внедрения и модернизации \r\nмодели развития.       \r\n   Разнообразный и богатый опыт постоянный количественный рост и сфера \r\nнашей активности требуют определения и уточнения форм развития.</p>
317	<p>\r\n    \r\n   Не следует, однако забывать, что дальнейшее развитие различных форм \r\nдеятельности позволяет оценить значение форм развития.       \r\n   Таким образом постоянный количественный рост и сфера нашей активности\r\n способствует подготовки и реализации позиций, занимаемых участниками в \r\nотношении поставленных задач.   </p>
327	<p>Задача организации, в особенности же постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности \r\nпредставляет собой интересный эксперимент проверки систем массового \r\nучастия.       \r\n   Не следует, однако забывать, что укрепление и развитие структуры \r\nпозволяет оценить значение дальнейших направлений развития.       \r\n   Идейные соображения высшего порядка, а также сложившаяся структура \r\nорганизации позволяет выполнять важные задания по разработке модели \r\nразвития.</p>
315	<p>Разнообразный и богатый опыт рамки и место обучения кадров способствует \r\nподготовки и реализации дальнейших направлений развития.       \r\n   С другой стороны постоянное информационно-пропагандистское \r\nобеспечение нашей деятельности позволяет оценить значение форм развития.</p>
325	<p>\r\n    \r\n   Товарищи! укрепление и развитие структуры требуют определения и \r\nуточнения соответствующий условий активизации.       \r\n   С другой стороны консультация с широким активом позволяет выполнять \r\nважные задания по разработке позиций, занимаемых участниками в отношении\r\n поставленных задач.       \r\n   Задача организации, в особенности же сложившаяся структура \r\nорганизации позволяет оценить значение дальнейших направлений развития. \r\n  </p>
338	<p "="">Не следует, однако забывать, что реализация намеченных плановых \r\nзаданий в значительной степени обуславливает создание системы обучения \r\nкадров, соответствует насущным потребностям.       \r\n   Разнообразный и богатый опыт консультация с широким активом требуют \r\nот нас анализа существенных финансовых и административных условий.      \r\n \r\n   Разнообразный и богатый опыт консультация с широким активом требуют \r\nот нас анализа модели развития.       \r\n   Таким образом консультация с широким активом играет важную роль в \r\nформировании системы обучения кадров, соответствует насущным \r\nпотребностям.   </p><p>\r\n    \r\n   Значимость этих проблем настолько очевидна, что постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности требуют \r\nопределения и уточнения новых предложений.       \r\n   Задача организации, в особенности же новая модель организационной \r\nдеятельности позволяет выполнять важные задания по разработке \r\nсоответствующий условий активизации.       \r\n   Разнообразный и богатый опыт постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности в \r\nзначительной степени обуславливает создание дальнейших направлений \r\nразвития.       \r\n   Значимость этих проблем настолько очевидна, что сложившаяся структура\r\n организации требуют от нас анализа существенных финансовых и \r\nадминистративных условий.       \r\n   Товарищи! постоянное информационно-пропагандистское обеспечение нашей\r\n деятельности требуют определения и уточнения дальнейших направлений \r\nразвития.       \r\n   Идейные соображения высшего порядка, а также реализация намеченных \r\nплановых заданий требуют от нас анализа соответствующий условий \r\nактивизации.   </p><p>\r\n    \r\n   Таким образом укрепление и развитие структуры позволяет выполнять \r\nважные задания по разработке систем массового участия.       \r\n   Товарищи! рамки и место обучения кадров требуют определения и \r\nуточнения позиций, занимаемых участниками в отношении поставленных \r\nзадач.       \r\n   Таким образом сложившаяся структура организации позволяет оценить \r\nзначение модели развития.       \r\n   Равным образом постоянное информационно-пропагандистское обеспечение \r\nнашей деятельности позволяет оценить значение позиций, занимаемых \r\nучастниками в отношении поставленных задач.   </p>
319	\N
321	\N
326	<p "="">С другой стороны укрепление и развитие структуры требуют определения и\r\n уточнения дальнейших направлений развития.       \r\n   Значимость этих проблем настолько очевидна, что консультация с \r\nшироким активом играет важную роль в формировании форм развития.       \r\n   Равным образом укрепление и развитие структуры требуют определения и \r\nуточнения позиций, занимаемых участниками в отношении поставленных \r\nзадач.   </p>
339	<p "="">Таким образом дальнейшее развитие различных форм деятельности \r\nпозволяет выполнять важные задания по разработке форм развития.       \r\n   С другой стороны новая модель организационной деятельности \r\nспособствует подготовки и реализации дальнейших направлений развития.   \r\n    \r\n   Повседневная практика показывает, что сложившаяся структура \r\nорганизации обеспечивает широкому кругу (специалистов) участие в \r\nформировании направлений прогрессивного развития.   </p><p>\r\n    \r\n   Разнообразный и богатый опыт дальнейшее развитие различных форм \r\nдеятельности представляет собой интересный эксперимент проверки \r\nсоответствующий условий активизации.       \r\n   Значимость этих проблем настолько очевидна, что укрепление и развитие\r\n структуры играет важную роль в формировании направлений прогрессивного \r\nразвития.   </p><p>\r\n    \r\n   Не следует, однако забывать, что постоянный количественный рост и \r\nсфера нашей активности обеспечивает широкому кругу (специалистов) \r\nучастие в формировании позиций, занимаемых участниками в отношении \r\nпоставленных задач.       \r\n   С другой стороны постоянный количественный рост и сфера нашей \r\nактивности позволяет выполнять важные задания по разработке системы \r\nобучения кадров, соответствует насущным потребностям.       \r\n   Повседневная практика показывает, что начало повседневной работы по \r\nформированию позиции влечет за собой процесс внедрения и модернизации \r\nсистем массового участия.       \r\n   Значимость этих проблем настолько очевидна, что постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности в \r\nзначительной степени обуславливает создание направлений прогрессивного \r\nразвития.       \r\n   Значимость этих проблем настолько очевидна, что начало повседневной \r\nработы по формированию позиции требуют определения и уточнения \r\nдальнейших направлений развития.       \r\n   Товарищи! постоянное информационно-пропагандистское обеспечение нашей\r\n деятельности требуют определения и уточнения системы обучения кадров, \r\nсоответствует насущным потребностям.   </p>
324	<p>Товарищи! рамки и место обучения кадров обеспечивает широкому кругу \r\n(специалистов) участие в формировании модели развития.       \r\n   С другой стороны рамки и место обучения кадров требуют от нас анализа\r\n направлений прогрессивного развития.       \r\n   Идейные соображения высшего порядка, а также сложившаяся структура \r\nорганизации требуют определения и уточнения системы обучения кадров, \r\nсоответствует насущным потребностям.</p>
322	<p>\r\n    \r\n   Идейные соображения высшего порядка, а также постоянный \r\nколичественный рост и сфера нашей активности в значительной степени \r\nобуславливает создание позиций, занимаемых участниками в отношении \r\nпоставленных задач.       \r\n   Равным образом новая модель организационной деятельности в \r\nзначительной степени обуславливает создание позиций, занимаемых \r\nучастниками в отношении поставленных задач.       \r\n   Значимость этих проблем настолько очевидна, что укрепление и развитие\r\n структуры играет важную роль в формировании новых предложений.       \r\n   Товарищи! дальнейшее развитие различных форм деятельности в \r\nзначительной степени обуславливает создание дальнейших направлений \r\nразвития.       \r\n   Повседневная практика показывает, что начало повседневной работы по \r\nформированию позиции представляет собой интересный эксперимент проверки \r\nновых предложений.       \r\n   Задача организации, в особенности же укрепление и развитие структуры \r\nспособствует подготовки и реализации дальнейших направлений развития.   </p>
329	<p>\r\n    \r\n   Задача организации, в особенности же начало повседневной работы по \r\nформированию позиции в значительной степени обуславливает создание \r\nсистемы обучения кадров, соответствует насущным потребностям.       \r\n   С другой стороны рамки и место обучения кадров позволяет выполнять \r\nважные задания по разработке соответствующий условий активизации.       \r\n   Товарищи! укрепление и развитие структуры представляет собой \r\nинтересный эксперимент проверки существенных финансовых и \r\nадминистративных условий.       \r\n   Разнообразный и богатый опыт укрепление и развитие структуры требуют \r\nот нас анализа существенных финансовых и административных условий.   </p>
331	<p "="">\r\n    \r\n   Не следует, однако забывать, что укрепление и развитие структуры \r\nиграет важную роль в формировании существенных финансовых и \r\nадминистративных условий.       \r\n   Разнообразный и богатый опыт реализация намеченных плановых заданий \r\nпредставляет собой интересный эксперимент проверки модели развития.     \r\n  \r\n   Задача организации, в особенности же постоянный количественный рост и\r\n сфера нашей активности представляет собой интересный эксперимент \r\nпроверки направлений прогрессивного развития.       \r\n   Товарищи! постоянное информационно-пропагандистское обеспечение нашей\r\n деятельности требуют от нас анализа новых предложений.   </p>
335	<p "="">Таким образом укрепление и развитие структуры способствует подготовки\r\n и реализации новых предложений.       \r\n   Задача организации, в особенности же начало повседневной работы по \r\nформированию позиции влечет за собой процесс внедрения и модернизации \r\nсущественных финансовых и административных условий.       \r\n   С другой стороны дальнейшее развитие различных форм деятельности \r\nтребуют от нас анализа соответствующий условий активизации.       \r\n   Повседневная практика показывает, что постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности \r\nспособствует подготовки и реализации модели развития.   </p><p>\r\n    \r\n   Разнообразный и богатый опыт постоянный количественный рост и сфера \r\nнашей активности играет важную роль в формировании соответствующий \r\nусловий активизации.       \r\n   Повседневная практика показывает, что новая модель организационной \r\nдеятельности влечет за собой процесс внедрения и модернизации модели \r\nразвития.   </p>
332	<p "=""> Равным образом новая модель организационной деятельности способствует подготовки и реализации новых предложений.       \r\n   Таким образом новая модель организационной деятельности представляет собой интересный эксперимент проверки форм развития.   </p>
333	<p>\r\n    \r\n   Не следует, однако забывать, что консультация с широким активом \r\nпозволяет выполнять важные задания по разработке системы обучения \r\nкадров, соответствует насущным потребностям.       \r\n   Значимость этих проблем настолько очевидна, что консультация с \r\nшироким активом требуют определения и уточнения дальнейших направлений \r\nразвития.       \r\n   Товарищи! сложившаяся структура организации позволяет оценить \r\nзначение дальнейших направлений развития.       \r\n   С другой стороны новая модель организационной деятельности позволяет \r\nоценить значение форм развития.       \r\n   Задача организации, в особенности же дальнейшее развитие различных \r\nформ деятельности требуют определения и уточнения направлений \r\nпрогрессивного развития.       \r\n   Задача организации, в особенности же рамки и место обучения кадров \r\nпозволяет оценить значение соответствующий условий активизации.   </p>
307	<p>Таким образом рамки и место обучения кадров представляет собой \r\nинтересный эксперимент проверки соответствующий условий активизации.    \r\n   \r\n   Товарищи! реализация намеченных плановых заданий влечет за собой \r\nпроцесс внедрения и модернизации дальнейших направлений развития.       \r\n   Разнообразный и богатый опыт постоянный количественный рост и сфера \r\nнашей активности влечет за собой процесс внедрения и модернизации \r\nдальнейших направлений развития.</p>
334	<p>\r\n    \r\n   Разнообразный и богатый опыт сложившаяся структура организации играет\r\n важную роль в формировании существенных финансовых и административных \r\nусловий.       \r\n   Задача организации, в особенности же начало повседневной работы по \r\nформированию позиции играет важную роль в формировании направлений \r\nпрогрессивного развития.       \r\n   Не следует, однако забывать, что начало повседневной работы по \r\nформированию позиции позволяет выполнять важные задания по разработке \r\nновых предложений.       \r\n   Таким образом постоянное информационно-пропагандистское обеспечение \r\nнашей деятельности представляет собой интересный эксперимент проверки \r\nформ развития.   </p>
330	<p>\r\n    \r\n   Таким образом укрепление и развитие структуры влечет за собой процесс\r\n внедрения и модернизации дальнейших направлений развития.       \r\n   Товарищи! постоянное информационно-пропагандистское обеспечение нашей\r\n деятельности требуют определения и уточнения форм развития.       \r\n   Задача организации, в особенности же дальнейшее развитие различных \r\nформ деятельности играет важную роль в формировании системы обучения \r\nкадров, соответствует насущным потребностям.       \r\n   Таким образом консультация с широким активом влечет за собой процесс \r\nвнедрения и модернизации новых предложений.       \r\n   С другой стороны постоянный количественный рост и сфера нашей \r\nактивности играет важную роль в формировании системы обучения кадров, \r\nсоответствует насущным потребностям.       \r\n   Задача организации, в особенности же консультация с широким активом \r\nспособствует подготовки и реализации дальнейших направлений развития.   </p>
305	<p>Идейные соображения высшего порядка, а также новая модель \r\nорганизационной деятельности позволяет оценить значение системы обучения\r\n кадров, соответствует насущным потребностям.       \r\n   Повседневная практика показывает, что начало повседневной работы по \r\nформированию позиции позволяет выполнять важные задания по разработке \r\nсущественных финансовых и административных условий.       \r\n   Идейные соображения высшего порядка, а также постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности \r\nспособствует подготовки и реализации форм развития.       \r\n   Значимость этих проблем настолько очевидна, что консультация с \r\nшироким активом способствует подготовки и реализации существенных \r\nфинансовых и административных условий.       \r\n   Товарищи! постоянное информационно-пропагандистское обеспечение нашей\r\n деятельности играет важную роль в формировании новых предложений.      \r\n \r\n   Таким образом реализация намеченных плановых заданий представляет \r\nсобой интересный эксперимент проверки направлений прогрессивного \r\nразвития.</p>
318	<p>Идейные соображения высшего порядка, а также рамки и место обучения \r\nкадров обеспечивает широкому кругу (специалистов) участие в формировании\r\n соответствующий условий активизации.       \r\n   Не следует, однако забывать, что новая модель организационной \r\nдеятельности требуют определения и уточнения соответствующий условий \r\nактивизации.       \r\n   Идейные соображения высшего порядка, а также новая модель \r\nорганизационной деятельности влечет за собой процесс внедрения и \r\nмодернизации новых предложений.       \r\n   Равным образом реализация намеченных плановых заданий требуют от нас \r\nанализа направлений прогрессивного развития.       \r\n   Идейные соображения высшего порядка, а также начало повседневной \r\nработы по формированию позиции позволяет оценить значение существенных \r\nфинансовых и административных условий.       \r\n   Идейные соображения высшего порядка, а также постоянный \r\nколичественный рост и сфера нашей активности позволяет оценить значение \r\nмодели развития.</p>
316	<p>\r\n    \r\n   Повседневная практика показывает, что новая модель организационной \r\nдеятельности способствует подготовки и реализации существенных \r\nфинансовых и административных условий.       \r\n   Товарищи! начало повседневной работы по формированию позиции \r\nспособствует подготовки и реализации систем массового участия.       \r\n   Разнообразный и богатый опыт постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности \r\nспособствует подготовки и реализации новых предложений.       \r\n   Разнообразный и богатый опыт начало повседневной работы по \r\nформированию позиции представляет собой интересный эксперимент проверки \r\nформ развития.   </p>
328	<p "="">\r\n    \r\n   Таким образом реализация намеченных плановых заданий позволяет \r\nвыполнять важные задания по разработке соответствующий условий \r\nактивизации.       \r\n   Значимость этих проблем настолько очевидна, что сложившаяся структура\r\n организации позволяет оценить значение позиций, занимаемых участниками в\r\n отношении поставленных задач.       \r\n   Задача организации, в особенности же реализация намеченных плановых \r\nзаданий влечет за собой процесс внедрения и модернизации систем \r\nмассового участия.   </p>
336	<p "="">Не следует, однако забывать, что рамки и место обучения кадров \r\nтребуют от нас анализа систем массового участия.       \r\n   Разнообразный и богатый опыт новая модель организационной \r\nдеятельности обеспечивает широкому кругу (специалистов) участие в \r\nформировании систем массового участия.       \r\n   Значимость этих проблем настолько очевидна, что рамки и место \r\nобучения кадров позволяет оценить значение существенных финансовых и \r\nадминистративных условий.       \r\n   Идейные соображения высшего порядка, а также укрепление и развитие \r\nструктуры в значительной степени обуславливает создание направлений \r\nпрогрессивного развития.       \r\n   Значимость этих проблем настолько очевидна, что сложившаяся структура\r\n организации позволяет выполнять важные задания по разработке дальнейших\r\n направлений развития.       \r\n   Задача организации, в особенности же укрепление и развитие структуры \r\nтребуют определения и уточнения модели развития.   </p><p>\r\n    \r\n   Таким образом постоянное информационно-пропагандистское обеспечение \r\nнашей деятельности требуют от нас анализа системы обучения кадров, \r\nсоответствует насущным потребностям.       \r\n   Разнообразный и богатый опыт начало повседневной работы по \r\nформированию позиции играет важную роль в формировании системы обучения \r\nкадров, соответствует насущным потребностям.       \r\n   Таким образом постоянное информационно-пропагандистское обеспечение \r\nнашей деятельности требуют от нас анализа модели развития.   </p><p "="">\r\n    \r\n   Товарищи! рамки и место обучения кадров играет важную роль в \r\nформировании систем массового участия.       \r\n   Значимость этих проблем настолько очевидна, что новая модель \r\nорганизационной деятельности требуют от нас анализа модели развития.    \r\n   \r\n   Разнообразный и богатый опыт рамки и место обучения кадров требуют \r\nопределения и уточнения модели развития.       \r\n   Повседневная практика показывает, что дальнейшее развитие различных \r\nформ деятельности влечет за собой процесс внедрения и модернизации \r\nдальнейших направлений развития.       \r\n   Равным образом дальнейшее развитие различных форм деятельности \r\nпредставляет собой интересный эксперимент проверки системы обучения \r\nкадров, соответствует насущным потребностям.       \r\n   Задача организации, в особенности же новая модель организационной \r\nдеятельности позволяет оценить значение позиций, занимаемых участниками в\r\n отношении поставленных задач   </p>
337	<p "="">Таким образом рамки и место обучения кадров позволяет оценить \r\nзначение систем массового участия.       \r\n   Равным образом дальнейшее развитие различных форм деятельности \r\nпредставляет собой интересный эксперимент проверки позиций, занимаемых \r\nучастниками в отношении поставленных задач.       \r\n   Повседневная практика показывает, что реализация намеченных плановых \r\nзаданий позволяет выполнять важные задания по разработке дальнейших \r\nнаправлений развития.   </p><p>\r\n    \r\n   Повседневная практика показывает, что укрепление и развитие структуры\r\n влечет за собой процесс внедрения и модернизации модели развития.      \r\n \r\n   С другой стороны постоянное информационно-пропагандистское \r\nобеспечение нашей деятельности представляет собой интересный эксперимент\r\n проверки позиций, занимаемых участниками в отношении поставленных \r\nзадач.   </p><p>\r\n    \r\n   Значимость этих проблем настолько очевидна, что постоянное \r\nинформационно-пропагандистское обеспечение нашей деятельности \r\nобеспечивает широкому кругу (специалистов) участие в формировании форм \r\nразвития.       \r\n   Задача организации, в особенности же начало повседневной работы по \r\nформированию позиции в значительной степени обуславливает создание \r\nсистемы обучения кадров, соответствует насущным потребностям.   </p><p><br></p><p><br></p>
\.


--
-- Data for Name: unit_measurement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.unit_measurement (unit_id, title) FROM stdin;
1	pcs.
\.


--
-- Data for Name: variant; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.variant (variant_id, product_id, sku, cases, created_at, deleted_at, size) FROM stdin;
1208	155	pink-with-girl-iPhone 7	{612}	2017-04-24 06:52:37.54234+00	\N	{}
1264	169	ipad-case-pink-iPad Air 2/ Air	{616}	2017-04-24 09:40:32.990145+00	\N	{}
1209	155	pink-with-girl-iPhone 7 plus	{613}	2017-04-24 06:52:37.54234+00	\N	{}
1210	155	pink-with-girl-iPhone 6	{614}	2017-04-24 06:52:37.54234+00	\N	{}
1265	169	ipad-case-pink-iPad mini 3/ mini 2/ mini	{617}	2017-04-24 09:40:32.990145+00	\N	{}
1211	155	pink-with-girl-iPhone 5/5s	{615}	2017-04-24 06:52:37.54234+00	\N	{}
1212	156	santa-matrioshka-iPhone 7	{612}	2017-04-24 06:53:34.016006+00	\N	{}
1266	169	ipad-case-pink-iPad 4/ 3/ 2	{618}	2017-04-24 09:40:32.990145+00	\N	{}
1213	156	santa-matrioshka-iPhone 7 plus	{613}	2017-04-24 06:53:34.016006+00	\N	{}
1214	156	santa-matrioshka-iPhone 6	{614}	2017-04-24 06:53:34.016006+00	\N	{}
1267	170	ipad-case-gray-iPad Air 2/ Air	{616}	2017-04-24 10:15:11.313738+00	\N	{}
1215	156	santa-matrioshka-iPhone 5/5s	{615}	2017-04-24 06:53:34.016006+00	\N	{}
1216	157	iphone-notebook-iPhone 7	{612}	2017-04-24 06:56:47.370326+00	\N	{}
1268	170	ipad-case-gray-iPad mini 3/ mini 2/ mini	{617}	2017-04-24 10:15:11.313738+00	\N	{}
1217	157	iphone-notebook-iPhone 7 plus	{613}	2017-04-24 06:56:47.370326+00	\N	{}
1218	157	iphone-notebook-iPhone 6	{614}	2017-04-24 06:56:47.370326+00	\N	{}
1269	170	ipad-case-gray-iPad 4/ 3/ 2	{618}	2017-04-24 10:15:11.313738+00	\N	{}
1219	157	iphone-notebook-iPhone 5/5s	{615}	2017-04-24 06:56:47.370326+00	\N	{}
1220	158	iphone-case-cake-iPhone 7	{612}	2017-04-24 07:36:04.657084+00	\N	{}
1270	171	ipad-case-turquoise-iPad Air 2/ Air	{616}	2017-04-24 10:22:06.029276+00	\N	{}
1221	158	iphone-case-cake-iPhone 7 plus	{613}	2017-04-24 07:36:04.657084+00	\N	{}
1222	158	iphone-case-cake-iPhone 6	{614}	2017-04-24 07:36:04.657084+00	\N	{}
1271	171	ipad-case-turquoise-iPad mini 3/ mini 2/ mini	{617}	2017-04-24 10:22:06.029276+00	\N	{}
1223	158	iphone-case-cake-iPhone 5/5s	{615}	2017-04-24 07:36:04.657084+00	\N	{}
1224	159	girl-with-cake-iPhone 7	{612}	2017-04-24 07:39:41.506441+00	\N	{}
1272	171	ipad-case-turquoise-iPad 4/ 3/ 2	{618}	2017-04-24 10:22:06.029276+00	\N	{}
1225	159	girl-with-cake-iPhone 7 plus	{613}	2017-04-24 07:39:41.506441+00	\N	{}
1226	159	girl-with-cake-iPhone 6	{614}	2017-04-24 07:39:41.506441+00	\N	{}
1273	172	ipad-case-black-iPad Air 2/ Air	{616}	2017-04-24 10:29:08.472579+00	\N	{}
1227	159	girl-with-cake-iPhone 5/5s	{615}	2017-04-24 07:39:41.506441+00	\N	{}
1274	172	ipad-case-black-iPad mini 3/ mini 2/ mini	{617}	2017-04-24 10:29:08.472579+00	\N	{}
1275	172	ipad-case-black-iPad 4/ 3/ 2	{618}	2017-04-24 10:29:08.472579+00	\N	{}
1232	161	strength-above-all-iPhone 7	{612}	2017-04-24 07:45:46.217039+00	\N	{}
1233	161	strength-above-all-iPhone 7 plus	{613}	2017-04-24 07:45:46.217039+00	\N	{}
1234	161	strength-above-all-iPhone 6	{614}	2017-04-24 07:45:46.217039+00	\N	{}
1235	161	strength-above-all-iPhone 5/5s	{615}	2017-04-24 07:45:46.217039+00	\N	{}
1236	162	iphone-case-fuck-iPhone 7	{612}	2017-04-24 07:52:21.330354+00	\N	{}
1237	162	iphone-case-fuck-iPhone 7 plus	{613}	2017-04-24 07:52:21.330354+00	\N	{}
1238	162	iphone-case-fuck-iPhone 6	{614}	2017-04-24 07:52:21.330354+00	\N	{}
1239	162	iphone-case-fuck-iPhone 5/5s	{615}	2017-04-24 07:52:21.330354+00	\N	{}
1240	163	the-amity-affliction-iPhone 7	{612}	2017-04-24 07:54:50.260486+00	\N	{}
1241	163	the-amity-affliction-iPhone 7 plus	{613}	2017-04-24 07:54:50.260486+00	\N	{}
1242	163	the-amity-affliction-iPhone 6	{614}	2017-04-24 07:54:50.260486+00	\N	{}
1243	163	the-amity-affliction-iPhone 5/5s	{615}	2017-04-24 07:54:50.260486+00	\N	{}
1244	164	iphone-case-red-iPhone 7	{612}	2017-04-24 07:59:55.42197+00	\N	{}
1245	164	iphone-case-red-iPhone 7 plus	{613}	2017-04-24 07:59:55.42197+00	\N	{}
1246	164	iphone-case-red-iPhone 6	{614}	2017-04-24 07:59:55.42197+00	\N	{}
1283	176	stc-008-Galaxy S7	{622}	2017-04-24 10:48:12.67986+00	\N	{}
1247	164	iphone-case-red-iPhone 5/5s	{615}	2017-04-24 07:59:55.42197+00	\N	{}
1248	165	iphone-case-explorer-wanted-iPhone 7	{612}	2017-04-24 08:03:19.267605+00	\N	{}
1249	165	iphone-case-explorer-wanted-iPhone 7 plus	{613}	2017-04-24 08:03:19.267605+00	\N	{}
1250	165	iphone-case-explorer-wanted-iPhone 6	{614}	2017-04-24 08:03:19.267605+00	\N	{}
1251	165	iphone-case-explorer-wanted-iPhone 5/5s	{615}	2017-04-24 08:03:19.267605+00	\N	{}
1252	166	iphone-case-cakes-and-girl-iPhone 7	{612}	2017-04-24 08:08:56.14141+00	\N	{}
1253	166	iphone-case-cakes-and-girl-iPhone 7 plus	{613}	2017-04-24 08:08:56.14141+00	\N	{}
1254	166	iphone-case-cakes-and-girl-iPhone 6	{614}	2017-04-24 08:08:56.14141+00	\N	{}
1255	166	iphone-case-cakes-and-girl-iPhone 5/5s	{615}	2017-04-24 08:08:56.14141+00	\N	{}
1256	167	iphone-case-blonde-with-wineglass-iPhone 7	{612}	2017-04-24 08:11:48.922006+00	\N	{}
1257	167	iphone-case-blonde-with-wineglass-iPhone 7 plus	{613}	2017-04-24 08:11:48.922006+00	\N	{}
1258	167	iphone-case-blonde-with-wineglass-iPhone 6	{614}	2017-04-24 08:11:48.922006+00	\N	{}
1259	167	iphone-case-blonde-with-wineglass-iPhone 5/5s	{615}	2017-04-24 08:11:48.922006+00	\N	{}
1260	168	iphone-case-lovely-girl-iPhone 7	{612}	2017-04-24 08:13:41.148279+00	\N	{}
1277	173	SCC-001-Galaxy S7	{622}	2017-04-24 10:43:00.019561+00	\N	{}
1278	174	SOB-002-Galaxy S7	{622}	2017-04-24 10:43:31.258258+00	\N	{}
1279	174	SOB-002-Galaxy A	{623}	2017-04-24 10:43:31.258258+00	\N	{}
1280	175	SPK-003-Galaxy S7	{622}	2017-04-24 10:45:52.246114+00	\N	{}
1281	175	SPK-003-Galaxy A	{623}	2017-04-24 10:45:52.246114+00	\N	{}
1282	176	stc-008-Galaxy S7 Edge	{621}	2017-04-24 10:48:12.67986+00	\N	{}
1261	168	iphone-case-lovely-girl-iPhone 7 plus	{613}	2017-04-24 08:13:41.148279+00	\N	{}
1262	168	iphone-case-lovely-girl-iPhone 6	{614}	2017-04-24 08:13:41.148279+00	\N	{}
1263	168	iphone-case-lovely-girl-iPhone 5/5s	{615}	2017-04-24 08:13:41.148279+00	\N	{}
1284	176	stc-008-Galaxy A	{623}	2017-04-24 10:48:12.67986+00	\N	{}
1276	173	SCC-001-Galaxy S8	{619}	2017-04-24 10:43:00.019561+00	\N	{}
1285	177	sob-008-Galaxy S8+	{620}	2017-04-24 10:51:29.307537+00	\N	{}
1286	177	sob-008-Galaxy S7 Edge	{621}	2017-04-24 10:51:29.307537+00	\N	{}
1287	177	sob-008-Galaxy S7	{622}	2017-04-24 10:51:29.307537+00	\N	{}
\.


--
-- Data for Name: variant_image; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.variant_image (variant_image_id, variant_id, image_id, is_default, created_at) FROM stdin;
\.


--
-- Data for Name: variant_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.variant_text (variant_id, lang_id, title) FROM stdin;
1208	1	iPhone 7
1264	1	iPad Air 2/ Air
1209	1	iPhone 7 plus
1210	1	iPhone 6
1265	1	iPad mini 3/ mini 2/ mini
1211	1	iPhone 5/5s
1212	1	iPhone 7
1266	1	iPad 4/ 3/ 2
1213	1	iPhone 7 plus
1214	1	iPhone 6
1267	1	iPad Air 2/ Air
1215	1	iPhone 5/5s
1216	1	iPhone 7
1268	1	iPad mini 3/ mini 2/ mini
1217	1	iPhone 7 plus
1218	1	iPhone 6
1269	1	iPad 4/ 3/ 2
1219	1	iPhone 5/5s
1220	1	iPhone 7
1270	1	iPad Air 2/ Air
1221	1	iPhone 7 plus
1222	1	iPhone 6
1271	1	iPad mini 3/ mini 2/ mini
1223	1	iPhone 5/5s
1224	1	iPhone 7
1272	1	iPad 4/ 3/ 2
1225	1	iPhone 7 plus
1226	1	iPhone 6
1273	1	iPad Air 2/ Air
1227	1	iPhone 5/5s
1274	1	iPad mini 3/ mini 2/ mini
1275	1	iPad 4/ 3/ 2
1232	1	iPhone 7
1276	1	Galaxy S8
1233	1	iPhone 7 plus
1234	1	iPhone 6
1277	1	Galaxy S7
1235	1	iPhone 5/5s
1236	1	iPhone 7
1278	1	Galaxy S7
1237	1	iPhone 7 plus
1238	1	iPhone 6
1279	1	Galaxy A
1239	1	iPhone 5/5s
1240	1	iPhone 7
1280	1	Galaxy S7
1241	1	iPhone 7 plus
1242	1	iPhone 6
1281	1	Galaxy A
1243	1	iPhone 5/5s
1244	1	iPhone 7
1282	1	Galaxy S7 Edge
1245	1	iPhone 7 plus
1246	1	iPhone 6
1283	1	Galaxy S7
1247	1	iPhone 5/5s
1248	1	iPhone 7
1249	1	iPhone 7 plus
1250	1	iPhone 6
1251	1	iPhone 5/5s
1252	1	iPhone 7
1253	1	iPhone 7 plus
1254	1	iPhone 6
1255	1	iPhone 5/5s
1256	1	iPhone 7
1257	1	iPhone 7 plus
1258	1	iPhone 6
1259	1	iPhone 5/5s
1260	1	iPhone 7
1261	1	iPhone 7 plus
1262	1	iPhone 6
1263	1	iPhone 5/5s
1284	1	Galaxy A
1285	1	Galaxy S8+
1286	1	Galaxy S7 Edge
1287	1	Galaxy S7
\.


--
-- Data for Name: warehouse; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.warehouse (warehouse_id, sort, created_at, deleted_at) FROM stdin;
14	10	2017-04-23 10:34:58.726685+00	\N
15	20	2017-04-23 10:35:14.002744+00	\N
\.


--
-- Data for Name: warehouse_text; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.warehouse_text (warehouse_id, lang_id, title, address) FROM stdin;
14	1	In the office	32 South Bedford Dr. Oxnard, CA 93030
15	1	Warehouse A	882 Golf Rd. Lompoc, CA 93436
\.


--
-- Data for Name: webhook; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.webhook (webhook_id, url, name, secret) FROM stdin;
\.


--
-- Data for Name: webhook_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.webhook_log (webhook_log_id, webhook_id, status_code, created_at) FROM stdin;
\.


--
-- Name: admin_comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_comment_comment_id_seq', 1, false);


--
-- Name: api_file_uploader_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.api_file_uploader_id_seq', 1, false);


--
-- Name: api_token_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.api_token_token_id_seq', 1, false);


--
-- Name: article_article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.article_article_id_seq', 3, true);


--
-- Name: auth_resource_resource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_resource_resource_id_seq', 325, true);


--
-- Name: auth_rule_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_rule_rule_id_seq', 118, true);


--
-- Name: auth_task_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_task_task_id_seq', 9, true);


--
-- Name: basket_basket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.basket_basket_id_seq', 110, true);


--
-- Name: basket_item_basket_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.basket_item_basket_item_id_seq', 499, true);


--
-- Name: box_box_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.box_box_id_seq', 4, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.category_category_id_seq', 114, true);


--
-- Name: characteristic_characteristic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.characteristic_characteristic_id_seq', 152166, true);


--
-- Name: characteristic_product_val_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.characteristic_product_val_value_id_seq', 1293, true);


--
-- Name: characteristic_type_case_case_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.characteristic_type_case_case_id_seq', 623, true);


--
-- Name: characteristic_variant_val_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.characteristic_variant_val_value_id_seq', 4466, true);


--
-- Name: collection_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.collection_collection_id_seq', 3, true);


--
-- Name: collection_product_rel_rel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.collection_product_rel_rel_id_seq', 50, true);


--
-- Name: commodity_group_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.commodity_group_group_id_seq', 62, true);


--
-- Name: consumed_space_space_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.consumed_space_space_id_seq', 1, false);


--
-- Name: coupon_campaign_campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_campaign_campaign_id_seq', 1, false);


--
-- Name: coupon_code_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_code_code_id_seq', 1, false);


--
-- Name: cross_sell_category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cross_sell_category_category_id_seq', 2, true);


--
-- Name: cross_sell_cross_sell_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cross_sell_cross_sell_id_seq', 216, true);


--
-- Name: currency_currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.currency_currency_id_seq', 242, true);


--
-- Name: custom_item_custom_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.custom_item_custom_item_id_seq', 1, false);


--
-- Name: customer_group_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_group_group_id_seq', 1, true);


--
-- Name: delivery_city_delivery_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_city_delivery_city_id_seq', 18, true);


--
-- Name: delivery_country_delivery_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_country_delivery_country_id_seq', 9, true);


--
-- Name: delivery_delivery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_delivery_id_seq', 24, true);


--
-- Name: essence_essence_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.essence_essence_id_seq', 1, false);


--
-- Name: feeds_feed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.feeds_feed_id_seq', 1, false);


--
-- Name: filter_field_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.filter_field_field_id_seq', 52, true);


--
-- Name: filter_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.filter_filter_id_seq', 9, true);


--
-- Name: image_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.image_image_id_seq', 300, true);


--
-- Name: image_tag_image_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.image_tag_image_tag_id_seq', 1, false);


--
-- Name: inventory_item_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_item_item_id_seq', 3651, true);


--
-- Name: inventory_location_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_location_location_id_seq', 1124, true);


--
-- Name: inventory_movement_item_movement_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_movement_item_movement_item_id_seq', 1238, true);


--
-- Name: inventory_movement_movement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_movement_movement_id_seq', 1401, true);


--
-- Name: inventory_option_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_option_option_id_seq', 15, true);


--
-- Name: inventory_stock_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_stock_stock_id_seq', 1568, true);


--
-- Name: inventory_supply_supply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_supply_supply_id_seq', 1, false);


--
-- Name: item_price_item_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.item_price_item_price_id_seq', 558, true);


--
-- Name: label_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.label_label_id_seq', 4, true);


--
-- Name: lang_lang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lang_lang_id_seq', 3, true);


--
-- Name: manufacturer_manufacturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.manufacturer_manufacturer_id_seq', 35, true);


--
-- Name: menu_block_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menu_block_block_id_seq', 7, true);


--
-- Name: menu_item_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.menu_item_item_id_seq', 40, true);


--
-- Name: notification_history_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notification_history_notification_id_seq', 1, false);


--
-- Name: notification_template_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notification_template_template_id_seq', 1, true);


--
-- Name: offer_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.offer_offer_id_seq', 1, false);


--
-- Name: order_attrs_attr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_attrs_attr_id_seq', 1, false);


--
-- Name: order_discount_discount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_discount_discount_id_seq', 1, false);


--
-- Name: order_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_history_history_id_seq', 1, false);


--
-- Name: order_service_order_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_service_order_service_id_seq', 62, true);


--
-- Name: order_source_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_source_source_id_seq', 5, true);


--
-- Name: order_status_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_status_status_id_seq', 16, true);


--
-- Name: order_track_number_track_number_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_track_number_track_number_id_seq', 7, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 1, false);


--
-- Name: page_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.page_page_id_seq', 25, true);


--
-- Name: payment_callback_payment_callback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_callback_payment_callback_id_seq', 1, false);


--
-- Name: payment_method_payment_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_method_payment_method_id_seq', 1, true);


--
-- Name: payment_request_payment_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_request_payment_request_id_seq', 1, false);


--
-- Name: payment_transaction_payment_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_transaction_payment_transaction_id_seq', 1, false);


--
-- Name: person_address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.person_address_address_id_seq', 1, false);


--
-- Name: person_attrs_attr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.person_attrs_attr_id_seq', 1, false);


--
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.person_person_id_seq', 2, false);


--
-- Name: person_token_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.person_token_token_id_seq', 8467, true);


--
-- Name: point_sale_point_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.point_sale_point_id_seq', 741, true);


--
-- Name: price_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.price_price_id_seq', 8, true);


--
-- Name: product_image_product_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_image_product_image_id_seq', 195, true);


--
-- Name: product_import_imgs_import_img_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_import_imgs_import_img_id_seq', 1, false);


--
-- Name: product_import_import_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_import_import_id_seq', 1, false);


--
-- Name: product_import_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_import_log_log_id_seq', 1, false);


--
-- Name: product_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_product_id_seq', 1, false);


--
-- Name: product_product_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_product_id_seq1', 181, true);


--
-- Name: product_review_img_review_img_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_review_img_review_img_id_seq', 1, false);


--
-- Name: product_review_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_review_review_id_seq', 1, false);


--
-- Name: product_variant_characteristic_rel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_variant_characteristic_rel_id_seq', 633, true);


--
-- Name: reserve_item_reserve_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reserve_item_reserve_item_id_seq', 1, false);


--
-- Name: reserve_item_reserve_item_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reserve_item_reserve_item_id_seq1', 518, true);


--
-- Name: reserve_reserve_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reserve_reserve_id_seq', 97, true);


--
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.role_role_id_seq', 6, true);


--
-- Name: route_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.route_route_id_seq', 1, false);


--
-- Name: service_service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.service_service_id_seq', 3, true);


--
-- Name: setting_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.setting_setting_id_seq', 1048, true);


--
-- Name: site_delivery_site_delivery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.site_delivery_site_delivery_id_seq', 25, true);


--
-- Name: site_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.site_site_id_seq', 1, true);


--
-- Name: stream_stream_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stream_stream_id_seq', 1, false);


--
-- Name: tax_class_tax_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tax_class_tax_class_id_seq', 1, true);


--
-- Name: tax_rate_tax_rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tax_rate_tax_rate_id_seq', 1, true);


--
-- Name: theme_installed_installed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.theme_installed_installed_id_seq', 3, true);


--
-- Name: transfer_item_transfer_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transfer_item_transfer_item_id_seq', 1, false);


--
-- Name: transfer_transfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transfer_transfer_id_seq', 1, false);


--
-- Name: typearea_block_block_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.typearea_block_block_id_seq', 339, true);


--
-- Name: typearea_typearea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.typearea_typearea_id_seq', 226, true);


--
-- Name: unit_measurement_unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.unit_measurement_unit_id_seq', 1, true);


--
-- Name: variant_image_variant_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.variant_image_variant_image_id_seq', 1, false);


--
-- Name: variant_variant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.variant_variant_id_seq', 1287, true);


--
-- Name: warehouse_warehouse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.warehouse_warehouse_id_seq', 15, true);


--
-- Name: webhook_log_webhook_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.webhook_log_webhook_log_id_seq', 1, false);


--
-- Name: webhook_webhook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.webhook_webhook_id_seq', 1, false);


--
-- Name: admin_comment admin_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_comment
    ADD CONSTRAINT admin_comment_pkey PRIMARY KEY (comment_id);


--
-- Name: api_file_uploader api_file_uploader_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_file_uploader
    ADD CONSTRAINT api_file_uploader_pkey PRIMARY KEY (id);


--
-- Name: api_token api_token_client_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_token
    ADD CONSTRAINT api_token_client_id_key UNIQUE (client_id);


--
-- Name: api_token api_token_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_token
    ADD CONSTRAINT api_token_name_key UNIQUE (name);


--
-- Name: api_token api_token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_token
    ADD CONSTRAINT api_token_pkey PRIMARY KEY (token_id);


--
-- Name: article article_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_pkey PRIMARY KEY (article_id);


--
-- Name: auth_resource auth_resource_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_resource
    ADD CONSTRAINT auth_resource_alias_key UNIQUE (alias);


--
-- Name: auth_resource auth_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_resource
    ADD CONSTRAINT auth_resource_pkey PRIMARY KEY (resource_id);


--
-- Name: auth_rule auth_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT auth_rule_pkey PRIMARY KEY (rule_id);


--
-- Name: auth_task auth_task_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_task
    ADD CONSTRAINT auth_task_pkey PRIMARY KEY (task_id);


--
-- Name: auth_task auth_task_resource_id_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_task
    ADD CONSTRAINT auth_task_resource_id_alias_key UNIQUE (resource_id, alias);


--
-- Name: basket_item basket_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_item
    ADD CONSTRAINT basket_item_pkey PRIMARY KEY (basket_item_id);


--
-- Name: basket basket_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket
    ADD CONSTRAINT basket_pkey PRIMARY KEY (basket_id);


--
-- Name: basket basket_public_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket
    ADD CONSTRAINT basket_public_id_key UNIQUE (public_id);


--
-- Name: box box_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.box
    ADD CONSTRAINT box_pkey PRIMARY KEY (box_id);


--
-- Name: box_text box_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.box_text
    ADD CONSTRAINT box_text_pkey PRIMARY KEY (box_id, lang_id);


--
-- Name: category category_external_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_external_id_key UNIQUE (external_id);


--
-- Name: category_menu_rel category_menu_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_menu_rel
    ADD CONSTRAINT category_menu_rel_pkey PRIMARY KEY (category_id, block_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: category_prop category_prop_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_prop
    ADD CONSTRAINT category_prop_pkey PRIMARY KEY (category_id);


--
-- Name: category_text category_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_text
    ADD CONSTRAINT category_text_pkey PRIMARY KEY (category_id, lang_id);


--
-- Name: characteristic characteristic_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic
    ADD CONSTRAINT characteristic_pkey PRIMARY KEY (characteristic_id);


--
-- Name: characteristic_product_val characteristic_product_val_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_product_val
    ADD CONSTRAINT characteristic_product_val_pkey PRIMARY KEY (value_id);


--
-- Name: characteristic_product_val_text characteristic_product_val_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_product_val_text
    ADD CONSTRAINT characteristic_product_val_text_pkey PRIMARY KEY (value_id, lang_id);


--
-- Name: characteristic_prop characteristic_prop_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_prop
    ADD CONSTRAINT characteristic_prop_pkey PRIMARY KEY (characteristic_id);


--
-- Name: characteristic_text characteristic_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_text
    ADD CONSTRAINT characteristic_text_pkey PRIMARY KEY (characteristic_id, lang_id);


--
-- Name: characteristic_type_case characteristic_type_case_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_type_case
    ADD CONSTRAINT characteristic_type_case_pkey PRIMARY KEY (case_id);


--
-- Name: characteristic_type_case_text characteristic_type_case_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_type_case_text
    ADD CONSTRAINT characteristic_type_case_text_pkey PRIMARY KEY (case_id, lang_id);


--
-- Name: characteristic_variant_val characteristic_variant_val_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_variant_val
    ADD CONSTRAINT characteristic_variant_val_pkey PRIMARY KEY (value_id);


--
-- Name: characteristic_variant_val_text characteristic_variant_val_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_variant_val_text
    ADD CONSTRAINT characteristic_variant_val_text_pkey PRIMARY KEY (value_id, lang_id);


--
-- Name: collection collection_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_pkey PRIMARY KEY (collection_id);


--
-- Name: collection_product_rel collection_product_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_product_rel
    ADD CONSTRAINT collection_product_rel_pkey PRIMARY KEY (rel_id);


--
-- Name: commodity_group commodity_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commodity_group
    ADD CONSTRAINT commodity_group_pkey PRIMARY KEY (group_id);


--
-- Name: commodity_group_text commodity_group_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commodity_group_text
    ADD CONSTRAINT commodity_group_text_pkey PRIMARY KEY (group_id, lang_id);


--
-- Name: consumed_space consumed_space_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consumed_space
    ADD CONSTRAINT consumed_space_pkey PRIMARY KEY (space_id);


--
-- Name: coupon_campaign coupon_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_campaign
    ADD CONSTRAINT coupon_campaign_pkey PRIMARY KEY (campaign_id);


--
-- Name: coupon_code coupon_code_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_code
    ADD CONSTRAINT coupon_code_code_key UNIQUE (code);


--
-- Name: coupon_code coupon_code_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_code
    ADD CONSTRAINT coupon_code_pkey PRIMARY KEY (code_id);


--
-- Name: cross_sell_category cross_sell_category_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell_category
    ADD CONSTRAINT cross_sell_category_alias_key UNIQUE (alias);


--
-- Name: cross_sell cross_sell_category_id_product_id_rel_product_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell
    ADD CONSTRAINT cross_sell_category_id_product_id_rel_product_id_key UNIQUE (category_id, product_id, rel_product_id);


--
-- Name: cross_sell_category cross_sell_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell_category
    ADD CONSTRAINT cross_sell_category_pkey PRIMARY KEY (category_id);


--
-- Name: cross_sell cross_sell_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell
    ADD CONSTRAINT cross_sell_pkey PRIMARY KEY (cross_sell_id);


--
-- Name: currency currency_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_alias_key UNIQUE (alias);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (currency_id);


--
-- Name: custom_item custom_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.custom_item
    ADD CONSTRAINT custom_item_pkey PRIMARY KEY (custom_item_id);


--
-- Name: customer_group customer_group_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group
    ADD CONSTRAINT customer_group_alias_key UNIQUE (alias);


--
-- Name: customer_group customer_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group
    ADD CONSTRAINT customer_group_pkey PRIMARY KEY (group_id);


--
-- Name: delivery delivery_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery
    ADD CONSTRAINT delivery_alias_key UNIQUE (alias);


--
-- Name: delivery_city delivery_city_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_city
    ADD CONSTRAINT delivery_city_pkey PRIMARY KEY (delivery_city_id);


--
-- Name: delivery_city delivery_city_site_delivery_id_city_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_city
    ADD CONSTRAINT delivery_city_site_delivery_id_city_id_key UNIQUE (delivery_site_id, city_id);


--
-- Name: delivery_country delivery_country_delivery_site_id_country_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_country
    ADD CONSTRAINT delivery_country_delivery_site_id_country_id_key UNIQUE (delivery_site_id, country_id);


--
-- Name: delivery_country delivery_country_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_country
    ADD CONSTRAINT delivery_country_pkey PRIMARY KEY (delivery_country_id);


--
-- Name: delivery_exclude_city delivery_exclude_city_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_exclude_city
    ADD CONSTRAINT delivery_exclude_city_pkey PRIMARY KEY (delivery_site_id, city_id);


--
-- Name: delivery delivery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery
    ADD CONSTRAINT delivery_pkey PRIMARY KEY (delivery_id);


--
-- Name: essence essence_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.essence
    ADD CONSTRAINT essence_pkey PRIMARY KEY (essence_id);


--
-- Name: feeds feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feeds
    ADD CONSTRAINT feeds_pkey PRIMARY KEY (feed_id);


--
-- Name: filter_field filter_field_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filter_field
    ADD CONSTRAINT filter_field_pkey PRIMARY KEY (field_id);


--
-- Name: filter filter_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filter
    ADD CONSTRAINT filter_pkey PRIMARY KEY (filter_id);


--
-- Name: final_price final_price_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.final_price
    ADD CONSTRAINT final_price_pkey PRIMARY KEY (point_id, item_id, price_id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (image_id);


--
-- Name: image_tag image_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_tag
    ADD CONSTRAINT image_tag_pkey PRIMARY KEY (image_tag_id);


--
-- Name: image_tag_rel image_tag_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_tag_rel
    ADD CONSTRAINT image_tag_rel_pkey PRIMARY KEY (image_tag_id, product_image_id);


--
-- Name: inventory_item inventory_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT inventory_item_pkey PRIMARY KEY (item_id);


--
-- Name: inventory_location inventory_location_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_location
    ADD CONSTRAINT inventory_location_pkey PRIMARY KEY (location_id);


--
-- Name: inventory_movement_item inventory_movement_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement_item
    ADD CONSTRAINT inventory_movement_item_pkey PRIMARY KEY (movement_item_id);


--
-- Name: inventory_movement inventory_movement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement
    ADD CONSTRAINT inventory_movement_pkey PRIMARY KEY (movement_id);


--
-- Name: inventory_option inventory_option_category_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_option
    ADD CONSTRAINT inventory_option_category_alias_key UNIQUE (category, alias);


--
-- Name: inventory_option inventory_option_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_option
    ADD CONSTRAINT inventory_option_pkey PRIMARY KEY (option_id);


--
-- Name: inventory_option_text inventory_option_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_option_text
    ADD CONSTRAINT inventory_option_text_pkey PRIMARY KEY (option_id, lang_id);


--
-- Name: inventory_price inventory_price_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_price
    ADD CONSTRAINT inventory_price_pkey PRIMARY KEY (item_id, price_id);


--
-- Name: inventory_stock inventory_stock_location_id_item_id_supply_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_stock
    ADD CONSTRAINT inventory_stock_location_id_item_id_supply_id_key UNIQUE (location_id, item_id, supply_id);


--
-- Name: inventory_stock inventory_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_stock
    ADD CONSTRAINT inventory_stock_pkey PRIMARY KEY (stock_id);


--
-- Name: inventory_supply inventory_supply_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_supply
    ADD CONSTRAINT inventory_supply_pkey PRIMARY KEY (supply_id);


--
-- Name: item_price item_price_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_price
    ADD CONSTRAINT item_price_pkey PRIMARY KEY (item_price_id);


--
-- Name: label label_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.label
    ADD CONSTRAINT label_pkey PRIMARY KEY (label_id);


--
-- Name: label_text label_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.label_text
    ADD CONSTRAINT label_text_pkey PRIMARY KEY (label_id, lang_id);


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
-- Name: lang_title lang_title_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lang_title
    ADD CONSTRAINT lang_title_pkey PRIMARY KEY (lang_id, in_lang_id);


--
-- Name: manufacturer manufacturer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_pkey PRIMARY KEY (manufacturer_id);


--
-- Name: manufacturer_text manufacturer_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_text
    ADD CONSTRAINT manufacturer_text_pkey PRIMARY KEY (manufacturer_id, lang_id);


--
-- Name: menu_block menu_block_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_block
    ADD CONSTRAINT menu_block_pkey PRIMARY KEY (block_id);


--
-- Name: menu_item menu_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item
    ADD CONSTRAINT menu_item_pkey PRIMARY KEY (item_id);


--
-- Name: menu_item_rel menu_item_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item_rel
    ADD CONSTRAINT menu_item_rel_pkey PRIMARY KEY (item_id);


--
-- Name: notification_history notification_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_history
    ADD CONSTRAINT notification_history_pkey PRIMARY KEY (notification_id);


--
-- Name: notification_template notification_template_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_template
    ADD CONSTRAINT notification_template_pkey PRIMARY KEY (template_id);


--
-- Name: offer offer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offer
    ADD CONSTRAINT offer_pkey PRIMARY KEY (offer_id);


--
-- Name: order_attrs order_attrs_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_attrs
    ADD CONSTRAINT order_attrs_key_key UNIQUE (key);


--
-- Name: order_attrs order_attrs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_attrs
    ADD CONSTRAINT order_attrs_pkey PRIMARY KEY (attr_id);


--
-- Name: order_attrs order_attrs_title_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_attrs
    ADD CONSTRAINT order_attrs_title_key UNIQUE (title);


--
-- Name: order_discount order_discount_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_discount
    ADD CONSTRAINT order_discount_pkey PRIMARY KEY (discount_id);


--
-- Name: order_history order_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_history
    ADD CONSTRAINT order_history_pkey PRIMARY KEY (history_id);


--
-- Name: order_prop order_prop_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_prop
    ADD CONSTRAINT order_prop_pkey PRIMARY KEY (order_id);


--
-- Name: order_service_delivery order_service_delivery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_service_delivery
    ADD CONSTRAINT order_service_delivery_pkey PRIMARY KEY (order_service_id);


--
-- Name: order_service order_service_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_service
    ADD CONSTRAINT order_service_pkey PRIMARY KEY (order_service_id);


--
-- Name: order_source order_source_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_source
    ADD CONSTRAINT order_source_alias_key UNIQUE (alias);


--
-- Name: order_source order_source_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_source
    ADD CONSTRAINT order_source_pkey PRIMARY KEY (source_id);


--
-- Name: order_status order_status_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_alias_key UNIQUE (alias);


--
-- Name: order_status order_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_pkey PRIMARY KEY (status_id);


--
-- Name: order_status_text order_status_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_status_text
    ADD CONSTRAINT order_status_text_pkey PRIMARY KEY (status_id, lang_id);


--
-- Name: track_number order_track_number_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_number
    ADD CONSTRAINT order_track_number_pkey PRIMARY KEY (track_number_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: orders orders_public_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_public_id_key UNIQUE (public_id);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (page_id);


--
-- Name: page_props page_props_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_props
    ADD CONSTRAINT page_props_pkey PRIMARY KEY (page_id);


--
-- Name: payment_callback payment_callback_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_callback
    ADD CONSTRAINT payment_callback_pkey PRIMARY KEY (payment_callback_id);


--
-- Name: payment_method_delivery payment_method_delivery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method_delivery
    ADD CONSTRAINT payment_method_delivery_pkey PRIMARY KEY (payment_method_id, delivery_site_id);


--
-- Name: payment_method payment_method_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_pkey PRIMARY KEY (payment_method_id);


--
-- Name: payment_method_text payment_method_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method_text
    ADD CONSTRAINT payment_method_text_pkey PRIMARY KEY (payment_method_id, lang_id);


--
-- Name: payment_request payment_request_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_request
    ADD CONSTRAINT payment_request_pkey PRIMARY KEY (payment_request_id);


--
-- Name: payment_transaction payment_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT payment_transaction_pkey PRIMARY KEY (payment_transaction_id);


--
-- Name: person_address person_address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_address
    ADD CONSTRAINT person_address_pkey PRIMARY KEY (address_id);


--
-- Name: person_address person_address_public_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_address
    ADD CONSTRAINT person_address_public_id_key UNIQUE (public_id);


--
-- Name: person_attrs person_attrs_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_attrs
    ADD CONSTRAINT person_attrs_key_key UNIQUE (key);


--
-- Name: person_attrs person_attrs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_attrs
    ADD CONSTRAINT person_attrs_pkey PRIMARY KEY (attr_id);


--
-- Name: person_attrs person_attrs_title_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_attrs
    ADD CONSTRAINT person_attrs_title_key UNIQUE (title);


--
-- Name: person_auth person_auth_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_auth
    ADD CONSTRAINT person_auth_pkey PRIMARY KEY (person_id);


--
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- Name: person_profile person_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_profile
    ADD CONSTRAINT person_profile_pkey PRIMARY KEY (person_id);


--
-- Name: person person_public_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_public_id_key UNIQUE (public_id);


--
-- Name: person_role_rel person_role_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_role_rel
    ADD CONSTRAINT person_role_rel_pkey PRIMARY KEY (person_id, role_id);


--
-- Name: person_search person_search_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_search
    ADD CONSTRAINT person_search_pkey PRIMARY KEY (person_id);


--
-- Name: person_settings person_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_settings
    ADD CONSTRAINT person_settings_pkey PRIMARY KEY (person_id);


--
-- Name: person_token person_token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_token
    ADD CONSTRAINT person_token_pkey PRIMARY KEY (token_id);


--
-- Name: person_visitor person_visitor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_visitor
    ADD CONSTRAINT person_visitor_pkey PRIMARY KEY (person_id);


--
-- Name: point_sale point_sale_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.point_sale
    ADD CONSTRAINT point_sale_pkey PRIMARY KEY (point_id);


--
-- Name: price price_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_alias_key UNIQUE (alias);


--
-- Name: price price_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_pkey PRIMARY KEY (price_id);


--
-- Name: price_text price_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_text
    ADD CONSTRAINT price_text_pkey PRIMARY KEY (price_id, lang_id);


--
-- Name: product_category_rel product_category_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category_rel
    ADD CONSTRAINT product_category_rel_pkey PRIMARY KEY (category_id, product_id);


--
-- Name: product product_external_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_external_id_key UNIQUE (external_id);


--
-- Name: product_image product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_pkey PRIMARY KEY (product_image_id);


--
-- Name: product_image_text product_image_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image_text
    ADD CONSTRAINT product_image_text_pkey PRIMARY KEY (product_image_id, lang_id);


--
-- Name: product_import_imgs product_import_imgs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_imgs
    ADD CONSTRAINT product_import_imgs_pkey PRIMARY KEY (import_img_id);


--
-- Name: product_import_log product_import_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_log
    ADD CONSTRAINT product_import_log_pkey PRIMARY KEY (log_id);


--
-- Name: product_import product_import_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import
    ADD CONSTRAINT product_import_pkey PRIMARY KEY (import_id);


--
-- Name: product_label_rel product_label_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_label_rel
    ADD CONSTRAINT product_label_rel_pkey PRIMARY KEY (label_id, product_id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- Name: product_prop product_prop_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_prop
    ADD CONSTRAINT product_prop_pkey PRIMARY KEY (product_id);


--
-- Name: product_review_img product_review_img_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review_img
    ADD CONSTRAINT product_review_img_pkey PRIMARY KEY (review_img_id);


--
-- Name: product_review product_review_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT product_review_pkey PRIMARY KEY (review_id);


--
-- Name: product product_sku_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_sku_key UNIQUE (sku);


--
-- Name: product_text product_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_text
    ADD CONSTRAINT product_text_pkey PRIMARY KEY (product_id, lang_id);


--
-- Name: product_variant_characteristic product_variant_characteristic_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_characteristic
    ADD CONSTRAINT product_variant_characteristic_pkey PRIMARY KEY (rel_id);


--
-- Name: product_yml product_yml_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_yml
    ADD CONSTRAINT product_yml_pkey PRIMARY KEY (product_id);


--
-- Name: reserve_item reserve_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve_item
    ADD CONSTRAINT reserve_item_pkey PRIMARY KEY (reserve_item_id);


--
-- Name: reserve reserve_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve
    ADD CONSTRAINT reserve_pkey PRIMARY KEY (reserve_id);


--
-- Name: role role_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_alias_key UNIQUE (alias);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- Name: role role_title_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_title_key UNIQUE (title);


--
-- Name: route route_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route
    ADD CONSTRAINT route_pkey PRIMARY KEY (route_id);


--
-- Name: service service_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_alias_key UNIQUE (alias);


--
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (service_id);


--
-- Name: service_text service_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_text
    ADD CONSTRAINT service_text_pkey PRIMARY KEY (service_id, lang_id);


--
-- Name: setting setting_key_setting_group_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_key_setting_group_key UNIQUE (key, setting_group);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (setting_id);


--
-- Name: site_country_lang site_country_lang_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_country_lang
    ADD CONSTRAINT site_country_lang_pkey PRIMARY KEY (site_id, country_id, lang_id);


--
-- Name: delivery_site site_delivery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_site
    ADD CONSTRAINT site_delivery_pkey PRIMARY KEY (delivery_site_id);


--
-- Name: delivery_site site_delivery_site_id_delivery_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_site
    ADD CONSTRAINT site_delivery_site_id_delivery_id_key UNIQUE (site_id, delivery_id);


--
-- Name: site site_host_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site
    ADD CONSTRAINT site_host_key UNIQUE (host);


--
-- Name: site site_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site
    ADD CONSTRAINT site_pkey PRIMARY KEY (site_id);


--
-- Name: stream stream_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stream
    ADD CONSTRAINT stream_pkey PRIMARY KEY (stream_id);


--
-- Name: tax_class tax_class_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_class
    ADD CONSTRAINT tax_class_pkey PRIMARY KEY (tax_class_id);


--
-- Name: tax_rate tax_rate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT tax_rate_pkey PRIMARY KEY (tax_rate_id);


--
-- Name: theme_installed theme_installed_alias_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme_installed
    ADD CONSTRAINT theme_installed_alias_key UNIQUE (alias);


--
-- Name: theme_installed theme_installed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme_installed
    ADD CONSTRAINT theme_installed_pkey PRIMARY KEY (installed_id);


--
-- Name: theme_installed_text theme_installed_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme_installed_text
    ADD CONSTRAINT theme_installed_text_pkey PRIMARY KEY (installed_id, lang_id);


--
-- Name: transfer_item transfer_item_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer_item
    ADD CONSTRAINT transfer_item_pkey PRIMARY KEY (transfer_item_id);


--
-- Name: transfer_item transfer_item_transfer_id_item_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer_item
    ADD CONSTRAINT transfer_item_transfer_id_item_id_key UNIQUE (transfer_id, item_id);


--
-- Name: transfer transfer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer
    ADD CONSTRAINT transfer_pkey PRIMARY KEY (transfer_id);


--
-- Name: typearea_block typearea_block_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typearea_block
    ADD CONSTRAINT typearea_block_pkey PRIMARY KEY (block_id);


--
-- Name: typearea_block_text typearea_block_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typearea_block_text
    ADD CONSTRAINT typearea_block_text_pkey PRIMARY KEY (block_id);


--
-- Name: typearea typearea_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typearea
    ADD CONSTRAINT typearea_pkey PRIMARY KEY (typearea_id);


--
-- Name: auth_rule unique_resource; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT unique_resource UNIQUE (role_id, resource_id);


--
-- Name: auth_rule unique_task; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT unique_task UNIQUE (role_id, task_id);


--
-- Name: unit_measurement unit_measurement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_measurement
    ADD CONSTRAINT unit_measurement_pkey PRIMARY KEY (unit_id);


--
-- Name: unit_measurement unit_measurement_title_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.unit_measurement
    ADD CONSTRAINT unit_measurement_title_key UNIQUE (title);


--
-- Name: variant_image variant_image_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_image
    ADD CONSTRAINT variant_image_pkey PRIMARY KEY (variant_image_id);


--
-- Name: variant variant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant
    ADD CONSTRAINT variant_pkey PRIMARY KEY (variant_id);


--
-- Name: variant_text variant_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_text
    ADD CONSTRAINT variant_text_pkey PRIMARY KEY (variant_id, lang_id);


--
-- Name: warehouse warehouse_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_pkey PRIMARY KEY (warehouse_id);


--
-- Name: warehouse_text warehouse_text_lang_id_title_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.warehouse_text
    ADD CONSTRAINT warehouse_text_lang_id_title_key UNIQUE (lang_id, title);


--
-- Name: warehouse_text warehouse_text_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.warehouse_text
    ADD CONSTRAINT warehouse_text_pkey PRIMARY KEY (warehouse_id, lang_id);


--
-- Name: webhook_log webhook_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook_log
    ADD CONSTRAINT webhook_log_pkey PRIMARY KEY (webhook_log_id);


--
-- Name: webhook webhook_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook
    ADD CONSTRAINT webhook_pkey PRIMARY KEY (webhook_id);


--
-- Name: admin_comment_essence_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_comment_essence_id_idx ON public.admin_comment USING btree (essence_id);


--
-- Name: api_file_uploader_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX api_file_uploader_created_at_idx ON public.api_file_uploader USING btree (created_at);


--
-- Name: api_file_uploader_file_id_chunk_position_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX api_file_uploader_file_id_chunk_position_idx ON public.api_file_uploader USING btree (file_id, chunk_position);


--
-- Name: api_file_uploader_file_id_is_initial_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX api_file_uploader_file_id_is_initial_idx ON public.api_file_uploader USING btree (file_id, is_initial) WHERE (is_initial IS TRUE);


--
-- Name: article_site_id_lang_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX article_site_id_lang_id_deleted_at_idx ON public.article USING btree (site_id, lang_id, deleted_at);


--
-- Name: article_site_id_lang_id_url_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX article_site_id_lang_id_url_key_idx ON public.article USING btree (site_id, lang_id, url_key);


--
-- Name: article_status_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX article_status_created_by_idx ON public.article USING btree (status, created_by) WHERE ((status = 'draft'::public.publishing_status) AND (created_by IS NOT NULL));


--
-- Name: auth_resource_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_resource_parent_id_idx ON public.auth_resource USING btree (parent_id);


--
-- Name: basket_item_basket_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX basket_item_basket_id_deleted_at_idx ON public.basket_item USING btree (basket_id, deleted_at);


--
-- Name: basket_item_basket_id_item_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX basket_item_basket_id_item_id_idx ON public.basket_item USING btree (basket_id, item_id);


--
-- Name: basket_person_id_is_active_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX basket_person_id_is_active_idx ON public.basket USING btree (person_id, is_active) WHERE (is_active = true);


--
-- Name: category_category_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX category_category_id_idx ON public.category USING btree (category_id) WHERE (deleted_at IS NULL);


--
-- Name: category_menu_rel_block_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX category_menu_rel_block_id_idx ON public.category_menu_rel USING btree (block_id);


--
-- Name: category_parent_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX category_parent_id_deleted_at_idx ON public.category USING btree (parent_id, deleted_at);


--
-- Name: category_parent_id_status_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX category_parent_id_status_deleted_at_idx ON public.category USING btree (parent_id, status, deleted_at);


--
-- Name: category_status_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX category_status_created_by_idx ON public.category USING btree (status, created_by) WHERE ((status = 'draft'::public.publishing_status) AND (created_by IS NOT NULL));


--
-- Name: category_text_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX category_text_lang_id_idx ON public.category_text USING btree (lang_id);


--
-- Name: category_text_lang_id_url_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX category_text_lang_id_url_key_idx ON public.category_text USING btree (lang_id, url_key);


--
-- Name: characteristic_alias_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX characteristic_alias_idx ON public.characteristic USING btree (alias);


--
-- Name: characteristic_group_id_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_group_id_type_idx ON public.characteristic USING btree (group_id, type);


--
-- Name: characteristic_parent_id_group_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_parent_id_group_id_idx ON public.characteristic USING btree (parent_id, group_id);


--
-- Name: characteristic_product_val_characteristic_id_case_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_product_val_characteristic_id_case_id_idx ON public.characteristic_product_val USING btree (characteristic_id, case_id);


--
-- Name: characteristic_product_val_product_id_case_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_product_val_product_id_case_id_idx ON public.characteristic_product_val USING btree (product_id, case_id);


--
-- Name: characteristic_product_val_product_id_characteristic_id_cas_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX characteristic_product_val_product_id_characteristic_id_cas_idx ON public.characteristic_product_val USING btree (product_id, characteristic_id, case_id) WHERE (case_id IS NOT NULL);


--
-- Name: characteristic_product_val_product_id_characteristic_id_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX characteristic_product_val_product_id_characteristic_id_idx2 ON public.characteristic_product_val USING btree (product_id, characteristic_id) WHERE (case_id IS NULL);


--
-- Name: characteristic_product_val_text_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_product_val_text_lang_id_idx ON public.characteristic_product_val_text USING btree (lang_id);


--
-- Name: characteristic_product_val_text_lang_id_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_product_val_text_lang_id_lower_idx ON public.characteristic_product_val_text USING gin (lang_id, lower(value));


--
-- Name: characteristic_prop_is_folder_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_prop_is_folder_idx ON public.characteristic_prop USING btree (is_folder);


--
-- Name: characteristic_text_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_text_lang_id_idx ON public.characteristic_text USING btree (lang_id);


--
-- Name: characteristic_type_case_characteristic_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_type_case_characteristic_id_idx ON public.characteristic_type_case USING btree (characteristic_id);


--
-- Name: characteristic_type_case_text_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_type_case_text_lang_id_idx ON public.characteristic_type_case_text USING btree (lang_id);


--
-- Name: characteristic_type_case_text_lang_id_title_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_type_case_text_lang_id_title_idx ON public.characteristic_type_case_text USING btree (lang_id, title);


--
-- Name: characteristic_variant_val_case_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_variant_val_case_id_idx ON public.characteristic_variant_val USING btree (case_id);


--
-- Name: characteristic_variant_val_characteristic_id_case_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_variant_val_characteristic_id_case_id_idx ON public.characteristic_variant_val USING btree (characteristic_id, case_id);


--
-- Name: characteristic_variant_val_characteristic_id_rel_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_variant_val_characteristic_id_rel_type_idx ON public.characteristic_variant_val USING btree (characteristic_id, rel_type);


--
-- Name: characteristic_variant_val_rel_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX characteristic_variant_val_rel_type_idx ON public.characteristic_variant_val USING btree (rel_type);


--
-- Name: characteristic_variant_val_variant_id_case_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX characteristic_variant_val_variant_id_case_id_idx ON public.characteristic_variant_val USING btree (variant_id, case_id);


--
-- Name: characteristic_variant_val_variant_id_characteristic_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX characteristic_variant_val_variant_id_characteristic_id_idx ON public.characteristic_variant_val USING btree (variant_id, characteristic_id) WHERE (rel_type = 'variant'::public.product_variant_characteristic_type);


--
-- Name: collection_product_rel_collection_id_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX collection_product_rel_collection_id_product_id_idx ON public.collection_product_rel USING btree (collection_id, product_id);


--
-- Name: collection_product_rel_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX collection_product_rel_product_id_idx ON public.collection_product_rel USING btree (product_id);


--
-- Name: collection_site_id_lang_id_alias_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX collection_site_id_lang_id_alias_idx ON public.collection USING btree (site_id, lang_id, alias) WHERE (alias IS NOT NULL);


--
-- Name: collection_site_id_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX collection_site_id_lang_id_idx ON public.collection USING btree (site_id, lang_id) WHERE (deleted_at IS NULL);


--
-- Name: commodity_group_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX commodity_group_deleted_at_idx ON public.commodity_group USING btree (deleted_at);


--
-- Name: commodity_group_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX commodity_group_is_default_idx ON public.commodity_group USING btree (is_default) WHERE (is_default IS TRUE);


--
-- Name: commodity_group_text_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX commodity_group_text_lang_id_idx ON public.commodity_group_text USING btree (lang_id);


--
-- Name: commodity_group_text_lang_id_title_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX commodity_group_text_lang_id_title_idx ON public.commodity_group_text USING btree (lang_id, title);


--
-- Name: consumed_space_bucket_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX consumed_space_bucket_idx ON public.consumed_space USING btree (bucket) WHERE (type = 's3'::public.space_type);


--
-- Name: consumed_space_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX consumed_space_type_idx ON public.consumed_space USING btree (type) WHERE (type = 'db'::public.space_type);


--
-- Name: coupon_campaign_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_campaign_deleted_at_idx ON public.coupon_campaign USING btree (deleted_at);


--
-- Name: coupon_code_campaign_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_code_campaign_id_idx ON public.coupon_code USING btree (campaign_id);


--
-- Name: currency_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX currency_code_idx ON public.currency USING btree (code);


--
-- Name: customer_group_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX customer_group_deleted_at_idx ON public.customer_group USING btree (deleted_at);


--
-- Name: delivery_country_country_id_all_city_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX delivery_country_country_id_all_city_idx ON public.delivery_country USING btree (country_id, all_city) WHERE (all_city IS TRUE);


--
-- Name: delivery_country_country_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX delivery_country_country_id_idx ON public.delivery_country USING btree (country_id);


--
-- Name: delivery_shipping_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX delivery_shipping_id_idx ON public.delivery USING btree (shipping_id);


--
-- Name: delivery_site_delivery_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX delivery_site_delivery_id_idx ON public.delivery_site USING btree (delivery_id);


--
-- Name: delivery_status_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX delivery_status_created_by_idx ON public.delivery USING btree (status, created_by) WHERE ((status = 'draft'::public.publishing_status) AND (created_by IS NOT NULL));


--
-- Name: delivery_status_created_by_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX delivery_status_created_by_idx1 ON public.delivery USING btree (status, created_by);


--
-- Name: essence_essence_local_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX essence_essence_local_id_idx ON public.essence USING btree (essence_local_id);


--
-- Name: essence_type_essence_local_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX essence_type_essence_local_id_idx ON public.essence USING btree (type, essence_local_id);


--
-- Name: filter_field_filter_id_characteristic_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX filter_field_filter_id_characteristic_id_idx ON public.filter_field USING btree (filter_id, characteristic_id);


--
-- Name: filter_field_filter_id_sort_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX filter_field_filter_id_sort_idx ON public.filter_field USING btree (filter_id, sort);


--
-- Name: filter_field_filter_id_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX filter_field_filter_id_type_idx ON public.filter_field USING btree (filter_id, type) WHERE (NOT (type = 'characteristic'::public.filter_field_type));


--
-- Name: filter_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX filter_is_default_idx ON public.filter USING btree (is_default) WHERE (is_default IS TRUE);


--
-- Name: final_price_item_id_price_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX final_price_item_id_price_id_idx ON public.final_price USING btree (item_id, price_id);


--
-- Name: final_price_price_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX final_price_price_id_idx ON public.final_price USING btree (price_id);


--
-- Name: image_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX image_deleted_at_idx ON public.image USING btree (deleted_at);


--
-- Name: image_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX image_lower_idx ON public.image USING gin (lower(name) public.gin_trgm_ops);


--
-- Name: image_path_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX image_path_idx ON public.image USING btree (path);


--
-- Name: image_site_id_lang_id_used_in_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX image_site_id_lang_id_used_in_idx ON public.image USING btree (site_id, lang_id, used_in);


--
-- Name: image_tag_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX image_tag_lower_idx ON public.image_tag USING btree (lower((title)::text));


--
-- Name: image_tag_rel_product_image_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX image_tag_rel_product_image_id_idx ON public.image_tag_rel USING btree (product_image_id);


--
-- Name: inventory_item_custom_item_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX inventory_item_custom_item_id_idx ON public.inventory_item USING btree (custom_item_id);


--
-- Name: inventory_item_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX inventory_item_product_id_idx ON public.inventory_item USING btree (product_id);


--
-- Name: inventory_item_variant_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX inventory_item_variant_id_idx ON public.inventory_item USING btree (variant_id);


--
-- Name: inventory_location_warehouse_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX inventory_location_warehouse_id_idx ON public.inventory_location USING btree (warehouse_id);


--
-- Name: inventory_movement_item_from_location_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_movement_item_from_location_id_idx ON public.inventory_movement_item USING btree (from_location_id);


--
-- Name: inventory_movement_item_item_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_movement_item_item_id_idx ON public.inventory_movement_item USING btree (item_id);


--
-- Name: inventory_movement_item_movement_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_movement_item_movement_id_idx ON public.inventory_movement_item USING btree (movement_id);


--
-- Name: inventory_movement_item_to_location_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_movement_item_to_location_id_idx ON public.inventory_movement_item USING btree (to_location_id);


--
-- Name: inventory_movement_person_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_movement_person_id_idx ON public.inventory_movement USING btree (person_id);


--
-- Name: inventory_movement_reason_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_movement_reason_id_idx ON public.inventory_movement USING btree (reason_id);


--
-- Name: inventory_movement_ts_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_movement_ts_idx ON public.inventory_movement USING btree (ts);


--
-- Name: inventory_option_category_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_option_category_deleted_at_idx ON public.inventory_option USING btree (category, deleted_at);


--
-- Name: inventory_stock_available_qty_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_stock_available_qty_idx ON public.inventory_stock USING btree (available_qty);


--
-- Name: inventory_stock_item_id_available_qty_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_stock_item_id_available_qty_idx ON public.inventory_stock USING btree (item_id, available_qty);


--
-- Name: inventory_stock_location_id_item_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX inventory_stock_location_id_item_id_idx ON public.inventory_stock USING btree (location_id, item_id);


--
-- Name: inventory_stock_reserved_qty_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_stock_reserved_qty_idx ON public.inventory_stock USING btree (reserved_qty);


--
-- Name: inventory_stock_supply_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX inventory_stock_supply_id_idx ON public.inventory_stock USING btree (supply_id);


--
-- Name: label_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX label_deleted_at_idx ON public.label USING btree (deleted_at) WHERE (deleted_at IS NULL);


--
-- Name: label_remove_after_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX label_remove_after_idx ON public.label USING btree (remove_after) WHERE (remove_after IS NOT NULL);


--
-- Name: label_text_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX label_text_lang_id_idx ON public.label_text USING btree (lang_id);


--
-- Name: manufacturer_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX manufacturer_deleted_at_idx ON public.manufacturer USING btree (deleted_at);


--
-- Name: manufacturer_status_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX manufacturer_status_created_by_idx ON public.manufacturer USING btree (status, created_by) WHERE ((status = 'draft'::public.publishing_status) AND (created_by IS NOT NULL));


--
-- Name: manufacturer_status_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX manufacturer_status_deleted_at_idx ON public.manufacturer USING btree (status, deleted_at);


--
-- Name: manufacturer_text_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX manufacturer_text_lang_id_idx ON public.manufacturer_text USING btree (lang_id);


--
-- Name: manufacturer_text_lang_id_title_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX manufacturer_text_lang_id_title_idx ON public.manufacturer_text USING btree (lang_id, title);


--
-- Name: manufacturer_text_lang_id_url_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX manufacturer_text_lang_id_url_key_idx ON public.manufacturer_text USING btree (lang_id, url_key);


--
-- Name: menu_block_site_id_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX menu_block_site_id_key_idx ON public.menu_block USING btree (site_id, key);


--
-- Name: menu_item_block_id_lang_id_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX menu_item_block_id_lang_id_lower_idx ON public.menu_item USING gin (block_id, lang_id, lower(title) public.gin_trgm_ops);


--
-- Name: menu_item_block_id_lang_id_parent_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX menu_item_block_id_lang_id_parent_id_idx ON public.menu_item USING btree (block_id, lang_id, parent_id);


--
-- Name: notification_history_type_essence_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX notification_history_type_essence_id_idx ON public.notification_history USING btree (type, essence_id);


--
-- Name: notification_template_event_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX notification_template_event_type_idx ON public.notification_template USING btree (event_type) WHERE (event_type = 'created'::public.queue_event_type);


--
-- Name: notification_template_event_type_status_id_transport_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX notification_template_event_type_status_id_transport_idx ON public.notification_template USING btree (event_type, status_id, transport) WHERE ((event_type IS NOT NULL) AND (status_id IS NOT NULL) AND (transport IS NOT NULL));


--
-- Name: offer_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX offer_product_id_idx ON public.offer USING btree (product_id);


--
-- Name: order_discount_code_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_discount_code_id_idx ON public.order_discount USING btree (code_id);


--
-- Name: order_discount_order_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_discount_order_id_idx ON public.order_discount USING btree (order_id);


--
-- Name: order_history_status_id_changed_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_history_status_id_changed_at_idx ON public.order_history USING btree (status_id, changed_at);


--
-- Name: order_service_order_id_is_delivery_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX order_service_order_id_is_delivery_idx ON public.order_service USING btree (order_id, is_delivery) WHERE (is_delivery IS TRUE);


--
-- Name: order_service_order_id_service_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX order_service_order_id_service_id_idx ON public.order_service USING btree (order_id, service_id);


--
-- Name: order_source_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_source_deleted_at_idx ON public.order_source USING btree (deleted_at);


--
-- Name: order_status_parent_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_status_parent_id_deleted_at_idx ON public.order_status USING btree (parent_id, deleted_at);


--
-- Name: order_track_number_order_id_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_track_number_order_id_created_at_idx ON public.track_number USING btree (order_id, created_at);


--
-- Name: orders_basket_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX orders_basket_id_idx ON public.orders USING btree (basket_id);


--
-- Name: orders_confirmed_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_confirmed_at_idx ON public.orders USING btree (confirmed_at);


--
-- Name: orders_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_created_at_idx ON public.orders USING btree (created_at);


--
-- Name: orders_customer_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_customer_id_idx ON public.orders USING btree (customer_id);


--
-- Name: orders_paid_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_paid_at_idx ON public.orders USING btree (paid_at);


--
-- Name: orders_payment_method_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_payment_method_id_idx ON public.orders USING btree (payment_method_id);


--
-- Name: orders_publishing_status_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX orders_publishing_status_created_by_idx ON public.orders USING btree (publishing_status, created_by) WHERE ((publishing_status = 'draft'::public.publishing_status) AND (created_by IS NOT NULL));


--
-- Name: orders_source_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_source_id_idx ON public.orders USING btree (source_id);


--
-- Name: orders_status_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_status_id_idx ON public.orders USING btree (status_id);


--
-- Name: orders_total_price_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_total_price_idx ON public.orders USING btree (total_price);


--
-- Name: page_site_id_lang_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX page_site_id_lang_id_deleted_at_idx ON public.page USING btree (site_id, lang_id, deleted_at);


--
-- Name: page_site_id_lang_id_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX page_site_id_lang_id_lower_idx ON public.page USING gin (site_id, lang_id, lower((title)::text) public.gin_trgm_ops);


--
-- Name: page_site_id_lang_id_lower_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX page_site_id_lang_id_lower_idx1 ON public.page USING gin (site_id, lang_id, lower((url_key)::text) public.gin_trgm_ops);


--
-- Name: page_site_id_lang_id_parent_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX page_site_id_lang_id_parent_id_deleted_at_idx ON public.page USING btree (site_id, lang_id, parent_id, deleted_at);


--
-- Name: page_site_id_lang_id_system_alias_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX page_site_id_lang_id_system_alias_idx ON public.page USING btree (site_id, lang_id, system_alias);


--
-- Name: page_site_id_lang_id_url_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX page_site_id_lang_id_url_key_idx ON public.page USING btree (site_id, lang_id, url_key);


--
-- Name: page_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX page_type_idx ON public.page USING btree (type) WHERE (deleted_at IS NULL);


--
-- Name: payment_callback_payment_transaction_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_callback_payment_transaction_id_idx ON public.payment_callback USING btree (payment_transaction_id);


--
-- Name: payment_method_site_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_method_site_id_deleted_at_idx ON public.payment_method USING btree (site_id, deleted_at);


--
-- Name: payment_request_payment_transaction_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_request_payment_transaction_id_idx ON public.payment_request USING btree (payment_transaction_id);


--
-- Name: payment_transaction_external_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_transaction_external_id_idx ON public.payment_transaction USING btree (external_id);


--
-- Name: payment_transaction_order_id_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_transaction_order_id_status_idx ON public.payment_transaction USING btree (order_id, status);


--
-- Name: person_address_person_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX person_address_person_id_idx ON public.person_address USING btree (person_id);


--
-- Name: person_address_person_id_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX person_address_person_id_is_default_idx ON public.person_address USING btree (person_id, is_default) WHERE (is_default IS TRUE);


--
-- Name: person_address_person_id_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX person_address_person_id_type_idx ON public.person_address USING btree (person_id, type) WHERE (type IS NOT NULL);


--
-- Name: person_deleted_at_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX person_deleted_at_status_idx ON public.person USING btree (deleted_at, status);


--
-- Name: person_is_owner_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX person_is_owner_idx ON public.person USING btree (is_owner) WHERE (is_owner IS TRUE);


--
-- Name: person_role_rel_role_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX person_role_rel_role_id_idx ON public.person_role_rel USING btree (role_id);


--
-- Name: person_search_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX person_search_lower_idx ON public.person_search USING gin (lower(search) public.gin_trgm_ops);


--
-- Name: person_site_id_email_registered_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX person_site_id_email_registered_at_idx ON public.person USING btree (site_id, email, registered_at) WHERE (registered_at IS NOT NULL);


--
-- Name: person_site_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX person_site_id_idx ON public.person USING btree (site_id) WHERE ((registered_at IS NOT NULL) AND (deleted_at IS NULL));


--
-- Name: person_site_id_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX person_site_id_idx1 ON public.person USING btree (site_id) WHERE ((registered_at IS NOT NULL) AND (deleted_at IS NOT NULL));


--
-- Name: person_status_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX person_status_created_by_idx ON public.person USING btree (status, created_by) WHERE ((status = 'draft'::public.publishing_status) AND (created_by IS NOT NULL));


--
-- Name: person_token_person_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX person_token_person_id_idx ON public.person_token USING btree (person_id);


--
-- Name: price_alias_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX price_alias_idx ON public.price USING btree (alias);


--
-- Name: price_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX price_deleted_at_idx ON public.price USING btree (deleted_at);


--
-- Name: product_category_rel_product_id_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_category_rel_product_id_is_default_idx ON public.product_category_rel USING btree (product_id, is_default) WHERE (is_default = true);


--
-- Name: product_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_deleted_at_idx ON public.product USING btree (deleted_at);


--
-- Name: product_image_product_id_image_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_image_product_id_image_id_idx ON public.product_image USING btree (product_id, image_id);


--
-- Name: product_image_product_id_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_image_product_id_is_default_idx ON public.product_image USING btree (product_id, is_default) WHERE (is_default IS TRUE);


--
-- Name: product_image_product_id_sort_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_image_product_id_sort_idx ON public.product_image USING btree (product_id, sort);


--
-- Name: product_import_imgs_import_id_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_import_imgs_import_id_status_idx ON public.product_import_imgs USING btree (import_id, status);


--
-- Name: product_label_rel_label_id_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_label_rel_label_id_created_at_idx ON public.product_label_rel USING btree (label_id, created_at);


--
-- Name: product_label_rel_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_label_rel_product_id_idx ON public.product_label_rel USING btree (product_id);


--
-- Name: product_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_lower_idx ON public.product USING gin (lower((sku)::text) public.gin_trgm_ops);


--
-- Name: product_prop_available_qty_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_prop_available_qty_idx ON public.product_prop USING btree (available_qty);


--
-- Name: product_prop_characteristic_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_prop_characteristic_idx ON public.product_prop USING gin (characteristic);


--
-- Name: product_prop_extra_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_prop_extra_idx ON public.product_prop USING gin (extra);


--
-- Name: product_review_img_review_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_review_img_review_id_idx ON public.product_review_img USING btree (review_id);


--
-- Name: product_review_order_id_product_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_review_order_id_product_id_idx ON public.product_review USING btree (order_id, product_id);


--
-- Name: product_review_product_id_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_review_product_id_created_by_idx ON public.product_review USING btree (product_id, created_by);


--
-- Name: product_review_status_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_review_status_created_by_idx ON public.product_review USING btree (status, created_by) WHERE ((status = 'draft'::public.publishing_status) AND (created_by IS NOT NULL) AND (order_id IS NULL) AND (product_id IS NULL));


--
-- Name: product_status_created_by_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_status_created_by_idx ON public.product USING btree (status, created_by) WHERE ((status = 'draft'::public.publishing_status) AND (created_by IS NOT NULL));


--
-- Name: product_status_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_status_deleted_at_idx ON public.product USING btree (status, deleted_at);


--
-- Name: product_text_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_text_lang_id_idx ON public.product_text USING btree (lang_id);


--
-- Name: product_text_lang_id_url_key_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_text_lang_id_url_key_idx ON public.product_text USING btree (lang_id, url_key);


--
-- Name: product_text_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_text_lower_idx ON public.product_text USING gin (lower((title)::text) public.gin_trgm_ops);


--
-- Name: product_text_lower_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_text_lower_idx1 ON public.product_text USING gin (lower(custom_title) public.gin_trgm_ops);


--
-- Name: product_text_lower_idx2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_text_lower_idx2 ON public.product_text USING gin (lower(custom_header) public.gin_trgm_ops);


--
-- Name: product_text_lower_idx3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_text_lower_idx3 ON public.product_text USING gin (lower(description) public.gin_trgm_ops);


--
-- Name: product_variant_characteristi_characteristic_id_product_id__idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variant_characteristi_characteristic_id_product_id__idx ON public.product_variant_characteristic USING btree (characteristic_id, product_id, rel_type);


--
-- Name: product_variant_characteristic_product_id_characteristic_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX product_variant_characteristic_product_id_characteristic_id_idx ON public.product_variant_characteristic USING btree (product_id, characteristic_id);


--
-- Name: product_variant_characteristic_product_id_rel_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variant_characteristic_product_id_rel_type_idx ON public.product_variant_characteristic USING btree (product_id, rel_type);


--
-- Name: reserve_item_reserve_id_item_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reserve_item_reserve_id_item_id_idx ON public.reserve_item USING btree (reserve_id, item_id);


--
-- Name: reserve_item_reserve_id_item_id_idx1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX reserve_item_reserve_id_item_id_idx1 ON public.reserve_item USING btree (reserve_id, item_id) WHERE (stock_id IS NULL);


--
-- Name: reserve_item_reserve_id_item_id_stock_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX reserve_item_reserve_id_item_id_stock_id_idx ON public.reserve_item USING btree (reserve_id, item_id, stock_id) WHERE (stock_id IS NOT NULL);


--
-- Name: reserve_item_reserve_id_item_price_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reserve_item_reserve_id_item_price_id_idx ON public.reserve_item USING btree (reserve_id, item_price_id);


--
-- Name: reserve_order_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX reserve_order_id_idx ON public.reserve USING btree (order_id);


--
-- Name: service_show_in_list_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX service_show_in_list_deleted_at_idx ON public.service USING btree (show_in_list, deleted_at);


--
-- Name: site_country_lang_site_id_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX site_country_lang_site_id_is_default_idx ON public.site_country_lang USING btree (site_id, is_default) WHERE (is_default = true);


--
-- Name: tax_class_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX tax_class_is_default_idx ON public.tax_class USING btree (is_default) WHERE (is_default IS TRUE);


--
-- Name: theme_installed_is_using_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX theme_installed_is_using_idx ON public.theme_installed USING btree (is_using) WHERE (is_using IS TRUE);


--
-- Name: theme_installed_theme_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX theme_installed_theme_id_idx ON public.theme_installed USING btree (theme_id);


--
-- Name: track_number_order_id_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX track_number_order_id_lower_idx ON public.track_number USING gin (order_id, lower((track_number)::text) public.gin_trgm_ops);


--
-- Name: typearea_block_text_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX typearea_block_text_lower_idx ON public.typearea_block_text USING gin (lower(value) public.gin_trgm_ops);


--
-- Name: typearea_block_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX typearea_block_type_idx ON public.typearea_block USING btree (type) WHERE (deleted_at IS NULL);


--
-- Name: typearea_block_typearea_id_deleted_at_sort_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX typearea_block_typearea_id_deleted_at_sort_idx ON public.typearea_block USING btree (typearea_id, deleted_at, sort);


--
-- Name: typearea_block_typearea_id_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX typearea_block_typearea_id_type_idx ON public.typearea_block USING btree (typearea_id, type) WHERE (deleted_at IS NULL);


--
-- Name: variant_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_deleted_at_idx ON public.variant USING btree (deleted_at);


--
-- Name: variant_image_variant_id_image_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX variant_image_variant_id_image_id_idx ON public.variant_image USING btree (variant_id, image_id);


--
-- Name: variant_image_variant_id_is_default_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX variant_image_variant_id_is_default_idx ON public.variant_image USING btree (variant_id, is_default) WHERE (is_default IS TRUE);


--
-- Name: variant_product_id_cases_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_product_id_cases_idx ON public.variant USING gin (product_id, cases public.gin__int_ops);


--
-- Name: variant_product_id_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX variant_product_id_deleted_at_idx ON public.variant USING btree (product_id, deleted_at);


--
-- Name: variant_product_id_sku_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX variant_product_id_sku_idx ON public.variant USING btree (product_id, sku);


--
-- Name: vw_city_city_id_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX vw_city_city_id_lang_id_idx ON public.vw_city USING btree (city_id, lang_id);


--
-- Name: vw_city_lower_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX vw_city_lower_idx ON public.vw_city USING gin (lower(city_title) public.gin_trgm_ops);


--
-- Name: vw_country_country_id_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX vw_country_country_id_lang_id_idx ON public.vw_country USING btree (country_id, lang_id);


--
-- Name: vw_country_lang_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX vw_country_lang_id_idx ON public.vw_country USING btree (lang_id);


--
-- Name: vw_delivery_city_site_id_city_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX vw_delivery_city_site_id_city_id_idx ON public.vw_delivery_city USING btree (site_id, city_id);


--
-- Name: vw_delivery_country_site_id_country_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX vw_delivery_country_site_id_country_id_idx ON public.vw_delivery_country USING btree (site_id, country_id);


--
-- Name: vw_shipping_zip_shipping_id_city_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX vw_shipping_zip_shipping_id_city_id_idx ON public.vw_shipping_zip USING btree (shipping_id, city_id) WHERE (courier IS TRUE);


--
-- Name: vw_shipping_zip_shipping_id_city_id_zip_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX vw_shipping_zip_shipping_id_city_id_zip_idx ON public.vw_shipping_zip USING btree (shipping_id, city_id, zip);


--
-- Name: warehouse_deleted_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX warehouse_deleted_at_idx ON public.warehouse USING btree (deleted_at);


--
-- Name: webhook_name_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX webhook_name_uindex ON public.webhook USING btree (name);


--
-- Name: webhook_url_uindex; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX webhook_url_uindex ON public.webhook USING btree (url);


--
-- Name: vw_search_page _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.vw_search_page AS
 SELECT ((page.page_id * 10) + 3) AS id,
    'page'::text AS type,
    page.page_id AS local_id,
    page.site_id,
    lang.lang_id,
    lang.code AS lang_code,
    page.title,
    page_props.custom_title AS seo_title,
    page_props.custom_header AS seo_header,
    page_props.meta_description,
    page_props.meta_keywords,
    string_agg(typearea_block_text.value, ', '::text) AS text
   FROM (((((public.page
     JOIN public.vw_page_flat_list ON ((vw_page_flat_list.page_id = page.page_id)))
     JOIN public.page_props ON ((page.page_id = page_props.page_id)))
     JOIN public.lang ON ((page.lang_id = lang.lang_id)))
     LEFT JOIN public.typearea_block ON (((typearea_block.typearea_id = page.typearea_id) AND (typearea_block.type = 'text'::public.typearea_block_type) AND (typearea_block.deleted_at IS NULL))))
     LEFT JOIN public.typearea_block_text ON ((typearea_block.block_id = typearea_block_text.block_id)))
  WHERE ((page.type = 'page'::public.page_type) AND (page.deleted_at IS NULL))
  GROUP BY page.page_id, lang.lang_id, page_props.custom_title, page_props.custom_header, page_props.meta_description, page_props.meta_keywords;


--
-- Name: box box_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER box_after_insert AFTER INSERT ON public.box FOR EACH ROW EXECUTE FUNCTION public.box_after_insert();


--
-- Name: category category_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER category_after_insert AFTER INSERT ON public.category FOR EACH ROW EXECUTE FUNCTION public.category_after_insert();


--
-- Name: category category_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER category_before_insert BEFORE INSERT ON public.category FOR EACH ROW EXECUTE FUNCTION public.category_before_insert();


--
-- Name: category category_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER category_before_update BEFORE UPDATE ON public.category FOR EACH ROW EXECUTE FUNCTION public.category_before_update();


--
-- Name: characteristic characteristic_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_after_insert AFTER INSERT ON public.characteristic FOR EACH ROW EXECUTE FUNCTION public.characteristic_after_insert();


--
-- Name: characteristic characteristic_before_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_before_delete BEFORE DELETE ON public.characteristic FOR EACH ROW EXECUTE FUNCTION public.characteristic_before_delete();


--
-- Name: characteristic characteristic_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_before_insert BEFORE INSERT ON public.characteristic FOR EACH ROW EXECUTE FUNCTION public.characteristic_before_insert();


--
-- Name: characteristic characteristic_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_before_update BEFORE UPDATE ON public.characteristic FOR EACH ROW EXECUTE FUNCTION public.characteristic_before_update();


--
-- Name: characteristic_product_val characteristic_product_val_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_product_val_after_insert AFTER INSERT ON public.characteristic_product_val FOR EACH ROW EXECUTE FUNCTION public.characteristic_product_val_after_insert();


--
-- Name: characteristic_type_case characteristic_type_case_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_type_case_after_insert AFTER INSERT ON public.characteristic_type_case FOR EACH ROW EXECUTE FUNCTION public.characteristic_type_case_after_insert();


--
-- Name: characteristic_type_case characteristic_type_case_before_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_type_case_before_delete BEFORE DELETE ON public.characteristic_type_case FOR EACH ROW EXECUTE FUNCTION public.characteristic_type_case_before_delete();


--
-- Name: characteristic_type_case characteristic_type_case_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_type_case_before_insert BEFORE INSERT ON public.characteristic_type_case FOR EACH ROW EXECUTE FUNCTION public.characteristic_type_case_before_insert();


--
-- Name: characteristic_type_case_text characteristic_type_case_text_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_type_case_text_after_update AFTER UPDATE ON public.characteristic_type_case_text FOR EACH ROW EXECUTE FUNCTION public.characteristic_type_case_text_after_update();


--
-- Name: characteristic_variant_val characteristic_variant_val_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_variant_val_after_delete AFTER DELETE ON public.characteristic_variant_val FOR EACH ROW EXECUTE FUNCTION public.characteristic_variant_val_after_delete();


--
-- Name: characteristic_variant_val characteristic_variant_val_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_variant_val_after_insert AFTER INSERT ON public.characteristic_variant_val FOR EACH ROW EXECUTE FUNCTION public.characteristic_variant_val_after_insert();


--
-- Name: characteristic_variant_val characteristic_variant_val_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_variant_val_after_update AFTER UPDATE ON public.characteristic_variant_val FOR EACH ROW EXECUTE FUNCTION public.characteristic_variant_val_after_update();


--
-- Name: characteristic_variant_val characteristic_variant_val_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER characteristic_variant_val_before_update BEFORE UPDATE ON public.characteristic_variant_val FOR EACH ROW EXECUTE FUNCTION public.characteristic_variant_val_before_update();


--
-- Name: commodity_group commodity_group_before_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER commodity_group_before_delete BEFORE DELETE ON public.commodity_group FOR EACH ROW EXECUTE FUNCTION public.commodity_group_before_delete();


--
-- Name: commodity_group commodity_group_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER commodity_group_before_update BEFORE UPDATE ON public.commodity_group FOR EACH ROW EXECUTE FUNCTION public.commodity_group_before_update();


--
-- Name: commodity_group commodity_group_init; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER commodity_group_init AFTER INSERT ON public.commodity_group FOR EACH ROW EXECUTE FUNCTION public.commodity_group_init();


--
-- Name: custom_item custom_item_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER custom_item_after_insert AFTER INSERT ON public.custom_item FOR EACH ROW EXECUTE FUNCTION public.custom_item_after_insert();


--
-- Name: customer_group customer_group_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER customer_group_after_insert AFTER INSERT ON public.customer_group FOR EACH ROW EXECUTE FUNCTION public.customer_group_after_insert();


--
-- Name: delivery delivery_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER delivery_after_insert AFTER INSERT ON public.delivery FOR EACH ROW EXECUTE FUNCTION public.delivery_after_insert();


--
-- Name: delivery_city delivery_city_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER delivery_city_after_insert AFTER INSERT ON public.delivery_city FOR EACH ROW EXECUTE FUNCTION public.delivery_city_after_insert();


--
-- Name: delivery_country delivery_country_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER delivery_country_after_insert AFTER INSERT ON public.delivery_country FOR EACH ROW EXECUTE FUNCTION public.delivery_country_after_insert();


--
-- Name: delivery_site delivery_site_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER delivery_site_before_insert BEFORE INSERT ON public.delivery_site FOR EACH ROW EXECUTE FUNCTION public.delivery_site_before_insert();


--
-- Name: filter_field filter_field_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER filter_field_before_insert BEFORE INSERT ON public.filter_field FOR EACH ROW EXECUTE FUNCTION public.filter_field_before_insert();


--
-- Name: final_price final_price_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER final_price_after_delete AFTER DELETE ON public.final_price FOR EACH ROW EXECUTE FUNCTION public.final_price_after_delete();


--
-- Name: final_price final_price_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER final_price_after_insert AFTER INSERT ON public.final_price FOR EACH ROW EXECUTE FUNCTION public.final_price_after_insert();


--
-- Name: final_price final_price_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER final_price_after_update AFTER UPDATE ON public.final_price FOR EACH ROW EXECUTE FUNCTION public.final_price_after_update();


--
-- Name: inventory_item inventory_item_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_item_after_delete AFTER DELETE ON public.inventory_item FOR EACH ROW EXECUTE FUNCTION public.inventory_item_after_delete();


--
-- Name: inventory_item inventory_item_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_item_after_insert AFTER INSERT ON public.inventory_item FOR EACH ROW EXECUTE FUNCTION public.inventory_item_after_insert();


--
-- Name: inventory_item inventory_item_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_item_after_update AFTER UPDATE ON public.inventory_item FOR EACH ROW EXECUTE FUNCTION public.inventory_item_after_update();


--
-- Name: inventory_option inventory_option_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_option_after_insert AFTER INSERT ON public.inventory_option FOR EACH ROW EXECUTE FUNCTION public.inventory_option_after_insert();


--
-- Name: inventory_option inventory_option_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_option_before_insert BEFORE INSERT ON public.inventory_option FOR EACH ROW EXECUTE FUNCTION public.inventory_option_before_insert();


--
-- Name: inventory_price inventory_price_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_price_after_delete AFTER DELETE ON public.inventory_price FOR EACH ROW EXECUTE FUNCTION public.inventory_price_after_delete();


--
-- Name: inventory_price inventory_price_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_price_after_insert AFTER INSERT ON public.inventory_price FOR EACH ROW EXECUTE FUNCTION public.inventory_price_after_insert();


--
-- Name: inventory_price inventory_price_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_price_after_update AFTER UPDATE ON public.inventory_price FOR EACH ROW EXECUTE FUNCTION public.inventory_price_after_update();


--
-- Name: inventory_stock inventory_stock_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_stock_after_delete AFTER DELETE ON public.inventory_stock FOR EACH ROW EXECUTE FUNCTION public.inventory_stock_after_delete();


--
-- Name: inventory_stock inventory_stock_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_stock_after_insert AFTER INSERT ON public.inventory_stock FOR EACH ROW EXECUTE FUNCTION public.inventory_stock_after_insert();


--
-- Name: inventory_stock inventory_stock_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER inventory_stock_after_update AFTER UPDATE ON public.inventory_stock FOR EACH ROW EXECUTE FUNCTION public.inventory_stock_after_update();


--
-- Name: label label_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER label_after_insert AFTER INSERT ON public.label FOR EACH ROW EXECUTE FUNCTION public.label_after_insert();


--
-- Name: manufacturer manufacturer_init; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER manufacturer_init AFTER INSERT ON public.manufacturer FOR EACH ROW EXECUTE FUNCTION public.manufacturer_init();


--
-- Name: menu_item menu_item_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER menu_item_after_insert AFTER INSERT ON public.menu_item FOR EACH ROW EXECUTE FUNCTION public.menu_item_after_insert();


--
-- Name: menu_item menu_item_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER menu_item_before_insert BEFORE INSERT ON public.menu_item FOR EACH ROW EXECUTE FUNCTION public.menu_item_before_insert();


--
-- Name: menu_item menu_item_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER menu_item_before_update BEFORE UPDATE ON public.menu_item FOR EACH ROW EXECUTE FUNCTION public.menu_item_before_update();


--
-- Name: order_service order_service_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_service_after_insert AFTER INSERT ON public.order_service FOR EACH ROW EXECUTE FUNCTION public.order_service_after_insert();


--
-- Name: order_service order_service_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_service_before_insert BEFORE INSERT ON public.order_service FOR EACH ROW EXECUTE FUNCTION public.order_service_before_insert();


--
-- Name: order_service order_service_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_service_before_update BEFORE UPDATE ON public.order_service FOR EACH ROW EXECUTE FUNCTION public.order_service_before_update();


--
-- Name: order_source order_source_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_source_after_insert AFTER INSERT ON public.order_source FOR EACH ROW EXECUTE FUNCTION public.order_source_after_insert();


--
-- Name: order_source order_source_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_source_before_insert BEFORE INSERT ON public.order_source FOR EACH ROW EXECUTE FUNCTION public.order_source_before_insert();


--
-- Name: order_status order_status_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_status_after_insert AFTER INSERT ON public.order_status FOR EACH ROW EXECUTE FUNCTION public.order_status_after_insert();


--
-- Name: order_status order_status_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_status_before_insert BEFORE INSERT ON public.order_status FOR EACH ROW EXECUTE FUNCTION public.order_status_before_insert();


--
-- Name: order_status order_status_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER order_status_before_update BEFORE UPDATE ON public.order_status FOR EACH ROW EXECUTE FUNCTION public.order_status_before_update();


--
-- Name: orders orders_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER orders_after_insert AFTER INSERT ON public.orders FOR EACH ROW EXECUTE FUNCTION public.orders_after_insert();


--
-- Name: page page_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER page_after_delete AFTER DELETE ON public.page FOR EACH ROW EXECUTE FUNCTION public.page_after_delete();


--
-- Name: page page_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER page_after_insert AFTER INSERT ON public.page FOR EACH ROW EXECUTE FUNCTION public.page_after_insert();


--
-- Name: page page_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER page_before_insert BEFORE INSERT ON public.page FOR EACH ROW EXECUTE FUNCTION public.page_before_insert();


--
-- Name: page page_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER page_before_update BEFORE UPDATE ON public.page FOR EACH ROW EXECUTE FUNCTION public.page_before_update();


--
-- Name: payment_method payment_method_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER payment_method_after_insert AFTER INSERT ON public.payment_method FOR EACH ROW EXECUTE FUNCTION public.payment_method_after_insert();


--
-- Name: person_address person_address_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER person_address_after_insert AFTER INSERT ON public.person_address FOR EACH ROW EXECUTE FUNCTION public.person_address_after_insert();


--
-- Name: person_address person_address_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER person_address_after_update AFTER UPDATE ON public.person_address FOR EACH ROW EXECUTE FUNCTION public.person_address_after_update();


--
-- Name: person person_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER person_after_update AFTER UPDATE ON public.person FOR EACH ROW EXECUTE FUNCTION public.person_after_update();


--
-- Name: person person_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER person_before_insert BEFORE INSERT ON public.person FOR EACH ROW EXECUTE FUNCTION public.person_before_insert();


--
-- Name: person person_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER person_before_update BEFORE UPDATE ON public.person FOR EACH ROW EXECUTE FUNCTION public.person_before_update();


--
-- Name: person person_init; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER person_init AFTER INSERT ON public.person FOR EACH ROW EXECUTE FUNCTION public.person_init();


--
-- Name: person_profile person_profile_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER person_profile_after_insert AFTER INSERT ON public.person_profile FOR EACH ROW EXECUTE FUNCTION public.person_profile_after_insert();


--
-- Name: person_profile person_profile_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER person_profile_after_update AFTER UPDATE ON public.person_profile FOR EACH ROW EXECUTE FUNCTION public.person_profile_after_update();


--
-- Name: price price_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER price_after_insert AFTER INSERT ON public.price FOR EACH ROW EXECUTE FUNCTION public.price_after_insert();


--
-- Name: price price_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER price_before_insert BEFORE INSERT ON public.price FOR EACH ROW EXECUTE FUNCTION public.price_before_insert();


--
-- Name: product product_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_after_update AFTER UPDATE ON public.product FOR EACH ROW EXECUTE FUNCTION public.product_after_update();


--
-- Name: product_category_rel product_category_rel_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_category_rel_after_delete AFTER DELETE ON public.product_category_rel FOR EACH ROW EXECUTE FUNCTION public.product_category_rel_after_delete();


--
-- Name: product_category_rel product_category_rel_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_category_rel_before_insert BEFORE INSERT ON public.product_category_rel FOR EACH ROW EXECUTE FUNCTION public.product_category_rel_before_insert();


--
-- Name: product_image product_image_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_image_after_delete AFTER DELETE ON public.product_image FOR EACH ROW EXECUTE FUNCTION public.product_image_after_delete();


--
-- Name: product_image product_image_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_image_after_insert AFTER INSERT ON public.product_image FOR EACH ROW EXECUTE FUNCTION public.product_image_after_insert();


--
-- Name: product_image product_image_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_image_before_insert BEFORE INSERT ON public.product_image FOR EACH ROW EXECUTE FUNCTION public.product_image_before_insert();


--
-- Name: product product_init; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_init AFTER INSERT ON public.product FOR EACH ROW EXECUTE FUNCTION public.product_init();


--
-- Name: product_variant_characteristic product_variant_characteristic_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER product_variant_characteristic_before_insert BEFORE INSERT ON public.product_variant_characteristic FOR EACH ROW EXECUTE FUNCTION public.product_variant_characteristic_before_insert();


--
-- Name: reserve_item reserve_item_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER reserve_item_after_delete AFTER DELETE ON public.reserve_item FOR EACH ROW EXECUTE FUNCTION public.reserve_item_after_delete();


--
-- Name: reserve_item reserve_item_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER reserve_item_after_insert AFTER INSERT ON public.reserve_item FOR EACH ROW EXECUTE FUNCTION public.reserve_item_after_insert();


--
-- Name: reserve_item reserve_item_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER reserve_item_after_update AFTER UPDATE ON public.reserve_item FOR EACH ROW EXECUTE FUNCTION public.reserve_item_after_update();


--
-- Name: reserve_item reserve_item_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER reserve_item_before_insert BEFORE INSERT ON public.reserve_item FOR EACH ROW EXECUTE FUNCTION public.reserve_item_before_insert();


--
-- Name: reserve_item reserve_item_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER reserve_item_before_update BEFORE UPDATE ON public.reserve_item FOR EACH ROW EXECUTE FUNCTION public.reserve_item_before_update();


--
-- Name: service service_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER service_after_insert AFTER INSERT ON public.service FOR EACH ROW EXECUTE FUNCTION public.service_after_insert();


--
-- Name: site site_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER site_after_insert AFTER INSERT ON public.site FOR EACH ROW EXECUTE FUNCTION public.site_after_insert();


--
-- Name: theme_installed theme_installed_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER theme_installed_after_insert AFTER INSERT ON public.theme_installed FOR EACH ROW EXECUTE FUNCTION public.theme_installed_after_insert();


--
-- Name: typearea_block typearea_block_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER typearea_block_after_insert AFTER INSERT ON public.typearea_block FOR EACH ROW EXECUTE FUNCTION public.typearea_block_after_insert();


--
-- Name: typearea_block typearea_block_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER typearea_block_before_insert BEFORE INSERT ON public.typearea_block FOR EACH ROW EXECUTE FUNCTION public.typearea_block_before_insert();


--
-- Name: typearea_block typearea_block_before_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER typearea_block_before_update BEFORE UPDATE ON public.typearea_block FOR EACH ROW EXECUTE FUNCTION public.typearea_block_before_update();


--
-- Name: variant variant_after_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER variant_after_delete AFTER DELETE ON public.variant FOR EACH ROW EXECUTE FUNCTION public.variant_after_delete();


--
-- Name: variant variant_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER variant_after_insert AFTER INSERT ON public.variant FOR EACH ROW EXECUTE FUNCTION public.variant_after_insert();


--
-- Name: variant variant_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER variant_after_update AFTER UPDATE ON public.variant FOR EACH ROW EXECUTE FUNCTION public.variant_after_update();


--
-- Name: variant variant_before_delete; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER variant_before_delete BEFORE DELETE ON public.variant FOR EACH ROW EXECUTE FUNCTION public.variant_before_delete();


--
-- Name: warehouse warehouse_after_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER warehouse_after_insert AFTER INSERT ON public.warehouse FOR EACH ROW EXECUTE FUNCTION public.warehouse_after_insert();


--
-- Name: warehouse warehouse_before_insert; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER warehouse_before_insert BEFORE INSERT ON public.warehouse FOR EACH ROW EXECUTE FUNCTION public.warehouse_before_insert();


--
-- Name: admin_comment admin_comment_essence_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_comment
    ADD CONSTRAINT admin_comment_essence_id_fkey FOREIGN KEY (essence_id) REFERENCES public.essence(essence_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: admin_comment admin_comment_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_comment
    ADD CONSTRAINT admin_comment_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: article article_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: article article_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(image_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: article article_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: article article_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_resource auth_resource_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_resource
    ADD CONSTRAINT auth_resource_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.auth_resource(resource_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_rule auth_rule_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT auth_rule_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.auth_resource(resource_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_rule auth_rule_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT auth_rule_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_rule auth_rule_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_rule
    ADD CONSTRAINT auth_rule_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.auth_task(task_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: auth_task auth_task_resource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_task
    ADD CONSTRAINT auth_task_resource_id_fkey FOREIGN KEY (resource_id) REFERENCES public.auth_resource(resource_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: basket_item basket_item_basket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_item
    ADD CONSTRAINT basket_item_basket_id_fkey FOREIGN KEY (basket_id) REFERENCES public.basket(basket_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: basket_item basket_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_item
    ADD CONSTRAINT basket_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: basket_item basket_item_item_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket_item
    ADD CONSTRAINT basket_item_item_price_id_fkey FOREIGN KEY (item_price_id) REFERENCES public.item_price(item_price_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: basket basket_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.basket
    ADD CONSTRAINT basket_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: box_text box_text_box_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.box_text
    ADD CONSTRAINT box_text_box_id_fkey FOREIGN KEY (box_id) REFERENCES public.box(box_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: box_text box_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.box_text
    ADD CONSTRAINT box_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category category_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: category category_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(image_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: category_menu_rel category_menu_rel_block_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_menu_rel
    ADD CONSTRAINT category_menu_rel_block_id_fkey FOREIGN KEY (block_id) REFERENCES public.menu_block(block_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category_menu_rel category_menu_rel_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_menu_rel
    ADD CONSTRAINT category_menu_rel_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category category_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category_prop category_prop_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_prop
    ADD CONSTRAINT category_prop_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category_prop category_prop_filter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_prop
    ADD CONSTRAINT category_prop_filter_id_fkey FOREIGN KEY (filter_id) REFERENCES public.filter(filter_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: category category_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category_text category_text_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_text
    ADD CONSTRAINT category_text_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: category_text category_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category_text
    ADD CONSTRAINT category_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic characteristic_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic
    ADD CONSTRAINT characteristic_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.commodity_group(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic characteristic_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic
    ADD CONSTRAINT characteristic_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.characteristic(characteristic_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_product_val characteristic_product_val_case_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_product_val
    ADD CONSTRAINT characteristic_product_val_case_id_fkey FOREIGN KEY (case_id) REFERENCES public.characteristic_type_case(case_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_product_val characteristic_product_val_characteristic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_product_val
    ADD CONSTRAINT characteristic_product_val_characteristic_id_fkey FOREIGN KEY (characteristic_id) REFERENCES public.characteristic(characteristic_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_product_val characteristic_product_val_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_product_val
    ADD CONSTRAINT characteristic_product_val_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_product_val_text characteristic_product_val_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_product_val_text
    ADD CONSTRAINT characteristic_product_val_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_product_val_text characteristic_product_val_text_value_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_product_val_text
    ADD CONSTRAINT characteristic_product_val_text_value_id_fkey FOREIGN KEY (value_id) REFERENCES public.characteristic_product_val(value_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_prop characteristic_prop_characteristic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_prop
    ADD CONSTRAINT characteristic_prop_characteristic_id_fkey FOREIGN KEY (characteristic_id) REFERENCES public.characteristic(characteristic_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_text characteristic_text_characteristic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_text
    ADD CONSTRAINT characteristic_text_characteristic_id_fkey FOREIGN KEY (characteristic_id) REFERENCES public.characteristic(characteristic_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_text characteristic_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_text
    ADD CONSTRAINT characteristic_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_type_case characteristic_type_case_characteristic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_type_case
    ADD CONSTRAINT characteristic_type_case_characteristic_id_fkey FOREIGN KEY (characteristic_id) REFERENCES public.characteristic(characteristic_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_type_case_text characteristic_type_case_text_case_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_type_case_text
    ADD CONSTRAINT characteristic_type_case_text_case_id_fkey FOREIGN KEY (case_id) REFERENCES public.characteristic_type_case(case_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_type_case_text characteristic_type_case_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_type_case_text
    ADD CONSTRAINT characteristic_type_case_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_variant_val characteristic_variant_val_case_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_variant_val
    ADD CONSTRAINT characteristic_variant_val_case_id_fkey FOREIGN KEY (case_id) REFERENCES public.characteristic_type_case(case_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_variant_val characteristic_variant_val_characteristic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_variant_val
    ADD CONSTRAINT characteristic_variant_val_characteristic_id_fkey FOREIGN KEY (characteristic_id) REFERENCES public.characteristic(characteristic_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: characteristic_variant_val_text characteristic_variant_val_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_variant_val_text
    ADD CONSTRAINT characteristic_variant_val_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: characteristic_variant_val_text characteristic_variant_val_text_value_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_variant_val_text
    ADD CONSTRAINT characteristic_variant_val_text_value_id_fkey FOREIGN KEY (value_id) REFERENCES public.characteristic_variant_val(value_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: characteristic_variant_val characteristic_variant_val_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.characteristic_variant_val
    ADD CONSTRAINT characteristic_variant_val_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variant(variant_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: collection collection_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: collection_product_rel collection_product_rel_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_product_rel
    ADD CONSTRAINT collection_product_rel_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collection(collection_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: collection_product_rel collection_product_rel_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection_product_rel
    ADD CONSTRAINT collection_product_rel_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: collection collection_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.collection
    ADD CONSTRAINT collection_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: commodity_group_text commodity_group_text_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commodity_group_text
    ADD CONSTRAINT commodity_group_text_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.commodity_group(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: commodity_group_text commodity_group_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commodity_group_text
    ADD CONSTRAINT commodity_group_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: commodity_group commodity_group_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commodity_group
    ADD CONSTRAINT commodity_group_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.unit_measurement(unit_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: coupon_code coupon_code_campaign_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_code
    ADD CONSTRAINT coupon_code_campaign_id_fkey FOREIGN KEY (campaign_id) REFERENCES public.coupon_campaign(campaign_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cross_sell cross_sell_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell
    ADD CONSTRAINT cross_sell_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.cross_sell_category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cross_sell cross_sell_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell
    ADD CONSTRAINT cross_sell_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cross_sell cross_sell_rel_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cross_sell
    ADD CONSTRAINT cross_sell_rel_product_id_fkey FOREIGN KEY (rel_product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_group customer_group_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group
    ADD CONSTRAINT customer_group_price_id_fkey FOREIGN KEY (price_id) REFERENCES public.price(price_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_group_text customer_group_text_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group_text
    ADD CONSTRAINT customer_group_text_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.customer_group(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: customer_group_text customer_group_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_group_text
    ADD CONSTRAINT customer_group_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_city delivery_city_site_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_city
    ADD CONSTRAINT delivery_city_site_delivery_id_fkey FOREIGN KEY (delivery_site_id) REFERENCES public.delivery_site(delivery_site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_city_text delivery_city_text_delivery_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_city_text
    ADD CONSTRAINT delivery_city_text_delivery_city_id_fkey FOREIGN KEY (delivery_city_id) REFERENCES public.delivery_city(delivery_city_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_city_text delivery_city_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_city_text
    ADD CONSTRAINT delivery_city_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_country delivery_country_delivery_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_country
    ADD CONSTRAINT delivery_country_delivery_site_id_fkey FOREIGN KEY (delivery_site_id) REFERENCES public.delivery_site(delivery_site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_country_text delivery_country_text_delivery_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_country_text
    ADD CONSTRAINT delivery_country_text_delivery_country_id_fkey FOREIGN KEY (delivery_country_id) REFERENCES public.delivery_country(delivery_country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_country_text delivery_country_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_country_text
    ADD CONSTRAINT delivery_country_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery delivery_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery
    ADD CONSTRAINT delivery_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: delivery_exclude_city delivery_exclude_city_delivery_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_exclude_city
    ADD CONSTRAINT delivery_exclude_city_delivery_site_id_fkey FOREIGN KEY (delivery_site_id) REFERENCES public.delivery_site(delivery_site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_text delivery_text_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_text
    ADD CONSTRAINT delivery_text_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.delivery(delivery_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_text delivery_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_text
    ADD CONSTRAINT delivery_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: filter_field filter_field_characteristic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filter_field
    ADD CONSTRAINT filter_field_characteristic_id_fkey FOREIGN KEY (characteristic_id) REFERENCES public.characteristic(characteristic_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: filter_field filter_field_filter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filter_field
    ADD CONSTRAINT filter_field_filter_id_fkey FOREIGN KEY (filter_id) REFERENCES public.filter(filter_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: final_price final_price_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.final_price
    ADD CONSTRAINT final_price_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES public.currency(currency_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: final_price final_price_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.final_price
    ADD CONSTRAINT final_price_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: final_price final_price_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.final_price
    ADD CONSTRAINT final_price_point_id_fkey FOREIGN KEY (point_id) REFERENCES public.point_sale(point_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: final_price final_price_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.final_price
    ADD CONSTRAINT final_price_price_id_fkey FOREIGN KEY (price_id) REFERENCES public.price(price_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: image image_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: image image_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: image_tag_rel image_tag_rel_image_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_tag_rel
    ADD CONSTRAINT image_tag_rel_image_tag_id_fkey FOREIGN KEY (image_tag_id) REFERENCES public.image_tag(image_tag_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: image_tag_rel image_tag_rel_product_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.image_tag_rel
    ADD CONSTRAINT image_tag_rel_product_image_id_fkey FOREIGN KEY (product_image_id) REFERENCES public.product_image(product_image_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_item inventory_item_custom_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT inventory_item_custom_item_id_fkey FOREIGN KEY (custom_item_id) REFERENCES public.custom_item(custom_item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_item inventory_item_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT inventory_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_item inventory_item_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT inventory_item_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variant(variant_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_location inventory_location_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_location
    ADD CONSTRAINT inventory_location_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(warehouse_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_movement_item inventory_movement_item_from_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement_item
    ADD CONSTRAINT inventory_movement_item_from_location_id_fkey FOREIGN KEY (from_location_id) REFERENCES public.inventory_location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_movement_item inventory_movement_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement_item
    ADD CONSTRAINT inventory_movement_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_movement_item inventory_movement_item_movement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement_item
    ADD CONSTRAINT inventory_movement_item_movement_id_fkey FOREIGN KEY (movement_id) REFERENCES public.inventory_movement(movement_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_movement_item inventory_movement_item_to_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement_item
    ADD CONSTRAINT inventory_movement_item_to_location_id_fkey FOREIGN KEY (to_location_id) REFERENCES public.inventory_location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_movement inventory_movement_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement
    ADD CONSTRAINT inventory_movement_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inventory_movement inventory_movement_reason_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement
    ADD CONSTRAINT inventory_movement_reason_id_fkey FOREIGN KEY (reason_id) REFERENCES public.inventory_option(option_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inventory_movement inventory_movement_reserve_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_movement
    ADD CONSTRAINT inventory_movement_reserve_id_fkey FOREIGN KEY (reserve_id) REFERENCES public.reserve(reserve_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: inventory_option_text inventory_option_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_option_text
    ADD CONSTRAINT inventory_option_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_option_text inventory_option_text_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_option_text
    ADD CONSTRAINT inventory_option_text_option_id_fkey FOREIGN KEY (option_id) REFERENCES public.inventory_option(option_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_price inventory_price_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_price
    ADD CONSTRAINT inventory_price_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES public.currency(currency_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_price inventory_price_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_price
    ADD CONSTRAINT inventory_price_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_price inventory_price_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_price
    ADD CONSTRAINT inventory_price_price_id_fkey FOREIGN KEY (price_id) REFERENCES public.price(price_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_stock inventory_stock_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_stock
    ADD CONSTRAINT inventory_stock_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_stock inventory_stock_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_stock
    ADD CONSTRAINT inventory_stock_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.inventory_location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inventory_stock inventory_stock_supply_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory_stock
    ADD CONSTRAINT inventory_stock_supply_id_fkey FOREIGN KEY (supply_id) REFERENCES public.inventory_supply(supply_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: item_price item_price_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.item_price
    ADD CONSTRAINT item_price_price_id_fkey FOREIGN KEY (price_id) REFERENCES public.price(price_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: label_text label_text_label_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.label_text
    ADD CONSTRAINT label_text_label_id_fkey FOREIGN KEY (label_id) REFERENCES public.label(label_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: label_text label_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.label_text
    ADD CONSTRAINT label_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lang_title lang_title_in_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lang_title
    ADD CONSTRAINT lang_title_in_lang_id_fkey FOREIGN KEY (in_lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lang_title lang_title_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lang_title
    ADD CONSTRAINT lang_title_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: manufacturer manufacturer_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturer_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(image_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: manufacturer_text manufacturer_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_text
    ADD CONSTRAINT manufacturer_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: manufacturer_text manufacturer_text_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.manufacturer_text
    ADD CONSTRAINT manufacturer_text_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(manufacturer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu_block menu_block_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_block
    ADD CONSTRAINT menu_block_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu_item menu_item_block_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item
    ADD CONSTRAINT menu_item_block_id_fkey FOREIGN KEY (block_id) REFERENCES public.menu_block(block_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu_item menu_item_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item
    ADD CONSTRAINT menu_item_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu_item menu_item_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item
    ADD CONSTRAINT menu_item_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.menu_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu_item_rel menu_item_rel_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item_rel
    ADD CONSTRAINT menu_item_rel_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: menu_item_rel menu_item_rel_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item_rel
    ADD CONSTRAINT menu_item_rel_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.menu_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu_item_rel menu_item_rel_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item_rel
    ADD CONSTRAINT menu_item_rel_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.page(page_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: menu_item_rel menu_item_rel_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menu_item_rel
    ADD CONSTRAINT menu_item_rel_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: notification_template notification_template_rel_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_template
    ADD CONSTRAINT notification_template_rel_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_status(status_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: offer offer_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offer
    ADD CONSTRAINT offer_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_discount order_discount_code_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_discount
    ADD CONSTRAINT order_discount_code_id_fkey FOREIGN KEY (code_id) REFERENCES public.coupon_code(code_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: order_discount order_discount_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_discount
    ADD CONSTRAINT order_discount_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_history order_history_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_history
    ADD CONSTRAINT order_history_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_history order_history_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_history
    ADD CONSTRAINT order_history_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_history order_history_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_history
    ADD CONSTRAINT order_history_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_status(status_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_prop order_prop_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_prop
    ADD CONSTRAINT order_prop_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_service_delivery order_service_delivery_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_service_delivery
    ADD CONSTRAINT order_service_delivery_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.delivery(delivery_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_service_delivery order_service_delivery_order_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_service_delivery
    ADD CONSTRAINT order_service_delivery_order_service_id_fkey FOREIGN KEY (order_service_id) REFERENCES public.order_service(order_service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_service order_service_item_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_service
    ADD CONSTRAINT order_service_item_price_id_fkey FOREIGN KEY (item_price_id) REFERENCES public.item_price(item_price_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_service order_service_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_service
    ADD CONSTRAINT order_service_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_service order_service_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_service
    ADD CONSTRAINT order_service_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_source_text order_source_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_source_text
    ADD CONSTRAINT order_source_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_source_text order_source_text_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_source_text
    ADD CONSTRAINT order_source_text_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.order_source(source_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_status order_status_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT order_status_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.order_status(status_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_status_text order_status_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_status_text
    ADD CONSTRAINT order_status_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_status_text order_status_text_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_status_text
    ADD CONSTRAINT order_status_text_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_status(status_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: track_number order_track_number_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.track_number
    ADD CONSTRAINT order_track_number_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: orders orders_basket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_basket_id_fkey FOREIGN KEY (basket_id) REFERENCES public.basket(basket_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: orders orders_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_client_id_fkey FOREIGN KEY (customer_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: orders orders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: orders orders_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_payment_method_id_fkey FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(payment_method_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: orders orders_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_point_id_fkey FOREIGN KEY (point_id) REFERENCES public.point_sale(point_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: orders orders_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_source_id_fkey FOREIGN KEY (source_id) REFERENCES public.order_source(source_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: orders orders_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.order_status(status_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: page page_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page page_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page_props page_props_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_props
    ADD CONSTRAINT page_props_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.page(page_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page page_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(route_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: page page_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: page page_typearea_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_typearea_id_fkey FOREIGN KEY (typearea_id) REFERENCES public.typearea(typearea_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_callback payment_callback_payment_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_callback
    ADD CONSTRAINT payment_callback_payment_transaction_id_fkey FOREIGN KEY (payment_transaction_id) REFERENCES public.payment_transaction(payment_transaction_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_method_delivery payment_method_delivery_delivery_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method_delivery
    ADD CONSTRAINT payment_method_delivery_delivery_site_id_fkey FOREIGN KEY (delivery_site_id) REFERENCES public.delivery_site(delivery_site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_method_delivery payment_method_delivery_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method_delivery
    ADD CONSTRAINT payment_method_delivery_payment_method_id_fkey FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(payment_method_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_method payment_method_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT payment_method_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_method_text payment_method_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method_text
    ADD CONSTRAINT payment_method_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_method_text payment_method_text_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_method_text
    ADD CONSTRAINT payment_method_text_payment_method_id_fkey FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(payment_method_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_request payment_request_payment_transaction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_request
    ADD CONSTRAINT payment_request_payment_transaction_id_fkey FOREIGN KEY (payment_transaction_id) REFERENCES public.payment_transaction(payment_transaction_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: payment_transaction payment_transaction_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT payment_transaction_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES public.currency(currency_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: payment_transaction payment_transaction_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT payment_transaction_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: payment_transaction payment_transaction_payment_method_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT payment_transaction_payment_method_id_fkey FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(payment_method_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: payment_transaction payment_transaction_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_transaction
    ADD CONSTRAINT payment_transaction_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: person_address person_address_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_address
    ADD CONSTRAINT person_address_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_auth person_auth_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_auth
    ADD CONSTRAINT person_auth_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person person_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_profile person_profile_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_profile
    ADD CONSTRAINT person_profile_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.customer_group(group_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: person_profile person_profile_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_profile
    ADD CONSTRAINT person_profile_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_role_rel person_role_rel_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_role_rel
    ADD CONSTRAINT person_role_rel_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_role_rel person_role_rel_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_role_rel
    ADD CONSTRAINT person_role_rel_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(role_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_search person_search_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_search
    ADD CONSTRAINT person_search_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_settings person_settings_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_settings
    ADD CONSTRAINT person_settings_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person person_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_token person_token_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_token
    ADD CONSTRAINT person_token_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: person_visitor person_visitor_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person_visitor
    ADD CONSTRAINT person_visitor_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: point_sale point_sale_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.point_sale
    ADD CONSTRAINT point_sale_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price_text price_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_text
    ADD CONSTRAINT price_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: price_text price_text_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.price_text
    ADD CONSTRAINT price_text_price_id_fkey FOREIGN KEY (price_id) REFERENCES public.price(price_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_category_rel product_category_rel_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category_rel
    ADD CONSTRAINT product_category_rel_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_category_rel product_category_rel_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_category_rel
    ADD CONSTRAINT product_category_rel_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product product_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: product product_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.commodity_group(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_image product_image_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(image_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_image product_image_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_image_text product_image_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image_text
    ADD CONSTRAINT product_image_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_image_text product_image_text_product_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_image_text
    ADD CONSTRAINT product_image_text_product_image_id_fkey FOREIGN KEY (product_image_id) REFERENCES public.product_image(product_image_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import_imgs product_import_imgs_import_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_imgs
    ADD CONSTRAINT product_import_imgs_import_id_fkey FOREIGN KEY (import_id) REFERENCES public.product_import(import_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import_imgs product_import_imgs_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_imgs
    ADD CONSTRAINT product_import_imgs_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import product_import_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import
    ADD CONSTRAINT product_import_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import_log product_import_log_import_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_log
    ADD CONSTRAINT product_import_log_import_id_fkey FOREIGN KEY (import_id) REFERENCES public.product_import(import_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import product_import_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import
    ADD CONSTRAINT product_import_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import_rel product_import_rel_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_rel
    ADD CONSTRAINT product_import_rel_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import_rel product_import_rel_log_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_rel
    ADD CONSTRAINT product_import_rel_log_id_fkey FOREIGN KEY (log_id) REFERENCES public.product_import_log(log_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import_rel product_import_rel_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_rel
    ADD CONSTRAINT product_import_rel_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import_rel product_import_rel_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import_rel
    ADD CONSTRAINT product_import_rel_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variant(variant_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_import product_import_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_import
    ADD CONSTRAINT product_import_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_label_rel product_label_rel_label_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_label_rel
    ADD CONSTRAINT product_label_rel_label_id_fkey FOREIGN KEY (label_id) REFERENCES public.label(label_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_label_rel product_label_rel_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_label_rel
    ADD CONSTRAINT product_label_rel_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product product_manufacturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_manufacturer_id_fkey FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(manufacturer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_prop product_prop_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_prop
    ADD CONSTRAINT product_prop_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_prop product_prop_tax_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_prop
    ADD CONSTRAINT product_prop_tax_class_id_fkey FOREIGN KEY (tax_class_id) REFERENCES public.tax_class(tax_class_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: product_review product_review_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT product_review_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_review_img product_review_img_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review_img
    ADD CONSTRAINT product_review_img_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(image_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_review_img product_review_img_review_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review_img
    ADD CONSTRAINT product_review_img_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.product_review(review_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_review product_review_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT product_review_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_review product_review_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_review
    ADD CONSTRAINT product_review_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_text product_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_text
    ADD CONSTRAINT product_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_text product_text_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_text
    ADD CONSTRAINT product_text_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variant_characteristic product_variant_characteristic_characteristic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_characteristic
    ADD CONSTRAINT product_variant_characteristic_characteristic_id_fkey FOREIGN KEY (characteristic_id) REFERENCES public.characteristic(characteristic_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_variant_characteristic product_variant_characteristic_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variant_characteristic
    ADD CONSTRAINT product_variant_characteristic_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_yml product_yml_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_yml
    ADD CONSTRAINT product_yml_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reserve_item reserve_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve_item
    ADD CONSTRAINT reserve_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reserve_item reserve_item_item_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve_item
    ADD CONSTRAINT reserve_item_item_price_id_fkey FOREIGN KEY (item_price_id) REFERENCES public.item_price(item_price_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: reserve_item reserve_item_reserve_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve_item
    ADD CONSTRAINT reserve_item_reserve_id_fkey FOREIGN KEY (reserve_id) REFERENCES public.reserve(reserve_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reserve_item reserve_item_stock_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve_item
    ADD CONSTRAINT reserve_item_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES public.inventory_stock(stock_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: reserve reserve_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reserve
    ADD CONSTRAINT reserve_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_text service_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_text
    ADD CONSTRAINT service_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_text service_text_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service_text
    ADD CONSTRAINT service_text_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: site_country_lang site_country_lang_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_country_lang
    ADD CONSTRAINT site_country_lang_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: site_country_lang site_country_lang_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_country_lang
    ADD CONSTRAINT site_country_lang_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_site site_delivery_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_site
    ADD CONSTRAINT site_delivery_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.delivery(delivery_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: delivery_site site_delivery_site_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_site
    ADD CONSTRAINT site_delivery_site_id_fkey FOREIGN KEY (site_id) REFERENCES public.site(site_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tax_rate tax_rate_tax_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tax_rate
    ADD CONSTRAINT tax_rate_tax_class_id_fkey FOREIGN KEY (tax_class_id) REFERENCES public.tax_class(tax_class_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: theme_installed_text theme_installed_text_installed_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme_installed_text
    ADD CONSTRAINT theme_installed_text_installed_id_fkey FOREIGN KEY (installed_id) REFERENCES public.theme_installed(installed_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: theme_installed_text theme_installed_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.theme_installed_text
    ADD CONSTRAINT theme_installed_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transfer transfer_cancelled_movement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer
    ADD CONSTRAINT transfer_cancelled_movement_id_fkey FOREIGN KEY (cancelled_movement_id) REFERENCES public.inventory_movement(movement_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: transfer transfer_completed_movement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer
    ADD CONSTRAINT transfer_completed_movement_id_fkey FOREIGN KEY (completed_movement_id) REFERENCES public.inventory_movement(movement_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: transfer transfer_from_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer
    ADD CONSTRAINT transfer_from_location_id_fkey FOREIGN KEY (from_location_id) REFERENCES public.inventory_location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transfer_item transfer_item_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer_item
    ADD CONSTRAINT transfer_item_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.inventory_item(item_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transfer_item transfer_item_transfer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer_item
    ADD CONSTRAINT transfer_item_transfer_id_fkey FOREIGN KEY (transfer_id) REFERENCES public.transfer(transfer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transfer transfer_to_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transfer
    ADD CONSTRAINT transfer_to_location_id_fkey FOREIGN KEY (to_location_id) REFERENCES public.inventory_location(location_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: typearea_block_text typearea_block_text_block_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typearea_block_text
    ADD CONSTRAINT typearea_block_text_block_id_fkey FOREIGN KEY (block_id) REFERENCES public.typearea_block(block_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: typearea_block typearea_block_typearea_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.typearea_block
    ADD CONSTRAINT typearea_block_typearea_id_fkey FOREIGN KEY (typearea_id) REFERENCES public.typearea(typearea_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: variant_image variant_image_image_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_image
    ADD CONSTRAINT variant_image_image_id_fkey FOREIGN KEY (image_id) REFERENCES public.image(image_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: variant_image variant_image_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_image
    ADD CONSTRAINT variant_image_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variant(variant_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: variant variant_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant
    ADD CONSTRAINT variant_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: variant_text variant_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_text
    ADD CONSTRAINT variant_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: variant_text variant_text_variant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variant_text
    ADD CONSTRAINT variant_text_variant_id_fkey FOREIGN KEY (variant_id) REFERENCES public.variant(variant_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: warehouse_text warehouse_text_lang_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.warehouse_text
    ADD CONSTRAINT warehouse_text_lang_id_fkey FOREIGN KEY (lang_id) REFERENCES public.lang(lang_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: warehouse_text warehouse_text_warehouse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.warehouse_text
    ADD CONSTRAINT warehouse_text_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(warehouse_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: webhook_log webhook_log_webhook_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook_log
    ADD CONSTRAINT webhook_log_webhook_id_fk FOREIGN KEY (webhook_id) REFERENCES public.webhook(webhook_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vw_city; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.vw_city;


--
-- Name: vw_country; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.vw_country;


--
-- Name: vw_delivery_city; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.vw_delivery_city;


--
-- Name: vw_delivery_country; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.vw_delivery_country;


--
-- Name: vw_region; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.vw_region;


--
-- Name: vw_shipping; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.vw_shipping;


--
-- Name: vw_shipping_city; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.vw_shipping_city;


--
-- Name: vw_shipping_zip; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: -
--

REFRESH MATERIALIZED VIEW public.vw_shipping_zip;


--
-- PostgreSQL database dump complete
--

