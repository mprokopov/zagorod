CREATE TABLE `agencies` (
  `id` int(11) NOT NULL auto_increment,
  `fio` varchar(200) default '',
  `name` varchar(200) default '',
  `address` varchar(200) default '',
  `phone1` varchar(100) default '',
  `phone2` varchar(100) default '',
  `email` varchar(200) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `buildings` (
  `id` int(11) NOT NULL auto_increment,
  `building` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `buildings_lots` (
  `lot_id` int(11) NOT NULL default '0',
  `building_id` int(11) NOT NULL default '0',
  KEY `ind` (`lot_id`,`building_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `buildobjects` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `buildobjects_lots` (
  `lot_id` int(11) NOT NULL default '0',
  `buildobject_id` int(11) NOT NULL default '0',
  KEY `composite` (`lot_id`,`buildobject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `city_distances` (
  `id` int(11) NOT NULL auto_increment,
  `distance` varchar(200) NOT NULL default '',
  `min_distance` int(11) NOT NULL default '0',
  `max_distance` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `departures` (
  `id` int(11) NOT NULL auto_increment,
  `departure` varchar(200) NOT NULL default '',
  `xpoint` int(11) NOT NULL default '0',
  `ypoint` int(11) NOT NULL default '0',
  `image` varchar(150) NOT NULL default '',
  `image2` varchar(150) NOT NULL default '',
  `title` varchar(150) NOT NULL default '',
  `name` varchar(150) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `electricities` (
  `id` int(11) NOT NULL auto_increment,
  `distance` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `full_prices` (
  `id` int(11) NOT NULL auto_increment,
  `price` varchar(200) NOT NULL default '',
  `min_price` float NOT NULL default '0',
  `max_price` float NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `gas` (
  `id` int(11) NOT NULL auto_increment,
  `distance` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `greens` (
  `id` int(11) NOT NULL auto_increment,
  `green` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `greens_lots` (
  `lot_id` int(11) NOT NULL default '0',
  `green_id` int(11) NOT NULL default '0',
  KEY `lot_green` (`lot_id`,`green_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `grounds` (
  `id` int(11) NOT NULL auto_increment,
  `ground` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `groundwater_levels` (
  `id` int(11) NOT NULL auto_increment,
  `level` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lotroad_distances` (
  `id` int(11) NOT NULL auto_increment,
  `distance` varchar(150) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lotroad_surfaces` (
  `id` int(11) NOT NULL auto_increment,
  `surface` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lotroad_widths` (
  `id` int(11) NOT NULL auto_increment,
  `width` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lots` (
  `id` int(11) NOT NULL auto_increment,
  `area` varchar(200) NOT NULL default '',
  `square` float NOT NULL default '0',
  `price_per_square` int(11) NOT NULL default '0',
  `is_price_changeble` tinyint(1) NOT NULL default '0',
  `distance_to_city` float NOT NULL default '0',
  `departure_id` int(11) NOT NULL default '0',
  `lotroad_distance_id` int(11) NOT NULL default '0',
  `lotroad_surface_id` int(11) NOT NULL default '0',
  `lotroad_width_id` int(11) NOT NULL default '0',
  `is_another_routes` tinyint(1) NOT NULL default '0',
  `gas_id` int(11) NOT NULL default '0',
  `electricity_id` int(11) NOT NULL default '0',
  `water_id` int(11) NOT NULL default '0',
  `nearest_shop_distance` float default '0',
  `nearest_kiosk_distance` float default '0',
  `nearest_commerce_another` text,
  `placement_id` int(11) NOT NULL default '0',
  `placement_another` text NOT NULL,
  `nature_types_another` text NOT NULL,
  `lot_length` float NOT NULL default '0',
  `lot_width` float NOT NULL default '0',
  `lot_shape` varchar(200) NOT NULL default '',
  `ground_id` int(11) NOT NULL default '0',
  `ground_another` text NOT NULL,
  `building_another` text NOT NULL,
  `green_another` varchar(200) NOT NULL,
  `relief_another` text NOT NULL,
  `groundwater_level_id` int(11) NOT NULL default '0',
  `noise_source_another` text NOT NULL,
  `buildobjects_another` text NOT NULL,
  `extra_info` text NOT NULL,
  `region_id` int(11) NOT NULL default '0',
  `square_for_building` float NOT NULL default '0',
  `noise_id` int(11) NOT NULL default '0',
  `full_price` float NOT NULL default '0',
  `lotroad_surface_another` varchar(200) NOT NULL default '',
  `nearest_shop_distance_another` varchar(200) NOT NULL default '',
  `is_reviewed` tinyint(1) NOT NULL default '0',
  `point_x` int(11) NOT NULL default '0',
  `point_y` int(11) NOT NULL default '0',
  `agency_id` int(11) default NULL,
  `owner_id` int(11) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `areaindex` (`area`),
  KEY `squareindex` (`square`),
  KEY `departure_id` (`departure_id`),
  KEY `distance_to_road` (`lotroad_distance_id`),
  KEY `surface_to_road` (`lotroad_surface_id`),
  KEY `surface_width` (`lotroad_width_id`),
  KEY `gas` (`gas_id`),
  KEY `electricity` (`electricity_id`),
  KEY `water` (`water_id`),
  KEY `placement` (`placement_id`),
  KEY `ground` (`ground_id`),
  KEY `groundwater` (`groundwater_level_id`),
  KEY `region_id` (`region_id`),
  KEY `noise_id` (`noise_id`),
  KEY `full_price` (`full_price`),
  KEY `owner_id` (`owner_id`),
  KEY `agency_id` (`agency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lots_natures` (
  `id` int(11) NOT NULL auto_increment,
  `lot_id` int(11) NOT NULL default '0',
  `nature_type_id` int(11) NOT NULL default '0',
  `nature_distance_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `lots_natures_index` (`nature_type_id`,`nature_distance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lots_neighbours` (
  `id` int(11) NOT NULL auto_increment,
  `lot_id` int(11) NOT NULL default '0',
  `neighbour_distance_id` int(11) NOT NULL default '0',
  `neighbour_type_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `lots_neighbours_index` (`neighbour_distance_id`,`neighbour_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lots_noise_sources` (
  `lot_id` int(11) NOT NULL default '0',
  `noise_source_id` int(11) NOT NULL default '0',
  KEY `lots_noise_sources_index` (`lot_id`,`noise_source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lots_reliefs` (
  `lot_id` int(11) NOT NULL default '0',
  `relief_id` int(11) NOT NULL default '0',
  KEY `lots_reliefs_index` (`lot_id`,`relief_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `lots_routes` (
  `id` int(11) NOT NULL auto_increment,
  `lot_id` int(11) NOT NULL default '0',
  `route_distance_id` int(11) NOT NULL default '0',
  `route_type_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `lots_routes_index` (`route_distance_id`,`route_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `nature_distances` (
  `id` int(11) NOT NULL auto_increment,
  `distance` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `nature_types` (
  `id` int(11) NOT NULL auto_increment,
  `nature` varchar(200) NOT NULL default '',
  `has_distance` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`),
  KEY `has_distance` (`has_distance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `neighbour_distances` (
  `id` int(11) NOT NULL auto_increment,
  `distance` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `neighbour_types` (
  `id` int(11) NOT NULL auto_increment,
  `neighbour` varchar(200) NOT NULL default '',
  `has_distance` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `noise_sources` (
  `id` int(11) NOT NULL auto_increment,
  `source` varchar(150) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `noises` (
  `id` int(11) NOT NULL auto_increment,
  `noise` varchar(150) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `owners` (
  `id` int(11) NOT NULL auto_increment,
  `fio` varchar(200) default '',
  `phone_city` varchar(200) default '',
  `phone` varchar(200) default '',
  `another_contact_fio` varchar(200) default NULL,
  `another_contact_phone` varchar(200) default NULL,
  `email` varchar(200) default NULL,
  `created_on` datetime default NULL,
  `updated_on` datetime default NULL,
  `is_other_contacts_allowed` int(11) NOT NULL default '0',
  `preferred_contact_type` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `parent_id` int(11) default '0',
  `url` varchar(255) default NULL,
  `text` text,
  `is_published` int(4) default NULL,
  `in_top_menu` varchar(0) default '',
  `has_left_menu` int(11) default '0',
  `title` varchar(255) default NULL,
  `preview` text,
  `keywords` text NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `page_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `photos` (
  `id` int(11) NOT NULL auto_increment,
  `lot_id` int(11) NOT NULL default '0',
  `image` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `lotid` (`lot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `placements` (
  `id` int(11) NOT NULL auto_increment,
  `placement` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `prices` (
  `id` int(11) NOT NULL auto_increment,
  `price` varchar(100) NOT NULL default '0',
  `min_price` float NOT NULL default '0',
  `max_price` float NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `regions` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `reliefs` (
  `id` int(11) NOT NULL auto_increment,
  `relief` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `route_distances` (
  `id` int(11) NOT NULL auto_increment,
  `distance` varchar(150) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `route_types` (
  `id` int(11) NOT NULL auto_increment,
  `route` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL auto_increment,
  `session_id` varchar(255) default NULL,
  `data` text,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `sessions_session_id_index` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `squares` (
  `id` int(11) NOT NULL auto_increment,
  `square` varchar(100) NOT NULL default '',
  `min_square` float NOT NULL default '0',
  `max_square` float NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(80) default NULL,
  `password` varchar(40) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `waters` (
  `id` int(11) NOT NULL auto_increment,
  `object` varchar(200) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO schema_info (version) VALUES (44)