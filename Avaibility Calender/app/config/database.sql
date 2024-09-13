
DROP TABLE IF EXISTS `abcalendar_calendars`;
CREATE TABLE IF NOT EXISTS `abcalendar_calendars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(12) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `y_logo` varchar(255) DEFAULT NULL,
  `y_country` int(11) DEFAULT NULL,
  `y_zip` varchar(255) DEFAULT NULL,
  `y_phone` varchar(255) DEFAULT NULL,
  `y_fax` varchar(255) DEFAULT NULL,
  `y_email` varchar(255) DEFAULT NULL,
  `y_url` varchar(255) DEFAULT NULL,
  `status` enum('T','F') DEFAULT 'T',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `abcalendar_limits`;
CREATE TABLE IF NOT EXISTS `abcalendar_limits` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,  
	`calendar_id` int(10) unsigned DEFAULT NULL,    
	`date_from` date DEFAULT NULL,                  
	`date_to` date DEFAULT NULL,                    
	`min_nights` tinyint(3) unsigned DEFAULT NULL,  
	`max_nights` tinyint(3) unsigned DEFAULT NULL,  
	PRIMARY KEY (`id`),                             
	KEY `calendar_id` (`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `abcalendar_options`;
CREATE TABLE IF NOT EXISTS `abcalendar_options` (
  `foreign_id` int(10) unsigned NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL DEFAULT '',
  `tab_id` tinyint(3) unsigned DEFAULT NULL,
  `value` text,
  `label` text,
  `type` enum('string','text','int','float','enum','bool','color') NOT NULL DEFAULT 'string',
  `order` int(10) unsigned DEFAULT NULL,
  `is_visible` tinyint(1) unsigned DEFAULT '1',
  `style` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`foreign_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `abcalendar_options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(0, 'o_month_year_format', 0, 'Month Year|Month, Year|Year Month|Year, Month::Month Year', NULL, 'enum', 6, 1, NULL);

DROP TABLE IF EXISTS `abcalendar_password`;
CREATE TABLE IF NOT EXISTS `abcalendar_password` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `calendar_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `format` enum('ical','xml', 'csv') NOT NULL DEFAULT 'ical',
  `delimiter` enum('comma','semicolon', 'tab') DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` enum('all','next','last') DEFAULT NULL,
  `period` enum('1','2','3','4','5','6') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `abcalendar_reservations`;
CREATE TABLE IF NOT EXISTS `abcalendar_reservations` (
  	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,                  
	`calendar_id` int(10) unsigned NOT NULL,                        
	`uuid` varchar(255) DEFAULT NULL,                                
	`date_from` date DEFAULT NULL,                                  
	`date_to` date DEFAULT NULL,                                    
	`price_based_on` enum('nights','days') DEFAULT NULL,            
	`c_name` varchar(255) DEFAULT NULL,                             
	`c_email` varchar(255) DEFAULT NULL,                            
	`c_phone` varchar(255) DEFAULT NULL,                            
	`c_adults` smallint(5) unsigned DEFAULT NULL,                   
	`c_children` smallint(5) unsigned DEFAULT NULL,                 
	`c_notes` text,                                                 
	`c_address` varchar(255) DEFAULT NULL,                          
	`c_city` varchar(255) DEFAULT NULL,                             
	`c_country` int(10) unsigned DEFAULT NULL,                      
	`c_state` varchar(255) DEFAULT NULL,                            
	`c_zip` varchar(255) DEFAULT NULL,                              
	`modified` datetime DEFAULT NULL,                               
	`created` datetime DEFAULT NULL,                                
	`ip` varchar(15) DEFAULT NULL,                                  
	`amount` decimal(14,2) unsigned DEFAULT NULL,                    
	`deposit` decimal(14,2) unsigned DEFAULT NULL,                   
	`tax` decimal(14,2) unsigned DEFAULT NULL,                       
	`security` decimal(14,2) unsigned DEFAULT NULL,                  
	`payment_method` varchar(255) DEFAULT NULL,                     
	`cc_type` varchar(255) DEFAULT NULL,                            
	`cc_num` blob,                                                  
	`cc_exp_month` blob,                                            
	`cc_exp_year` blob,                                             
	`cc_code` blob,                                                 
	`txn_id` varchar(255) DEFAULT NULL,                             
	`processed_on` datetime DEFAULT NULL,                           
	`status` enum('Confirmed','Pending','Cancelled') DEFAULT NULL,  
	`locale_id` int(10) unsigned DEFAULT NULL,       
	`provider_id` tinyint(1) unsigned DEFAULT '0',
	PRIMARY KEY (`id`),                                             
	UNIQUE KEY `uuid` (`uuid`),                                     
	KEY `calendar_id` (`calendar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `abcalendar_notifications`;
CREATE TABLE IF NOT EXISTS `abcalendar_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `recipient` enum('client','admin', 'owner') DEFAULT NULL,
  `transport` enum('email','sms') DEFAULT NULL,
  `variant` varchar(30) DEFAULT NULL,
  `is_active` tinyint(1) unsigned DEFAULT '1',
  `is_general` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `recipient` (`foreign_id`,`recipient`,`transport`,`variant`, `is_general`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

INSERT IGNORE INTO `abcalendar_notifications` (`id`, `foreign_id`, `recipient`, `transport`, `variant`, `is_active`, `is_general`) VALUES
(NULL, 0, 'client', 'email', 'confirmation', 1, 0),
(NULL, 0, 'client', 'email', 'payment', 1, 0),
(NULL, 0, 'client', 'email', 'cancel', 1, 0),
(NULL, 0, 'owner', 'email', 'confirmation', 1, 0),
(NULL, 0, 'owner', 'email', 'payment', 1, 0),
(NULL, 0, 'owner', 'email', 'cancel', 1, 0),
(NULL, 0, 'owner', 'sms', 'confirmation', 1, 0),
(NULL, 0, 'owner', 'sms', 'payment', 1, 0),
(NULL, 0, 'owner', 'sms', 'cancel', 1, 0),
(NULL, 0, 'admin', 'email', 'confirmation', 1, 1),
(NULL, 0, 'admin', 'email', 'payment', 1, 1),
(NULL, 0, 'admin', 'email', 'cancel', 1, 1),
(NULL, 0, 'admin', 'sms', 'confirmation', 1, 1),
(NULL, 0, 'admin', 'sms', 'payment', 1, 1),
(NULL, 0, 'admin', 'sms', 'cancel', 1, 1);


DROP TABLE IF EXISTS `abcalendar_prices`;
CREATE TABLE IF NOT EXISTS `abcalendar_prices` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `foreign_id` INT(10) UNSIGNED NOT NULL,
  `tab_id` INT(10) UNSIGNED DEFAULT NULL,
  `season` VARCHAR(255) DEFAULT NULL,
  `date_from` DATE DEFAULT NULL,
  `date_to` DATE DEFAULT NULL,
  `adults` TINYINT(3) UNSIGNED DEFAULT NULL,
  `children` TINYINT(3) UNSIGNED DEFAULT NULL,
  `mon` decimal(14,2) UNSIGNED DEFAULT NULL,
  `tue` decimal(14,2) UNSIGNED DEFAULT NULL,
  `wed` decimal(14,2) UNSIGNED DEFAULT NULL,
  `thu` decimal(14,2) UNSIGNED DEFAULT NULL,
  `fri` decimal(14,2) UNSIGNED DEFAULT NULL,
  `sat` decimal(14,2) UNSIGNED DEFAULT NULL,
  `sun` decimal(14,2) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `season` (`foreign_id`,`tab_id`,`season`,`adults`,`children`),
  UNIQUE KEY `dates` (`foreign_id`,`date_from`,`date_to`,`tab_id`,`adults`,`children`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `abcalendar_period`;
CREATE TABLE IF NOT EXISTS `abcalendar_period` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,                                 
	`foreign_id` int(10) unsigned DEFAULT NULL,                                    
	`start_date` date DEFAULT NULL,                                                
	`end_date` date DEFAULT NULL,                                                  
	`from_day` smallint(1) DEFAULT NULL COMMENT '1 - Monday, 7 - Sunday',  
	`to_day` smallint(1) DEFAULT NULL COMMENT '1 - Monday, 7 - Sunday',    
	`default_price` decimal(14,2) unsigned DEFAULT NULL,                            
	PRIMARY KEY (`id`),                                                            
	KEY `foreign_id` (`foreign_id`) 
) ENGINE=INNODB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `abcalendar_period_price`;
CREATE TABLE IF NOT EXISTS `abcalendar_period_price` (
  	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,  
	`period_id` int(10) unsigned DEFAULT NULL,      
	`adults` smallint(5) unsigned DEFAULT NULL,     
	`children` smallint(5) unsigned DEFAULT NULL,   
	`price` decimal(14,2) unsigned DEFAULT NULL,     
	PRIMARY KEY (`id`),                             
	KEY `period_id` (`period_id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `abcalendar_feeds`;
CREATE TABLE `abcalendar_feeds` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `calendar_id` int(10) UNSIGNED NOT NULL,
  `provider_id` int(10) UNSIGNED NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `abcalendar_users_notifications`;
CREATE TABLE IF NOT EXISTS `abcalendar_users_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,             
  `user_id` int(10) unsigned DEFAULT NULL,                   
  `type` enum('mycal','all') DEFAULT 'mycal',        
  `variant` varchar(30) DEFAULT NULL,
  `transport` enum('email','sms') DEFAULT NULL,                   
  PRIMARY KEY (`id`),                                        
  UNIQUE KEY `user_id` (`user_id`,`type`,`variant`,`transport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `abcalendar_plugin_base_cron_jobs` (`name`, `controller`, `action`, `interval`, `period`, `is_active`) VALUES
('Import reservations from feeds for properties', 'pjCron', 'pjActionIndex', 30, 'minute', 1);

DELETE FROM `abcalendar_plugin_base_fields` WHERE `key`='plugin_base_role_arr_ARRAY_3';

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'script_name', 'backend', 'Label / Script Name', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Availability Booking Calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pass', 'backend', 'Password', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'email', 'backend', 'E-Mail', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnSave', 'backend', 'Save', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Save', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuUsers', 'backend', 'Menu Users', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Users', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuOptions', 'backend', 'Menu Options', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Options', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuLogout', 'backend', 'Menu Logout', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Logout', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnUpdate', 'backend', 'Update', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblChoose', 'backend', 'Choose', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnSearch', 'backend', 'Search', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Search', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'adminLogin', 'backend', 'Admin Login', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Admin Login', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnLogin', 'backend', 'Login', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Login', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuInstall', 'backend', 'Menu Install', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuDashboard', 'backend', 'Menu Dashboard', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dashboard', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuReservations', 'backend', 'Menu Reservations', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuPreview', 'backend', 'Menu Preview', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnAdd', 'backend', 'Button Add', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDelete', 'backend', 'Delete', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblName', 'backend', 'Name', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblRole', 'backend', 'Role', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Role', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblStatus', 'backend', 'Status', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblIsActive', 'backend', 'Is Active', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Is confirmed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblUpdateUser', 'backend', 'Update user', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update user', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblAddUser', 'backend', 'Add user', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add user', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblValue', 'backend', 'Value', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Value', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOption', 'backend', 'Option', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Option', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblAddReservation', 'backend', 'Add reservation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationName', 'backend', 'Reservation / Name', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationEmail', 'backend', 'Reservation / Email', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPhone', 'backend', 'Reservation / Phone', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Phone', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationNotes', 'backend', 'Reservation / Notes', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notes', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationSecurity', 'backend', 'Reservation / Security', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Security deposit', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationDeposit', 'backend', 'Reservation / Deposit', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation deposit', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationTax', 'backend', 'Reservation / Tax', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tax', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationFrom', 'backend', 'Reservation / From', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'From', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationTo', 'backend', 'Reservation / To', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPayment', 'backend', 'Reservation / Payment', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment method', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationAmount', 'backend', 'Reservation / Amount', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Amount', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationStatus', 'backend', 'Reservation / Status', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCCType', 'backend', 'Reservation / CC Type', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC Type', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCCNum', 'backend', 'Reservation / CC Number', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC Number', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCCCode', 'backend', 'Reservation / CC Code', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC Code', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCCExp', 'backend', 'Reservation / CC Expiration date', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC Expiration date', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblUpdateReservation', 'backend', 'Update reservation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuLocales', 'backend', 'Menu Languages', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblListingConfirmEmail', 'backend', 'Listing / Confirm email', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmation email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblListingPaymentEmail', 'backend', 'Listing / Payment email', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblListingConfirmTokens', 'backend', 'Listing / Confirm Tokens', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Supported tokens are:{Name} - The customer''s name{Email} - The customer''s e-mail{Phone} - The provided phone number{Adults} - Number of adults{Children} - Number of children{Notes} - Any additional notes{Address} - The provided address{City} - The provided city{Country} - The provided country{State} - The provided state{Zip} - The provided zip code{CCType} - The provided CC type{CCNum} - The provided CC number{CCExpMonth} - The provided CC exp.month{CCExpYear} - The provided CC exp.year{CCSec} - The provided CC sec. code{PaymentMethod} - The payment method{StartDate} - Reservation''s start date{EndDate} - Reservation''s end date{Deposit} - Deposit{Security} - Security amount{Tax} - Tax{Amount} - Total amount{CalendarID} - Calendar ID{ReservationID} - Reservation''s ID{ReservationUUID} - Reservation''s UUID{CancelURL} - Cancel URL', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblListingPaymentTokens', 'backend', 'Listing / Payment Tokens', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Supported tokens are:{Name} - The customer''s name{Email} - The customer''s e-mail{Phone} - The provided phone number{Adults} - Number of adults{Children} - Number of children{Notes} - Any additional notes{Address} - The provided address{City} - The provided city{Country} - The provided country{State} - The provided state{Zip} - The provided zip code{CCType} - The provided CC type{CCNum} - The provided CC number{CCExpMonth} - The provided CC exp.month{CCExpYear} - The provided CC exp.year{CCSec} - The provided CC sec. code{PaymentMethod} - The payment method{StartDate} - Reservation''s start date{EndDate} - Reservation''s end date{Deposit} - Deposit{Security} - Security amount{Tax} - Tax{Amount} - Total amount{CalendarID} - Calendar ID{ReservationID} - Reservation''s ID{ReservationUUID} - Reservation''s UUID', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashReservations', 'backend', 'Dashboard / Reservations', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashUsers', 'backend', 'Dashboard / Users', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Users', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashLatestReservations', 'backend', 'Dashboard / Latest Reservations', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Latest Reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashNights', 'backend', 'Dashboard / Nights', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Nights', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashTopUsers', 'backend', 'Dashboard / Top Users', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Top Users', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashLastLogin', 'backend', 'Dashboard / Last login', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'last login', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashMostPopular', 'backend', 'Dashboard / Most Popular', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Most Booked', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblListingNotFound', 'backend', 'Listing / No calendars found', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No calendars found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationNotFound', 'backend', 'Reservation / No reservations found', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No reservations found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnCancel', 'backend', 'Button Cancel', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblForgot', 'backend', 'Forgot password', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Forgot password', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'adminForgot', 'backend', 'Forgot password', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password reminder', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnSend', 'backend', 'Button Send', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'emailForgotSubject', 'backend', 'Email / Forgot Subject', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password reminder', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'emailForgotBody', 'backend', 'Email / Forgot Body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dear {Name},Your password: {Password}', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuProfile', 'backend', 'Menu Profile', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Profile', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuBackup', 'backend', 'Menu Backup', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnBackup', 'backend', 'Button Backup', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblBackupDatabase', 'backend', 'Backup / Database', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup database', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblBackupFiles', 'backend', 'Backup / Files', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup files', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridChooseAction', 'backend', 'Grid / Choose Action', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose Action', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridGotoPage', 'backend', 'Grid / Go to page', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Go to page:', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridTotalItems', 'backend', 'Grid / Total items', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total items:', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridItemsPerPage', 'backend', 'Grid / Items per page', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Items per page', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridPrevPage', 'backend', 'Grid / Prev page', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prev page', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridPrev', 'backend', 'Grid / Prev', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '&laquo; Prev', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridNextPage', 'backend', 'Grid / Next page', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Next page', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridNext', 'backend', 'Grid / Next', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Next &raquo;', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'multilangTooltip', 'backend', 'MultiLang / Tooltip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select a language by clicking on the corresponding flag and input the correct text.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblIp', 'backend', 'IP address', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'IP address', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblUserCreated', 'backend', 'User / Registration Date & Time', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Registration date/time', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCreated', 'backend', 'Reservation / Date&Time made', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation time', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'ResConfirmationTitle', 'backend', 'Reservation / Confirmation Title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'ResConfirmationText', 'backend', 'Reservation / Confirmation re-send', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'I would like to re-send a confirmation message too', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_allow_add_property', 'backend', 'Options / Allow users to add calendars', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Allow users to add calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_currency', 'backend', 'Options / Currency', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Currency', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_date_format', 'backend', 'Options / Date format', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date format', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_floor', 'backend', 'Options / Floor metrics', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Floor metrics', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_is_active_owner', 'backend', 'Options / User account confirmed by default', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User account confirmed by default', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_layout', 'backend', 'Options / Select layout', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select layout', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_limit_featured_results', 'backend', 'Options / Featured calendars', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Featured calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_paypal_address', 'backend', 'Options / Paypal address', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Paypal address', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_per_page', 'backend', 'Options / Items per page', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Items per page', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_timezone', 'backend', 'Options / Timezone', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Timezone', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_week_start', 'backend', 'Options / First day of the week', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set week starting day for your calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'u_statarr_ARRAY_T', 'arrays', 'u_statarr_ARRAY_T', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Active', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'u_statarr_ARRAY_F', 'arrays', 'u_statarr_ARRAY_F', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Inactive', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'filter_ARRAY_active', 'arrays', 'filter_ARRAY_active', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Active', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'filter_ARRAY_inactive', 'arrays', 'filter_ARRAY_inactive', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Inactive', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'filter_ARRAY_featured', 'arrays', 'filter_ARRAY_featured', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Featured', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'filter_ARRAY_non_featured', 'arrays', 'filter_ARRAY_non_featured', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Not featured', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'reservation_statuses_ARRAY_Confirmed', 'arrays', 'reservation_statuses_ARRAY_Confirmed', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'reservation_statuses_ARRAY_Pending', 'arrays', 'reservation_statuses_ARRAY_Pending', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'reservation_statuses_ARRAY_Cancelled', 'arrays', 'reservation_statuses_ARRAY_Cancelled', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancelled', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'payment_methods_ARRAY_paypal', 'arrays', 'payment_methods_ARRAY_paypal', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'PayPal', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'payment_methods_ARRAY_creditcard', 'arrays', 'payment_methods_ARRAY_creditcard', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Credit Card', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'cc_types_ARRAY_Visa', 'arrays', 'cc_types_ARRAY_Visa', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Visa', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'cc_types_ARRAY_MasterCard', 'arrays', 'cc_types_ARRAY_MasterCard', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'MasterCard', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'cc_types_ARRAY_Maestro', 'arrays', 'cc_types_ARRAY_Maestro', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Maestro', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'cc_types_ARRAY_AmericanExpress', 'arrays', 'cc_types_ARRAY_AmericanExpress', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'AmericanExpress', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-43200', 'arrays', 'timezones_ARRAY_-43200', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-12:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-39600', 'arrays', 'timezones_ARRAY_-39600', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-11:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-36000', 'arrays', 'timezones_ARRAY_-36000', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-10:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-32400', 'arrays', 'timezones_ARRAY_-32400', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-09:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-28800', 'arrays', 'timezones_ARRAY_-28800', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-08:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-25200', 'arrays', 'timezones_ARRAY_-25200', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-07:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-21600', 'arrays', 'timezones_ARRAY_-21600', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-06:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-18000', 'arrays', 'timezones_ARRAY_-18000', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-05:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-14400', 'arrays', 'timezones_ARRAY_-14400', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-04:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-10800', 'arrays', 'timezones_ARRAY_-10800', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-03:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-7200', 'arrays', 'timezones_ARRAY_-7200', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-02:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_-3600', 'arrays', 'timezones_ARRAY_-3600', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT-01:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_0', 'arrays', 'timezones_ARRAY_0', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_3600', 'arrays', 'timezones_ARRAY_3600', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+01:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_7200', 'arrays', 'timezones_ARRAY_7200', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+02:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_10800', 'arrays', 'timezones_ARRAY_10800', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+03:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_14400', 'arrays', 'timezones_ARRAY_14400', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+04:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_18000', 'arrays', 'timezones_ARRAY_18000', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+05:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_21600', 'arrays', 'timezones_ARRAY_21600', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+06:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_25200', 'arrays', 'timezones_ARRAY_25200', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+07:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_28800', 'arrays', 'timezones_ARRAY_28800', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+08:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_32400', 'arrays', 'timezones_ARRAY_32400', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+09:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_36000', 'arrays', 'timezones_ARRAY_36000', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+10:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_39600', 'arrays', 'timezones_ARRAY_39600', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+11:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_43200', 'arrays', 'timezones_ARRAY_43200', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+12:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'timezones_ARRAY_46800', 'arrays', 'timezones_ARRAY_46800', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'GMT+13:00', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AE01', 'arrays', 'error_titles_ARRAY_AE01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AE03', 'arrays', 'error_titles_ARRAY_AE03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra added!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AE04', 'arrays', 'error_titles_ARRAY_AE04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra failed to add.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AE08', 'arrays', 'error_titles_ARRAY_AE08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra not found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AT01', 'arrays', 'error_titles_ARRAY_AT01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Type updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AT03', 'arrays', 'error_titles_ARRAY_AT03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Type added!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AT04', 'arrays', 'error_titles_ARRAY_AT04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Type failed to add.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AT08', 'arrays', 'error_titles_ARRAY_AT08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Type not found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR01', 'arrays', 'error_titles_ARRAY_AR01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR03', 'arrays', 'error_titles_ARRAY_AR03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation added!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR04', 'arrays', 'error_titles_ARRAY_AR04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation failed to add.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR08', 'arrays', 'error_titles_ARRAY_AR08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation not found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR09', 'arrays', 'error_titles_ARRAY_AR09', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Associate calendar not found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR10', 'arrays', 'error_titles_ARRAY_AR10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Associate calendar forbidden.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU01', 'arrays', 'error_titles_ARRAY_AU01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU03', 'arrays', 'error_titles_ARRAY_AU03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User added!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU04', 'arrays', 'error_titles_ARRAY_AU04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User failed to add.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU08', 'arrays', 'error_titles_ARRAY_AU08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User not found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO01', 'arrays', 'error_titles_ARRAY_AO01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'General options updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO02', 'arrays', 'error_titles_ARRAY_AO02', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Appearance options updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO03', 'arrays', 'error_titles_ARRAY_AO03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking options updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL01', 'arrays', 'error_titles_ARRAY_AL01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar updates!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL08', 'arrays', 'error_titles_ARRAY_AL08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Error occured', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL09', 'arrays', 'error_titles_ARRAY_AL09', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Error occured', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AL10', 'arrays', 'error_titles_ARRAY_AL10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'System notice', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ALC01', 'arrays', 'error_titles_ARRAY_ALC01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Titles updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AB01', 'arrays', 'error_titles_ARRAY_AB01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AB02', 'arrays', 'error_titles_ARRAY_AB02', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup complete!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AB03', 'arrays', 'error_titles_ARRAY_AB03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup failed!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AB04', 'arrays', 'error_titles_ARRAY_AB04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup failed!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AA10', 'arrays', 'error_titles_ARRAY_AA10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Account not found!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AA11', 'arrays', 'error_titles_ARRAY_AA11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password send!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AA12', 'arrays', 'error_titles_ARRAY_AA12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password not send!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AA13', 'arrays', 'error_titles_ARRAY_AA13', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Profile updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AE01', 'arrays', 'error_bodies_ARRAY_AE01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this extra have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AE03', 'arrays', 'error_bodies_ARRAY_AE03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this extra have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AE04', 'arrays', 'error_bodies_ARRAY_AE04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry, but the extra has not been added.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AE08', 'arrays', 'error_bodies_ARRAY_AE08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Extra your looking for is missing.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AT01', 'arrays', 'error_bodies_ARRAY_AT01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this type have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AT03', 'arrays', 'error_bodies_ARRAY_AT03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this type have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AT04', 'arrays', 'error_bodies_ARRAY_AT04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry, but the type has not been added.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AT08', 'arrays', 'error_bodies_ARRAY_AT08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Type your looking for is missing.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR01', 'arrays', 'error_bodies_ARRAY_AR01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this reservation have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR03', 'arrays', 'error_bodies_ARRAY_AR03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this reservation have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR04', 'arrays', 'error_bodies_ARRAY_AR04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry, but the reservation has not been added.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR08', 'arrays', 'error_bodies_ARRAY_AR08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation your looking for is missing.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR09', 'arrays', 'error_bodies_ARRAY_AR09', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The calendar for this reservation not found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR10', 'arrays', 'error_bodies_ARRAY_AR10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The calendar for this reservation belongs to somebody else but not you.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU01', 'arrays', 'error_bodies_ARRAY_AU01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this user have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU03', 'arrays', 'error_bodies_ARRAY_AU03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this user have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU04', 'arrays', 'error_bodies_ARRAY_AU04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry, but the user has not been added.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU08', 'arrays', 'error_bodies_ARRAY_AU08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User your looking for is missing.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO01', 'arrays', 'error_bodies_ARRAY_AO01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to general options have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO02', 'arrays', 'error_bodies_ARRAY_AO02', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to appearance options have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO03', 'arrays', 'error_bodies_ARRAY_AO03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to booking options have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL01', 'arrays', 'error_bodies_ARRAY_AL01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this calendar have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL08', 'arrays', 'error_bodies_ARRAY_AL08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar not found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL09', 'arrays', 'error_bodies_ARRAY_AL09', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No permisions to edit the calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AL10', 'arrays', 'error_bodies_ARRAY_AL10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your plan has been extended.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ALC01', 'arrays', 'error_bodies_ARRAY_ALC01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to titles have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AB01', 'arrays', 'error_bodies_ARRAY_AB01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We recommend you to regularly back up your database and files to prevent any loss of information.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AB02', 'arrays', 'error_bodies_ARRAY_AB02', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All backup files have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AB03', 'arrays', 'error_bodies_ARRAY_AB03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No option was selected.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AB04', 'arrays', 'error_bodies_ARRAY_AB04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup not performed.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AA10', 'arrays', 'error_bodies_ARRAY_AA10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Given email address is not associated with any account.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AA11', 'arrays', 'error_bodies_ARRAY_AA11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'For further instructions please check your mailbox.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AA12', 'arrays', 'error_bodies_ARRAY_AA12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We''re sorry, please try again later.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AA13', 'arrays', 'error_bodies_ARRAY_AA13', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to your profile have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_1', 'arrays', 'front_booking_status_ARRAY_1', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your reservation has been received.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_2', 'arrays', 'front_booking_status_ARRAY_2', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your request has not been sent successfully. Please try again.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_3', 'arrays', 'front_booking_status_ARRAY_3', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Selected period is not available.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_4', 'arrays', 'front_booking_status_ARRAY_4', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Verification code is invalid. Please try again.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_5', 'arrays', 'front_booking_status_ARRAY_5', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invalid dates. Please try again.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_6', 'arrays', 'front_booking_status_ARRAY_6', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invalid date range. Please check your dates.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_8', 'arrays', 'front_booking_status_ARRAY_8', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date ranges in past is not allowed.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_9', 'arrays', 'front_booking_status_ARRAY_9', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Min booking length is %u %s', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_10', 'arrays', 'front_booking_status_ARRAY_10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Max booking length is %u %s', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_booking_status_ARRAY_11', 'arrays', 'front_booking_status_ARRAY_11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please wait while redirect to secure payment processor webpage complete...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_1', 'arrays', 'months_ARRAY_jan', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'January', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_2', 'arrays', 'months_ARRAY_feb', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'February', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_3', 'arrays', 'months_ARRAY_mar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'March', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_4', 'arrays', 'months_ARRAY_apr', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'April', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_5', 'arrays', 'months_ARRAY_may', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'May', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_6', 'arrays', 'months_ARRAY_jun', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'June', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_7', 'arrays', 'months_ARRAY_jul', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'July', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_8', 'arrays', 'months_ARRAY_aug', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'August', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_9', 'arrays', 'months_ARRAY_sep', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'September', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_10', 'arrays', 'months_ARRAY_oct', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'October', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_11', 'arrays', 'months_ARRAY_nov', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'November', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'months_ARRAY_12', 'arrays', 'months_ARRAY_dec', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'December', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'days_ARRAY_0', 'arrays', 'days_ARRAY_0', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sunday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'days_ARRAY_1', 'arrays', 'days_ARRAY_1', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Monday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'days_ARRAY_2', 'arrays', 'days_ARRAY_2', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tuesday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'days_ARRAY_3', 'arrays', 'days_ARRAY_3', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Wednesday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'days_ARRAY_4', 'arrays', 'days_ARRAY_4', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Thursday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'days_ARRAY_5', 'arrays', 'days_ARRAY_5', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Friday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'days_ARRAY_6', 'arrays', 'days_ARRAY_6', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Saturday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_0', 'arrays', 'day_names_ARRAY_sun', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'sun', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_1', 'arrays', 'day_names_ARRAY_mon', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'mon', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_2', 'arrays', 'day_names_ARRAY_tue', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'tue', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_3', 'arrays', 'day_names_ARRAY_wed', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'wed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_4', 'arrays', 'day_names_ARRAY_thu', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'thu', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_5', 'arrays', 'day_names_ARRAY_fri', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'fri', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'day_names_ARRAY_6', 'arrays', 'day_names_ARRAY_sat', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'sat', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_1', 'arrays', 'status_ARRAY_1', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You are not loged in.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_2', 'arrays', 'status_ARRAY_2', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Access denied. You have not requisite rights to.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_3', 'arrays', 'status_ARRAY_3', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Empty resultset.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_7', 'arrays', 'status_ARRAY_7', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The operation is not allowed in demo mode.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_123', 'arrays', 'status_ARRAY_123', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your hosting account does not allow uploading such a large image.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_999', 'arrays', 'status_ARRAY_999', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No permisions to edit the calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_998', 'arrays', 'status_ARRAY_998', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No permisions to edit the reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_997', 'arrays', 'status_ARRAY_997', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No reservation found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_996', 'arrays', 'status_ARRAY_996', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No calendar for the reservation found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_9999', 'arrays', 'status_ARRAY_9999', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your registration was successfull.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_9998', 'arrays', 'status_ARRAY_9998', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your registration was successfull. Your account needs to be approved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'status_ARRAY_9997', 'arrays', 'status_ARRAY_9997', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'E-Mail address already exist', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'login_err_ARRAY_1', 'arrays', 'login_err_ARRAY_1', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Wrong username or password', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'login_err_ARRAY_2', 'arrays', 'login_err_ARRAY_2', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Access denied', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'login_err_ARRAY_3', 'arrays', 'login_err_ARRAY_3', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Account is disabled', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lnkBack', 'backend', 'Link Back', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Back', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'payment_methods_ARRAY_bank', 'arrays', 'payment_methods_ARRAY_bank', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Bank account', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashReservation', 'backend', 'Dashboard / Reservation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashUser', 'backend', 'Dashboard / User', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'user', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashNight', 'backend', 'Dashboard / Night', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Night', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblUpdateCalendar', 'backend', 'Calendars / Update calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblAddCalendar', 'backend', 'Calendars / Add calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuCalendars', 'backend', 'Menu Calendars', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblUser', 'backend', 'User', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'User', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuGeneral', 'backend', 'Menu General', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'General', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuAppearance', 'backend', 'Menu Appearance', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Appearance', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuBookings', 'backend', 'Menu Bookings', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Bookings', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuBookingForm', 'backend', 'Menu Booking Form', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Form', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuTerms', 'backend', 'Menu Terms', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuConfirmation', 'backend', 'Menu Confirmation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_accept_bookings', 'backend', 'Options / Accept Bookings', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Accept reservations or show availability', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_accept_bookings_desc', 'backend', 'Options / Accept Bookings Desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose if you want to accept reservations or to show availability only ', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_allow_authorize', 'backend', 'Options / Allow Authorize.net', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Allow payments with Authorize.net', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_allow_bank', 'backend', 'Options / Allow Bank', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Provide Bank account details for wire transfers', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_allow_creditcard', 'backend', 'Options / Allow Credit Card', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Collect Credit Card details for offline processing', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_allow_paypal', 'backend', 'Options / Allow Paypal', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Allow payments with PayPal', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_authorize_key', 'backend', 'Options / Authorize.net transaction key', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Authorize.net transaction key', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_authorize_mid', 'backend', 'Options / Authorize.net merchant ID', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Authorize.net merchant ID', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_available', 'backend', 'Options / Available dates', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Available dates', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_booked', 'backend', 'Options / Booked dates', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booked dates', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_empty', 'backend', 'Options / Empty slots', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Empty slots', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_month', 'backend', 'Options / Month Background', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Month Background', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_past', 'backend', 'Options / Past dates color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Past dates color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_pending', 'backend', 'Options / Pending reservation dates', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending reservation dates', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_select', 'backend', 'Options / Current reservation selected dates', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Current reservation selected dates', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_weekday', 'backend', 'Options / Week Days background', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Week Days background', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bank_account', 'backend', 'Options / Bank account', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Bank account', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_address', 'backend', 'Options / Address', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_adults', 'backend', 'Options / Adults', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Adults', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_captcha', 'backend', 'Options / Captcha', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_children', 'backend', 'Options / Children', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_city', 'backend', 'Options / City', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'City', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_email', 'backend', 'Options / Email', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_name', 'backend', 'Options / Name', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_notes', 'backend', 'Options / Notes', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notes', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_phone', 'backend', 'Options / Phone', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Phone', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_state', 'backend', 'Options / State', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'State', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_terms', 'backend', 'Options / Terms', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_zip', 'backend', 'Options / Zip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Zip', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_border_inner', 'backend', 'Options / Inner border color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Inner border color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_border_inner_size', 'backend', 'Options / Inner border size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Inner border size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_border_outer', 'backend', 'Options / Outer border color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Outer border color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_border_outer_size', 'backend', 'Options / Outer border size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Outer border size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_color_available', 'backend', 'Options / Available dates color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Available dates color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_color_booked', 'backend', 'Options / Booked dates color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booked dates color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_color_legend', 'backend', 'Options / Legend color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Legend color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_color_month', 'backend', 'Options / Month color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Month color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_color_past', 'backend', 'Options / Past dates color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Past dates color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_color_pending', 'backend', 'Options / Pending Days color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending Days color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_color_weekday', 'backend', 'Options / Week Days color', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Week Days color', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_deposit', 'backend', 'Options / Deposit', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Deposit amount to be collected', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_deposit_desc', 'backend', 'Options / Deposit desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set deposit amount to be collected for each reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'deposit_types_ARRAY_amount', 'arrays', 'deposit_types_ARRAY_amount', 'script', '2020-11-06 05:02:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Amount', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'deposit_types_ARRAY_percent', 'arrays', 'deposit_types_ARRAY_percent', 'script', '2020-11-06 05:02:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Percent', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_disable_payments', 'backend', 'Options / Disable payments', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Disable payments', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_disable_payments_desc', 'backend', 'Options / Disable payments desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Check if you want to disable payments and only collect reservation details', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_family', 'backend', 'Options / Font family', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Font family', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_family_legend', 'backend', 'Options / Font family Legend', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Font family Legend', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_size_available', 'backend', 'Options / Available dates font size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Available dates font size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_size_booked', 'backend', 'Options / Booked dates font size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booked dates font size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_size_legend', 'backend', 'Options / Legend font size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Legend font size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_size_month', 'backend', 'Options / Month font size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Month font size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_size_past', 'backend', 'Options / Past dates font size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Past dates font size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_size_pending', 'backend', 'Options / Pending days font size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending days font size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_size_weekday', 'backend', 'Options / Weekdays font size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Weekdays font size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_style_available', 'backend', 'Options / Available dates font style', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Available dates font style', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_style_booked', 'backend', 'Options / Booked dates font style', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booked dates font style', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_style_legend', 'backend', 'Options / Legend font style', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Legend font style', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_style_month', 'backend', 'Options / Month font style', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Month font style', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_style_past', 'backend', 'Options / Past dates font style', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Past dates font style', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_style_pending', 'backend', 'Options / Pending days font style', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending days font style', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_font_style_weekday', 'backend', 'Options / Weekdays font style', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Weekdays font style', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_month_year_format', 'backend', 'Options / Month / Year format', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Month / Year format', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_price_based_on', 'backend', 'Options / Reservations and price basedon days or nights', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations and prices will be based on', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_require_all_within', 'backend', 'Options / Require 100% if the reservations is within X days', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '100% payment if reservation is made less than', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_require_all_within_desc', 'backend', 'Options / days in advance', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'days in advance', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_security', 'backend', 'Options / Security deposit payment', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set a security deposit payment to be collected with each reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_show_legend', 'backend', 'Options / Show color legend', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Show color legend below the front end', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_show_prices', 'backend', 'Options / show prices', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Show prices on front end calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_show_week_numbers', 'backend', 'Options / Show week numbers', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Show weekly number on the front end', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_show_legend_desc', 'backend', 'Options / Show color legend desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Check if you want to show color legend below the front end calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_show_prices_desc', 'backend', 'Options / show prices', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Check if you want to show prices on the front end calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_show_week_numbers_desc', 'backend', 'Options / Show week numbers', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Check if you want to show weekly number on the front end calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_status_if_not_paid', 'backend', 'Options / Default status for booked dates if not paid', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set the status for new reservations when reservation form is saved', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_status_if_paid', 'backend', 'Options / Default status for booked dates if paid', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status for paid reservation form', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_status_if_paid_desc', 'backend', 'Options / Default status for booked dates if paid', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set the status for new reservations if payment has been made', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_tax', 'backend', 'Options / Tax payment', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tax collected', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_tax_desc', 'backend', 'Options / Tax payment desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tax amount to be collected for each reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_thankyou_page', 'backend', 'Options / "Thank you" page location', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'URL redirects after payment', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_thankyou_page_desc', 'backend', 'Options / "Thank you" page location desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'URL of the web page where your clients will be redirected to after their PayPal or Authorize.Net payment', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO04', 'arrays', 'error_titles_ARRAY_AO04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking form options updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO05', 'arrays', 'error_titles_ARRAY_AO05', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmation options updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO06', 'arrays', 'error_titles_ARRAY_AO06', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms options updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO04', 'arrays', 'error_bodies_ARRAY_AO04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to booking form options have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO05', 'arrays', 'error_bodies_ARRAY_AO05', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to confirmation options have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO06', 'arrays', 'error_bodies_ARRAY_AO06', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to terms options have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'legend_available', 'frontend', 'Legend / Available', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Available', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'legend_pending', 'frontend', 'Legend / Pending', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'legend_confirmed', 'backend', 'Label / Confirmed', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Confirmed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'legend_booked', 'frontend', 'Legend / Booked', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booked', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'legend_past', 'frontend', 'Legend / Past', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Past', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_name', 'frontend', 'Booking form / Name', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_email', 'frontend', 'Booking form / Email', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_phone', 'frontend', 'Booking form / Phone', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Phone', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_adults', 'frontend', 'Booking form / Adults', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Adults', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_children', 'frontend', 'Booking form / Children', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_address', 'frontend', 'Booking form / Address', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_state', 'frontend', 'Booking form / State', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'State', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_city', 'frontend', 'Booking form / City', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'City', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_zip', 'frontend', 'Booking form / Zip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Zip', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_notes', 'frontend', 'Booking form / Notes', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notes', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_captcha', 'frontend', 'Booking form / Captcha', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_terms', 'frontend', 'Booking form / Terms', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'I agree to %sterms of booking%s', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_booking_behavior', 'backend', 'Options / Booking behavior', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_booking_behavior_desc', 'backend', 'Options / Booking behavior desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Accept single or multi date reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'o_booking_behaviors_ARRAY_1', 'arrays', 'o_booking_behaviors_ARRAY_1', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Start & End date required', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'o_booking_behaviors_ARRAY_2', 'arrays', 'o_booking_behaviors_ARRAY_2', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Single date', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_start_date', 'frontend', 'Booking form / Arrival', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Arrival', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_end_date', 'frontend', 'Booking form / Departure', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Departure', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_payment', 'frontend', 'Booking form / Payment method', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment method', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_cc_num', 'frontend', 'Booking form / CC Number', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC Number', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_cc_exp', 'frontend', 'Booking form / CC Exp.date', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC Exp.date', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_cc_sec', 'frontend', 'Booking form / CC Sec.code', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC Sec.code', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_cc_type', 'frontend', 'Booking form / CC Type', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CC Type', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bookings_per_day', 'backend', 'Bookings per day', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Number of reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bookings_per_day_desc', 'backend', 'Bookings per day desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set number of reservations to be accepted per day/night', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnCalculate', 'backend', 'Button Calculate', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calculate', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationAddress', 'backend', 'Reservation / Address', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Address', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCity', 'backend', 'Reservation / City', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'City', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationState', 'backend', 'Reservation / State', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'State', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationZip', 'backend', 'Reservation / Zip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Zip', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationClientInfo', 'backend', 'Reservation / Client details', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client details', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationUuid', 'backend', 'Reservation / Unique ID', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Unique ID', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationInfo', 'backend', 'Reservation / Details', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation details', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationAdults', 'backend', 'Reservation / Adults', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Adults', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationChildren', 'backend', 'Reservation / Children', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblViewCalendar', 'backend', 'Calendars / View calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'View calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_amount', 'frontend', 'Booking form / Amount', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Amount', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_deposit', 'frontend', 'Booking form / Deposit', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Deposit payment', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridDeleteConfirmation', 'backend', 'Grid / Delete confirmation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridConfirmationTitle', 'backend', 'Grid / Confirmation Title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to delete this entry?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridActionTitle', 'backend', 'Grid / Action Title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Action confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridBtnOk', 'backend', 'Grid / Button OK', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'OK', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridBtnCancel', 'backend', 'Grid / Button Cancel', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridBtnDelete', 'backend', 'Grid / Button Delete', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_host', 'backend', 'opt_o_smtp_host', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Host', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_port', 'backend', 'opt_o_smtp_port', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Port', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_user', 'backend', 'opt_o_smtp_user', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Username', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_pass', 'backend', 'opt_o_smtp_pass', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Password', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_send_email', 'backend', 'opt_o_send_email', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select email sending method', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_payment_paypal_title', 'frontend', 'front_payment_paypal_title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'AB Calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_payment_authorize_title', 'frontend', 'front_payment_authorize_title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'AB Calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_authorize_tz', 'backend', 'Options / Authorize.net Time zone', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Authorize.net time zone', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_bank_account', 'frontend', 'Booking form / Bank account', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Bank account', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_email_new_reservation', 'backend', 'Options / New reservation received', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New reservation received', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_email_reservation_cancelled', 'backend', 'Options / Reservation cancelled', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation cancelled', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_email_password_reminder', 'backend', 'Notifications / Password reminder', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Password reminder', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'tabEmails', 'backend', 'Tab / Emails', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Emails', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'tabSms', 'backend', 'Tab / Sms', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sms', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuPayments', 'backend', 'Menu Payments', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payments', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO07', 'arrays', 'error_titles_ARRAY_AO07', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment options updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO07', 'arrays', 'error_bodies_ARRAY_AO07', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to payment options have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuNotifications', 'backend', 'Menu Notifications', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoNotificationsEmailTitle', 'backend', 'Infobox / Email notifications title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoNotificationsSmsTitle', 'backend', 'Infobox / Sms notifications title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sms notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoNotificationsEmailBody', 'backend', 'Infobox / Email notifications body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Different email notifications will be sent when various events happen. You can edit each of the Users and set which emails to receive.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoNotificationsSmsBody', 'backend', 'Infobox / Sms notifications body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Different SMS notifications will be sent when various events happen. You can edit each of the Users and set which SMS messages to receive. Under SMS tab you need to input your API key for our SMS gateway.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_body_new_reservation', 'backend', 'Notifications / Body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Body', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_subject', 'backend', 'Notifications / Subject', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Subject', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notify_email_ARRAY_3', 'arrays', 'notify_email_ARRAY_3', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New reservation - all calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notify_email_ARRAY_4', 'arrays', 'notify_email_ARRAY_4', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New reservation - my calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notify_email_ARRAY_5', 'arrays', 'notify_email_ARRAY_5', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation cancelled - all calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notify_email_ARRAY_6', 'arrays', 'notify_email_ARRAY_6', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation cancelled - my calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblNotifyEmail', 'backend', 'User / Email notifications', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblNotifySms', 'backend', 'User / Sms notifications', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sms notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblUserEmailTip', 'backend', 'User / Email notifications tip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select the email notifications to be sent to this user.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblUserSmsTip', 'backend', 'User / Sms notifications tip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select the SMS notifications to be sent to this user.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblMaxValue', 'backend', 'Options / Max value', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Max value', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuSettings', 'backend', 'Menu Settings', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Settings', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCalendar', 'backend', 'Reservation / Calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationFilterDates', 'backend', 'Reservation / Reserved dates', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reserved dates', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_body_forgot_password', 'backend', 'Notifications / Body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Body<br /><br />Available tokens:<br />{Name}<br />{Password}', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionsTermsURL', 'backend', 'Options / Booking terms URL', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking terms URL', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionsTermsContent', 'backend', 'Options / Booking terms content', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking terms content', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuAvailability', 'backend', 'Menu Availability', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Availability', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashCalendars', 'backend', 'Dashboard / Calendars', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDashCalendar', 'backend', 'Dashboard / Calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridEmptyResult', 'backend', 'Grid / Empty resultset', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No records found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblUserRoleTip', 'backend', 'User / Role tip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Select the user''s role.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU20', 'arrays', 'error_titles_ARRAY_AU20', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Users', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU20', 'arrays', 'error_bodies_ARRAY_AU20', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can create different users - administrators (access to everything), editors (access to calendars and reservations), owners (access to own calendars only)', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO24', 'arrays', 'error_titles_ARRAY_AO24', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking form', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO25', 'arrays', 'error_titles_ARRAY_AO25', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO26', 'arrays', 'error_titles_ARRAY_AO26', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Terms and Conditions', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO24', 'arrays', 'error_bodies_ARRAY_AO24', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose the fields that should be available on the booking form.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO25', 'arrays', 'error_bodies_ARRAY_AO25', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email notifications will be sent to people who make a reservation after reservation form is completed or/and payment is made. If you leave subject field blank no email will be sent.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO26', 'arrays', 'error_bodies_ARRAY_AO26', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Enter booking terms and conditions. You can also include a link to external web page where your terms and conditions page is.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblPhone', 'backend', 'Phone', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Phone', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_bf_country', 'backend', 'Options / Country', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_country', 'frontend', 'Booking form / Country', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCountry', 'backend', 'Reservation / Country', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_tax', 'frontend', 'Booking form / Tax', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tax', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_security', 'frontend', 'Booking form / Security deposit', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Refundable security deposit', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_day', 'frontend', 'Booking form / day', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'day', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_days', 'frontend', 'Booking form / days', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'days', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_night', 'frontend', 'Booking form / night', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'night', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_nights', 'frontend', 'Booking form / nights', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'nights', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionCopy', 'backend', 'Option', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy options from', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionCopyTitle', 'backend', 'Option / Copy dialog title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy options confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionCopyDesc', 'backend', 'Option / Copy dialog description', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to copy selected options?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblPriceFrom', 'frontend', 'Price from', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Price from', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblExportSelected', 'backend', 'Export selected', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export selected', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblRevertStatus', 'backend', 'Revert status', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Revert status', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDeleteSelected', 'backend', 'Delete selected', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete selected', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDeleteConfirmation', 'backend', 'Delete confirmation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to delete selected records?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblEmailValidationUnique', 'backend', 'Email address validation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email address is already in use', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblAll', 'backend', 'All', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblViewReservations', 'backend', 'Reservation / View reservations', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'View reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblMore', 'backend', 'More', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'More', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblID', 'backend', 'ID', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'ID', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblCalendarName', 'backend', 'Calendars / Name', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar Name', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationDateRangeValidation', 'backend', 'Reservation / Date range validation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date range is not available', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnContinue', 'backend', 'Button Continue', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Continue', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnCopy', 'backend', 'Button Copy', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallConfigMonths', 'backend', 'Install / Months', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Months', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallConfigLocale', 'backend', 'Install / Language', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Language', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallConfig', 'backend', 'Install / Config', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install config', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPrev30', 'backend', 'Reservation / Previous 30 days', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Previous 30 days', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationNext30', 'backend', 'Reservation / Next 30 days', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Next 30 days', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuLimits', 'backend', 'Menu Limits', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Limits', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO27', 'arrays', 'error_titles_ARRAY_AO27', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking limits', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO27', 'arrays', 'error_bodies_ARRAY_AO27', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Define different periods throughout the year and set different booking limits. For example you may want to allow minimum 3 nights bookings during the high season.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'limit_from', 'backend', 'Limits / From', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'From', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'limit_to', 'backend', 'Limits / To', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'limit_min', 'backend', 'Limits / Min length', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Min length', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'limit_max', 'backend', 'Limits / Max length', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Max length', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'limit_add', 'backend', 'Limits / Add a limit', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add a limit', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'limit_nights', 'backend', 'Limit / Nights', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Nights', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO10', 'arrays', 'error_titles_ARRAY_AO10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Limits updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO10', 'arrays', 'error_bodies_ARRAY_AO10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to limits have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionCopyTip', 'backend', 'Option / Copy tooltip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can copy all the options below from any of your other calendars.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'limit_days', 'backend', 'Limit / Days', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Days', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCreateInvoice', 'backend', 'Create Invoice', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Create Invoice', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationFindInvoices', 'backend', 'Find Invoices', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Find Invoices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationInvoiceDetails', 'backend', 'Invoice Details', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invoice Details', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_price_plugin', 'backend', 'Options / Set prices based on Day/Night OR Periods', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set prices based on Day/Night or Periods', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallNoteTitle', 'backend', 'Install / Note title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install code', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallNoteDesc', 'backend', 'Install / Note description', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The code below will place an availability view for all your calendars like you have it here under the "Availability" tab.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_booking', 'frontend', 'Booking form / Booking', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_continue', 'frontend', 'Booking form / Continue', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Continue', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_cancel', 'frontend', 'Booking form / Cancel', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_nav', 'backend', 'Options / Month Nav Background', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Month Nav Background', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR20', 'arrays', 'error_titles_ARRAY_AR20', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Availability not found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR20', 'arrays', 'error_bodies_ARRAY_AR20', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sorry, but there are not availability calendars to show.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR19', 'arrays', 'error_bodies_ARRAY_AR19', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can not add new reservation, because there are not calendars assigned to you.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR19', 'arrays', 'error_titles_ARRAY_AR19', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Access denied', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR02', 'arrays', 'error_titles_ARRAY_AR02', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation failed to update.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR02', 'arrays', 'error_bodies_ARRAY_AR02', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry, but the reservation has not been updated.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACR01', 'arrays', 'error_titles_ARRAY_ACR01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACR03', 'arrays', 'error_titles_ARRAY_ACR03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar added!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACR04', 'arrays', 'error_titles_ARRAY_ACR04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar failed to add.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACR08', 'arrays', 'error_titles_ARRAY_ACR08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar not found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACR01', 'arrays', 'error_bodies_ARRAY_ACR01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this calendar have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACR03', 'arrays', 'error_bodies_ARRAY_ACR03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this calendar have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACR04', 'arrays', 'error_bodies_ARRAY_ACR04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We are sorry, but the calendar has not been added.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACR08', 'arrays', 'error_bodies_ARRAY_ACR08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar your looking for is missing.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPlaceholderSearch', 'backend', 'Reservations / Enter name or email', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Enter name or email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_fully_booked', 'arrays', 'Calendar / Fully booked', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can not select fully booked days', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_period_na', 'arrays', 'Calendar / Period not available', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Period not allowed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_range_na', 'arrays', 'Calendar / Selected date range not allowed', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Selected date range not allowed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_daily_na', 'arrays', 'Calendar / Daily bookings are disabled', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Daily bookings are disabled', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_range_out', 'arrays', 'Calendar / Out of range', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Out of range', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_single_na', 'arrays', 'Calendar / Single date booking is disabled', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Single date booking is disabled', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_should_click', 'arrays', 'Calendar / You should click on', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You should click on:', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_valid_singular', 'arrays', 'Calendar / Valid period is', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Valid period is:', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_valid_plural', 'arrays', 'Calendar / Valid periods are', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Valid periods are:', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_limits', 'arrays', 'Calendar / Limits not match', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'For the selected dates you can book between {MIN} and {MAX} nights. You tried to book {YOUR} nights.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_min_limits', 'arrays', 'Calendar / Limits not match', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'For the selected dates you can book minimum {MIN} night(s). You tried to book {YOUR} night(s).', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_limits_days', 'arrays', 'Calendar / Limits not match', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'For the selected dates you can book between {MIN} and {MAX} day(s). You tried to book {YOUR} day(s).', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_min_limits_days', 'arrays', 'Calendar / Limits not match', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'For the selected dates you can book minimum {MIN} day(s). You tried to book {YOUR} day(s).', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_till', 'arrays', 'Calendar / Till', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'till', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_or', 'arrays', 'Calendar / Or', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'or', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_cancel_url', 'backend', 'Options / Cancel booking page', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'URL after cancel a reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_cancel_url_desc', 'backend', 'Options / Cancel booking page desc', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'URL of the web page where your clients will be redirected to after they cancel a reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR15', 'arrays', 'error_bodies_ARRAY_AR15', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'It seems there are missing, empty or not valid parameters.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR15', 'arrays', 'error_titles_ARRAY_AR15', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Missing parameters', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR16', 'arrays', 'error_titles_ARRAY_AR16', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation not found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR16', 'arrays', 'error_bodies_ARRAY_AR16', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sorry, but the reservation you''re looking for was not found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR14', 'arrays', 'error_titles_ARRAY_AR14', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR14', 'arrays', 'error_bodies_ARRAY_AR14', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Here you can cancel your reservation.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR13', 'arrays', 'error_titles_ARRAY_AR13', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation cancelled', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR13', 'arrays', 'error_bodies_ARRAY_AR13', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation has been cancelled successfully.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR17', 'arrays', 'error_bodies_ARRAY_AR17', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You''ve already canceled the booking. Here is your details.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR17', 'arrays', 'error_titles_ARRAY_AR17', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation cancelled', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_loading', 'arrays', 'Calendar / Loading', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please wait while content is loading...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO11', 'arrays', 'error_titles_ARRAY_AO11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Overlapping dates!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO11', 'arrays', 'error_bodies_ARRAY_AO11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Some of submitted periods have overlapping dates.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationInvoice', 'backend', 'Reservations / Invoice', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invoice', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO08', 'arrays', 'error_bodies_ARRAY_AO08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to notification options have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO08', 'arrays', 'error_titles_ARRAY_AO08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notification options updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'reservation_balance_payment', 'backend', 'Reservations / Balance payment', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Balance payment', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'reservation_calc_title', 'backend', 'Reservations / Calculate dialog - Title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calculate confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'reservation_calc_body', 'backend', 'Reservations / Calculate dialog - Content', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to recalculate the price? Current price will be lost!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR11', 'arrays', 'error_titles_ARRAY_AR11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation not updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR11', 'arrays', 'error_bodies_ARRAY_AR11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The period is already booked and reservation cannot be proceeded. Please change the date range.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'reservation_calc_tip', 'backend', 'Reservations / Calculate tooltip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can change dates and number of adults/children and then click the ''Calculate'' button. The price will be calculated based on the new selection.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_price', 'frontend', 'Booking form / Price', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_total', 'frontend', 'Booking form / Total price', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_payment_required', 'frontend', 'Booking form / Payment required', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment required', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO23', 'arrays', 'error_titles_ARRAY_AO23', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payments', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AO22', 'arrays', 'error_titles_ARRAY_AO22', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Options', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO22', 'arrays', 'error_bodies_ARRAY_AO22', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set different booking options for your calendar.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AO23', 'arrays', 'error_bodies_ARRAY_AO23', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set different payment options for your calendar. Enable or disable the available payment processing companies.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallInfoTitle', 'backend', 'Install / Info title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install code', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallInfoDesc', 'backend', 'Install / Info description', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy the code below and put it on your web page. It will show the front end calendar.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR12', 'arrays', 'error_titles_ARRAY_AR12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invoices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR12', 'arrays', 'error_bodies_ARRAY_AR12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below you can view all the invoices made for the reservation. You can view the invoice and print or email it to your customer. You can also create additional invoices for balance payment.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblToday', 'backend', 'Today', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR18', 'arrays', 'error_titles_ARRAY_AR18', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR18', 'arrays', 'error_bodies_ARRAY_AR18', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use form below to add reservation details.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridEmptyDate', 'backend', 'Grid / Empty date', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '(empty date)', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridInvalidDate', 'backend', 'Grid / Invalid date', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '(invalid date)', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridInvalidDatetime', 'backend', 'Grid / Invalid datetime', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '(invalid date/time)', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'gridEmptyDatetime', 'backend', 'Grid / Empty datetime', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '(empty date/time)', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_authorize_hash', 'backend', 'Options / Authorize.net hash value', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Authorize.net hash value', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_captcha', 'arrays', 'Calendar / Captcha is not correct', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Captcha is not correct', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACR10', 'arrays', 'error_bodies_ARRAY_ACR10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'From the list below you can view and manage all of the calendars.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACR10', 'arrays', 'error_titles_ARRAY_ACR10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar list', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACR11', 'arrays', 'error_titles_ARRAY_ACR11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACR11', 'arrays', 'error_bodies_ARRAY_ACR11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to add a new calendar, giving it name and owner.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_ACR12', 'arrays', 'error_titles_ARRAY_ACR12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_ACR12', 'arrays', 'error_bodies_ARRAY_ACR12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the form below to update already existing calendar.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuInstallPreview', 'backend', 'Menu Install & Preview', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install & Preview', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallPreview', 'backend', 'Install / Preview', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy the code below and put it on your web page where you want the calendar to appear.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuCalendar', 'backend', 'Menu Calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblCalendarNewReserv', 'backend', 'Calendars / New Reservation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New Reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallConfigLang', 'backend', 'Install / Language icons', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Language icons', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallConfigCalendar', 'backend', 'Install / Calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblInstallConfigAllCalendars', 'backend', 'Install / All Calendars', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU10', 'arrays', 'error_bodies_ARRAY_AU10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use form below to set up a new user of the system.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU10', 'arrays', 'error_titles_ARRAY_AU10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add user', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AU11', 'arrays', 'error_titles_ARRAY_AU11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update user', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AU11', 'arrays', 'error_bodies_ARRAY_AU11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use form below to update an existing user of the system.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationDetails', 'backend', 'Reservation / Details', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Details', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationInvoices', 'backend', 'Reservation / Invoices', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invoices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationResend', 'backend', 'Reservation / Resend', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Resend confirmation email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPrevMonth', 'backend', 'Reservation / Previous month', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prev Month', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationNextMonth', 'backend', 'Reservation / Next Month', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Next Month', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblBackToCalendars', 'frontend', 'Back to calendars', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Back to calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_availability_note', 'frontend', 'Frontend / Click on calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Click on calendar name below to make a reservation.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_new_user', 'backend', 'Dashboard / Add New User', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add New User', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_new_calendar', 'backend', 'Dashboard / Create New Calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Create New Calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_new_reservation', 'backend', 'Dashboard / Add New Reservation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add New Reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_pending_reservations', 'backend', 'Dashboard / Pending reservations', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_cancelled_reservations', 'backend', 'Dashboard / Cancelled reservations', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancelled reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_this_week_reservations', 'backend', 'Dashboard / This week reservations', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This week reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_view_availability', 'backend', 'Dashboard / View availability', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'View availability', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_last_7days_reservations', 'backend', 'Dashboard / Last 7 days', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations made in last 7 days', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_quick_links', 'backend', 'Dashboard / Quick links', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Quick Links', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblNA', 'backend', 'Reservation / n/a', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'n/a', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_languages', 'backend', 'Locale plugin / Languages', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_titles', 'backend', 'Locale plugin / Title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Translate', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_index_title', 'backend', 'Locale plugin / Languages info title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Languages', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_index_body', 'backend', 'Locale plugin / Languages info body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add as many languages as you need to your script. For each of the languages added you need to translate all the text titles.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_titles_title', 'backend', 'Locale plugin / Titles info title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Titles', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_titles_body', 'backend', 'Locale plugin / Titles info body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Using the form below you can edit all the text in the software.<br /><br />Each piece of text used in the software is saved in the database and has its own unique ID. In the first column below you can see the ID for each piece of text. To show these IDs in the script itself check the "Show IDs" checkbox and click Save button next to it. This will show the corresponding :ID: for each text message. Please, note that ONLY you will see these IDs. Now you can search for any ID and easily change and/or translate the text. Have in the mind that you should use : before and after the ID when you search for it.  <br /><br />Check our <a target="_blank" href="http://www.phpjabbers.com/knowledgebase/other">knowledgebase</a> and watch video tutorial how to change and/or translate the text.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_title', 'backend', 'Locale plugin / Title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Title', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_flag', 'backend', 'Locale plugin / Flag', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Flag', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_is_default', 'backend', 'Locale plugin / Is default', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Is default', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_order', 'backend', 'Locale plugin / Order', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Order', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_add_lang', 'backend', 'Locale plugin / Add Language', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add Language', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_field', 'backend', 'Locale plugin / Field', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Field', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_value', 'backend', 'Locale plugin / Value', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Value', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_type_backend', 'backend', 'Locale plugin / Back-end title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Back-end title', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_type_frontend', 'backend', 'Locale plugin / Front-end title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Front-end title', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_type_arrays', 'backend', 'Locale plugin / Special title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Special title', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL01', 'arrays', 'Locale plugin / Status title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Titles Updated', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL01', 'arrays', 'Locale plugin / Status body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to titles have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_rows', 'backend', 'Locale plugin / Per page', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Per page', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL02', 'arrays', 'Locale plugin / Status title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import error', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL02', 'arrays', 'Locale plugin / Status body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed due missing parameters.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL03', 'arrays', 'Locale plugin / Status title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import complete', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL03', 'arrays', 'Locale plugin / Status body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The import was performed successfully.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL04', 'arrays', 'Locale plugin / Status title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import error', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL04', 'arrays', 'Locale plugin / Status body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed due empty data.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL05', 'arrays', 'Locale plugin / Status title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import error', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL05', 'arrays', 'Locale plugin / Status body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed because file cannot be open.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_import_export', 'backend', 'Locale plugin / Import Export menu', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import / Export', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_import', 'backend', 'Locale plugin / Import', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_export', 'backend', 'Locale plugin / Export', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_browse', 'backend', 'Locale plugin / Browse your computer', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Browse your computer', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_ie_title', 'backend', 'Locale plugin / Import Export (title)', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import / Export', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_ie_body', 'backend', 'Locale plugin / Import Export (body)', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use form below to Import or Export CSV with all titles. Please, do not change first row and first and second column in the CSV file.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_separator', 'backend', 'Locale plugin / Delimiter', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delimiter', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_separators_ARRAY_comma', 'arrays', 'Locale plugin / Delimiter: comma', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Comma', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_separators_ARRAY_semicolon', 'arrays', 'Locale plugin / Delimiter: semicolon', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Semicolon', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_separators_ARRAY_tab', 'arrays', 'Locale plugin / Delimiter: tab', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tab', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL20', 'arrays', 'error_bodies_ARRAY_PAL20', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The following languages have been found. Select those you want to import.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL20', 'arrays', 'error_titles_ARRAY_PAL20', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL11', 'arrays', 'error_titles_ARRAY_PAL11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL11', 'arrays', 'error_bodies_ARRAY_PAL11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Missing, empty or invalid parameters.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL12', 'arrays', 'error_titles_ARRAY_PAL12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL12', 'arrays', 'error_bodies_ARRAY_PAL12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'File have not been uploaded.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL13', 'arrays', 'error_titles_ARRAY_PAL13', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL13', 'arrays', 'error_bodies_ARRAY_PAL13', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Uploaded file cannot open for reading.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL14', 'arrays', 'error_titles_ARRAY_PAL14', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL14', 'arrays', 'error_bodies_ARRAY_PAL14', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New line(s) have been found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL15', 'arrays', 'error_titles_ARRAY_PAL15', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL15', 'arrays', 'error_bodies_ARRAY_PAL15', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Uploaded file doesn''t contain the necessary columns.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL16', 'arrays', 'error_titles_ARRAY_PAL16', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL16', 'arrays', 'error_bodies_ARRAY_PAL16', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Number of columns are not equal on every row.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL17', 'arrays', 'error_titles_ARRAY_PAL17', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL17', 'arrays', 'error_bodies_ARRAY_PAL17', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invalid data found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL18', 'arrays', 'error_titles_ARRAY_PAL18', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL18', 'arrays', 'error_bodies_ARRAY_PAL18', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Missing columns.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PAL19', 'arrays', 'error_titles_ARRAY_PAL19', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import failed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PAL19', 'arrays', 'error_bodies_ARRAY_PAL19', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Invalid data found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_id', 'backend', 'Label / ID:', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'ID:', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_show_id', 'backend', 'Label / Show ID in all titles to easily locate them', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Show IDs', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_showid_dialog_title', 'backend', 'Label / Show IDs', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Show IDs', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_showid_dialog_desc', 'backend', 'Label / Show IDs', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'ID will be displayed next to each text found in the software. You can then search for an ID to easily change or translate the text.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_button_confirm', 'backend', 'Button / Confirm', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirm', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_button_cancel', 'backend', 'Button / Cancel', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_default', 'backend', 'Label / default', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'default', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_dir', 'backend', 'Locale plugin / Text direction', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Text direction', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_fend', 'backend', 'Locale plugin / Front-end title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Front-end title', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_dir_ARRAY_ltr', 'arrays', 'Locale plugin / Left to Right', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Left to Right', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_dir_ARRAY_rtl', 'arrays', 'Locale plugin / Right to Left', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Right to Left', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_flag_reset_title', 'backend', 'Locale plugin / Reset flag', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reset flag', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_flag_reset_content', 'backend', 'Locale plugin / Reset flag: confirmation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to reset selected flag?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_btn_reset', 'backend', 'Locale plugin / Button: Reset', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reset', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_tooltip_upload', 'backend', 'Locale plugin / Upload tooltip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Click to upload', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_tooltip_reset', 'backend', 'Locale plugin / Reset tooltip', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Click to reset', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_lbl_language', 'backend', 'Locale plugin / Language', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Language', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_btn_close', 'backend', 'Locale plugin / Button: Close', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Close', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_flag_info_title', 'backend', 'Locale plugin / Info message', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Info message', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_locale_error_line', 'backend', 'Label / Error found at line', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The error was found at line: %s', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PBU01', 'arrays', 'error_titles_ARRAY_PBU01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PBU02', 'arrays', 'error_titles_ARRAY_PBU02', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup complete!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PBU03', 'arrays', 'error_titles_ARRAY_PBU03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup failed!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PBU04', 'arrays', 'error_titles_ARRAY_PBU04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup failed!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PBU01', 'arrays', 'error_bodies_ARRAY_PBU01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We recommend you to regularly back up your database and files to prevent any loss of information.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PBU02', 'arrays', 'error_bodies_ARRAY_PBU02', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All backup files have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PBU03', 'arrays', 'error_bodies_ARRAY_PBU03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No option was selected.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PBU04', 'arrays', 'error_bodies_ARRAY_PBU04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup not performed.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_menu_backup', 'backend', 'Backup plugin / Menu Backup', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_database', 'backend', 'Backup plugin / Backup database', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup database', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_files', 'backend', 'Backup plugin / Backup files', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup files', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_btn_backup', 'backend', 'Backup plugin / Backup button', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PBU05', 'arrays', 'error_titles_ARRAY_PBU05', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup failed!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PBU05', 'arrays', 'error_bodies_ARRAY_PBU05', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup folder not found. Please ensure that "app/web/backup" folder exists.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PBU06', 'arrays', 'error_titles_ARRAY_PBU06', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Backup failed!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PBU06', 'arrays', 'error_bodies_ARRAY_PBU06', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You need to set write permissions (chmod 777) to "app/web/backup" folder.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_datetime', 'backend', 'Label / Date/time', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date/time', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_type', 'backend', 'Label / Type', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Type', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_file', 'backend', 'Label / File', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'File', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_delete_confirmation', 'backend', 'Backup plugin / Delete confirmation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to delete selected file?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_delete_selected', 'backend', 'Backup plugin / Delete selected', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete selected', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_size', 'backend', 'Plugin / Size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Size', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_backup_sizeXXXXXX', 'backend', 'Plugin / Size', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SizeXXXX', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_log_menu_log', 'backend', 'Log plugin / Menu Log', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Log', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_log_menu_config', 'backend', 'Log plugin / Menu Config', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Config log', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_log_btn_empty', 'backend', 'Log plugin / Empty button', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Empty log', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PLG01', 'arrays', 'error_titles_ARRAY_PLG01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Config log updated.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PLG01', 'arrays', 'error_bodies_ARRAY_PLG01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The config log have been updated.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_POA01', 'arrays', 'error_titles_ARRAY_POA01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Information', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_POA01', 'arrays', 'error_bodies_ARRAY_POA01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please, note that after changing the scripts in the list below you will need to refresh the page to apply the new updates in the "One admiN" menu.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PSS01', 'arrays', 'SMS plugin / Info title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMS', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PSS01', 'arrays', 'SMS plugin / Info body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To send SMS you need a valid API Key from <a href="https://clicksend.com/?u=366773">ClickSend</a>. If you have one, enter it in the box below. Click on "Verify your key" button to check if key is valid. Click on "Send a test message" button to send a test message to your phone.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PSS02', 'arrays', 'SMS plugin / API key updates info title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMS API key updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PSS02', 'arrays', 'SMS plugin / API key updates info body', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All changes have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_menu', 'backend', 'Price plugin / Menu Prices', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_add_season', 'backend', 'Price plugin / Add Seasonal Prices', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add Seasonal Prices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_season_title', 'backend', 'Price plugin / Add seasonal prices', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add seasonal prices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_season_name', 'backend', 'Price plugin / Season Title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Season Title', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_date_range', 'backend', 'Price plugin / Date range', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date range', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_from', 'backend', 'Price plugin / From', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'From', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_to', 'backend', 'Price plugin / To', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_default', 'backend', 'Price plugin / Default price', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Default price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_adults', 'backend', 'Price plugin / Adults', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Adults', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_children', 'backend', 'Price plugin / Children', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_adults_children', 'backend', 'Price plugin / Adults & Children', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add Number of Guests Special Price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_save', 'backend', 'Price plugin / Save', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Save', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_days_ARRAY_monday', 'arrays', 'Price plugin / Days - Monday', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Monday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_days_ARRAY_tuesday', 'arrays', 'Price plugin / Days - Tuesday', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tuesday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_days_ARRAY_wednesday', 'arrays', 'Price plugin / Days - Wednesday', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Wednesday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_days_ARRAY_thursday', 'arrays', 'Price plugin / Days - Thursday', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Thursday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_days_ARRAY_friday', 'arrays', 'Price plugin / Days - Friday', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Friday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_days_ARRAY_saturday', 'arrays', 'Price plugin / Days - Saturday', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Saturday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_days_ARRAY_sunday', 'arrays', 'Price plugin / Days - Sunday', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sunday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PPR02', 'arrays', 'Price plugin / Missing parameters', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Missing parameters!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PPR02', 'arrays', 'Price plugin / Missing parameters', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'It seems that there are missing parameters.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PPR01', 'arrays', 'Price plugin / Price saved', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prices have been saved!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PPR01', 'arrays', 'Price plugin / Price saved', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prices have been saved successfully.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PPR03', 'arrays', 'Price plugin / Prices title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set prices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PPR03', 'arrays', 'Price plugin / Prices content', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set a default price for each day/night of the week. You can also set different prices based on the number of guests (adults and children) making the reservation. Click on "Add Seasonal Prices" to define different seasonal prices for specific periods of the year.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_status_start', 'backend', 'Price plugin / Saving start notification', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please wait while prices are saved...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_status_end', 'backend', 'Price plugin / Saving end notification', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prices has been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_delete_title', 'backend', 'Price plugin / Delete confirmation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_delete_content', 'backend', 'Price plugin / Are you sure you want to delete selected row?', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to delete selected row? Please, note that you should click SAVE button to save the changes.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_delete_season_title', 'backend', 'Price plugin / Delete confirmation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_delete_season_content', 'backend', 'Price plugin / Are you sure you want to delete selected season?', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to delete selected season? Please, note that you should click SAVE button to save the changes.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_status_title', 'backend', 'Price plugin / Saving dialog title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_status_fail', 'backend', 'Price plugin / Saving fail notification', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The season date range overlap with another season.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PPR09', 'arrays', 'Price plugin / Overlap title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Attention', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PPR09', 'arrays', 'Price plugin / Overlap message', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please note that there are overlapping date periods.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_price_special_price', 'backend', 'Price plugin / Special price', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Special Price Based on Number of Guests', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_add_period', 'backend', 'Period plugin / Button Add Period', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add period / price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_start_date', 'backend', 'Period plugin / Start date', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Start date', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_end_date', 'backend', 'Period plugin / End date', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'End date', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_del_desc', 'backend', 'Period plugin / Delete period description', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to delete selected period/price?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_del_title', 'backend', 'Period plugin / Delete period title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_menu', 'backend', 'Period plugin / Menu Periods', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Periods', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_adults_children', 'backend', 'Period plugin / Adults & Children', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Adults & Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_adults', 'backend', 'Period plugin / Adults', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Adults', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_children', 'backend', 'Period plugin / Children', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_default', 'backend', 'Period plugin / Default price', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Default price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_from_day', 'backend', 'Period plugin / From day', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'From day', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_to_day', 'backend', 'Period plugin / To day', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To day', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_save', 'backend', 'Period plugin / Save', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Save', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PPE01', 'arrays', 'Period plugin / Period saved', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Period(s) added.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PPE01', 'arrays', 'Period plugin / Period saved', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Period(s) has been added.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PPE02', 'arrays', 'Period plugin / Error occured', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Period(s) are empty or failed to add.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PPE02', 'arrays', 'Period plugin / Error occured', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Periods(s) not added.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PPE03', 'arrays', 'Period plugin / Period title', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Price per periods', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PPE03', 'arrays', 'Period plugin / Period content', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Create different periods and set price for each of them. The price can also be based on the number of adults and children who make the reservation.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_status_start', 'backend', 'Period plugin / Saving start notification', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please wait while periods are saved...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_period_status_end', 'backend', 'Period plugin / Saving end notification', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Periods has been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_name', 'backend', 'Country plugin / Country name', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country name', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_alpha_2', 'backend', 'Country plugin / Alpha 2', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Alpha 2', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_alpha_3', 'backend', 'Country plugin / Alpha 3', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Alpha 3', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_status', 'backend', 'Country plugin / Status', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Status', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_btn_add', 'backend', 'Country plugin / Button Add', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_statuses_ARRAY_T', 'arrays', 'Country plugin / Status (active)', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Active', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_statuses_ARRAY_F', 'arrays', 'Country plugin / Status (inactive)', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Inactive', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_btn_save', 'backend', 'Country plugin / Button Save', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Save', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_btn_cancel', 'backend', 'Country plugin / Button Cancel', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_menu_countries', 'backend', 'Country plugin / Menu Countries', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Countries', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PCY01', 'arrays', 'error_titles_ARRAY_PCY01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country updated', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PCY03', 'arrays', 'error_titles_ARRAY_PCY03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country added', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PCY04', 'arrays', 'error_titles_ARRAY_PCY04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country failed to add', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PCY08', 'arrays', 'error_titles_ARRAY_PCY08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country not found', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PCY10', 'arrays', 'error_titles_ARRAY_PCY10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add country', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PCY11', 'arrays', 'error_titles_ARRAY_PCY11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update country', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_PCY12', 'arrays', 'error_titles_ARRAY_PCY12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Manage countries', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PCY01', 'arrays', 'error_bodies_ARRAY_PCY01', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country has been updated successfully.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PCY03', 'arrays', 'error_bodies_ARRAY_PCY03', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country has been added successfully.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PCY04', 'arrays', 'error_bodies_ARRAY_PCY04', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country has not been added successfully.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PCY08', 'arrays', 'error_bodies_ARRAY_PCY08', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Country you are looking for has not been found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PCY10', 'arrays', 'error_bodies_ARRAY_PCY10', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use form below to add a country.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PCY11', 'arrays', 'error_bodies_ARRAY_PCY11', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use form below to update a country.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_PCY12', 'arrays', 'error_bodies_ARRAY_PCY12', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use grid below to organize your country list.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_delete_confirmation', 'backend', 'Country plugin / Delete confirmation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Are you sure you want to delete selected country?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_delete_selected', 'backend', 'Country plugin / Delete selected', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete selected', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_btn_all', 'backend', 'Country plugin / Button All', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_btn_search', 'backend', 'Country plugin / Button Search', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Search', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'plugin_country_revert_status', 'backend', 'Plugin / Revert status', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Revert status', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblBackToCalendar', 'frontend', 'Back to calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Back to calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_calendar', 'arrays', 'Calendar / Loading calendar ...', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Loading calendar ...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_form', 'arrays', 'Calendar / Loading booking form ...', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Loading booking form ...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_summary', 'arrays', 'Calendar / Loading confirmation ...', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Loading confirmation ...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_save', 'arrays', 'Calendar / Saving reservation ...', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Saving reservation ...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_paypal', 'arrays', 'Calendar / Redirecting to PayPal.com ...', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Saving reservation and redirecting to PayPal.com ...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_authorize', 'arrays', 'Calendar / Redirecting to Authorize.net ...', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Saving reservation and redirecting to Authorize.net ...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblCalendarMessage', 'frontend', 'Calendar message', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Click on available arrival date and then on departure date to make a reservation.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_background_nav_hover', 'backend', 'Options / Month Nav Hover Background', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Month Nav Hover Background', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblWeekTitle', 'backend', 'week', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'week', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblChangeDates', 'frontend', 'change dates', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'change dates', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblExport', 'frontend', 'Label / Export', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AR21', 'arrays', 'error_titles_ARRAY_AR21', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AR21', 'arrays', 'error_bodies_ARRAY_AR21', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can export reservations in different formats. You can either download a file with reservation details or use a link for a feed which load all the reservations.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_formats_ARRAY_ical', 'arrays', 'export_formats_ARRAY_ical', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'iCal', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_formats_ARRAY_xml', 'arrays', 'export_formats_ARRAY_xml', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'XML', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_formats_ARRAY_csv', 'arrays', 'export_formats_ARRAY_csv', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'CSV', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_types_ARRAY_file', 'arrays', 'export_types_ARRAY_file', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'File', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_types_ARRAY_feed', 'arrays', 'export_types_ARRAY_feed', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Feed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_periods_ARRAY_next', 'arrays', 'export_periods_ARRAY_next', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Coming', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_periods_ARRAY_last', 'arrays', 'export_periods_ARRAY_last', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Created or Modified', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnExport', 'backend', 'Button / Export', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblFormat', 'backend', 'Label / Format', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Format', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblType', 'backend', 'Label / Type', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Type', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservations', 'backend', 'Label / Reservations', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationsMade', 'backend', 'Label / reservations made', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'reservations made', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblComingReservations', 'backend', 'Label / coming reservations ', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'coming reservations ', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationsFeedURL', 'backend', 'Label / Reservations Feed URL', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations Feed URL', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnGetFeedURL', 'backend', 'Button / Get Feed URL', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Get Feed URL', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_calendars', 'arrays', 'Calendar / Loading calendars ...', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Loading calendars ...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblEnterPassword', 'backend', 'Label / Enter password', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Enter password', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblNoAccessToFeed', 'backend', 'Label / No access to feed', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No access to feed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'coming_arr_ARRAY_1', 'arrays', 'coming_arr_ARRAY_1', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'coming_arr_ARRAY_2', 'arrays', 'coming_arr_ARRAY_2', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tomorrow', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'coming_arr_ARRAY_3', 'arrays', 'coming_arr_ARRAY_3', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This week', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'coming_arr_ARRAY_4', 'arrays', 'coming_arr_ARRAY_4', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Next week', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'coming_arr_ARRAY_5', 'arrays', 'coming_arr_ARRAY_5', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This month', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'coming_arr_ARRAY_6', 'arrays', 'coming_arr_ARRAY_6', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Next month', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'made_arr_ARRAY_1', 'arrays', 'made_arr_ARRAY_1', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'made_arr_ARRAY_2', 'arrays', 'made_arr_ARRAY_2', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Yesterday', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'made_arr_ARRAY_3', 'arrays', 'made_arr_ARRAY_3', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This week', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'made_arr_ARRAY_4', 'arrays', 'made_arr_ARRAY_4', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Last week', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'made_arr_ARRAY_5', 'arrays', 'made_arr_ARRAY_5', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This month', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'made_arr_ARRAY_6', 'arrays', 'made_arr_ARRAY_6', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Last month', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblCalendar', 'backend', 'Label / Calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoReservationFeedTitle', 'backend', 'Infobox / Reservations Feed URL', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations Feed URL', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoReservationFeedDesc', 'backend', 'Infobox / Reservations Feed URL', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Use the URL below to have access to all reservations. Please, note that if you change the password the URL will change too as password is used in the URL itself so no one else can open it.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblEdit', 'backend', 'Label / Edit', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_allow_cash', 'backend', 'Options / Allow payment with cash', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Allow payment with cash', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'payment_methods_ARRAY_cash', 'arrays', 'payment_methods_ARRAY_cash', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cash', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPrice', 'backend', 'Label / Price', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationTotal', 'backend', 'Label / Total', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblAvailableTokens', 'backend', 'Label / Available tokens', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<table width="100%" border="0" cellspacing="0" cellpadding="0"><tbody><tr><td width="50%" valign="top">{Name} - The customer''s name;<br/> {Email} - The customer''s e-mail;<br/> {Phone} - The provided phone number;<br/> {Notes} - Any additional notes;<br/> {Address} - The provided address;<br/> {City} - The provided city;<br/> {Country} - The provided country;<br/> {State} - The provided state;<br/> {Zip} - The provided zip code;<br/> {CCType} - The provided CC type;<br/> {CCNum} - The provided CC number;<br/>{CCExpMonth} - The provided CC exp.month;<br/> {CCExpYear} - The provided CC exp.year;<br/> {CCSec} - The provided CC sec. code;<br/> {PaymentMethod} - The payment method;</td><td width="50%" valign="top">{StartDate} - Reservation''s start date;<br/> {EndDate} - Reservation''s end date;<br/> {Deposit} - Deposit;<br/>{Tax} - Tax;<br/> {Price} - Price;<br/> {TotalPrice} - Total Price;<br/> {CalendarID} - Calendar ID;<br/> {ReservationID} - Reservation''s ID;<br/> {ReservationUUID} - Reservation''s UUID;<br/> {CancelURL} - Cancel URL</td</tr></tbody></table>', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDuplicatedUniqueID', 'backend', 'Label / There is another reservation with such ID.', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There is another reservation with such ID.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'jquery_validation_ARRAY_required', 'arrays', 'jquery_validation_ARRAY_required', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This field is required.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'jquery_validation_ARRAY_email', 'arrays', 'jquery_validation_ARRAY_email', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please enter a valid email.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_err_ARRAY_limit', 'arrays', 'Calendar / Limit not match', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Limits not match. Min: {MIN}, Max: {MAX}, Your choise: {YOUR}', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_periods_ARRAY_all', 'arrays', 'export_periods_ARRAY_all', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'export_periods_ARRAY_range', 'arrays', 'export_periods_ARRAY_range', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Specific period', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'login_err_ARRAY_4', 'arrays', 'login_err_ARRAY_4', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email is not valid.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnAddCalendar', 'backend', 'Button / Add calendar', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnAddUser', 'backend', 'Button / + Add user', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add user', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblPeriod', 'backend', 'Label / Period', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Period', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionAvailableTokens', 'backend', 'Label / Available tokens', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', '<table width="100%" border="0" cellspacing="0" cellpadding="0"><tbody><tr><td width="50%" valign="top">{Name} - The customer''s name;<br/> {Email} - The customer''s e-mail;<br/> {Phone} - The provided phone number;<br/> {Notes} - Any additional notes;<br/> {Address} - The provided address;<br/> {City} - The provided city;<br/> {Country} - The provided country;<br/> {State} - The provided state;<br/> {Zip} - The provided zip code;<br/> {CCType} - The provided CC type;<br/> {CCNum} - The provided CC number;<br/>{CCExpMonth} - The provided CC exp.month;<br/> {CCExpYear} - The provided CC exp.year;<br/> {CCSec} - The provided CC sec. code;<br/> {PaymentMethod} - The payment method;</td><td width="50%" valign="top">{StartDate} - Reservation''s start date;<br/> {EndDate} - Reservation''s end date;<br/> {Deposit} - Deposit;<br/> {Tax} - Tax;<br/> {Price} - Price;<br/> {TotalPrice} - Total Price;<br/> {CalendarID} - Calendar ID;<br/> {CalendarName} - Calendar name;<br/> {ReservationID} - Reservation''s ID;<br/> {ReservationUUID} - Reservation''s UUID;<br/> {CancelURL} - Cancel URL</td</tr></tbody></table>', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoUpdateReservationTitle', 'backend', 'Infobox / Update reservation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoUpdateReservationDesc', 'backend', 'Infobox / Update reservation', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can make any changes to this reservation. Just click "Save" to update the booking details.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'bf_review_booking', 'frontend', 'Label / Please review your details', 'script', '2021-02-03 08:52:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please review your details', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_current_reservations', 'backend', 'Dash / Current reservations', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Current Reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_export_reservations', 'backend', 'Dash / Export reservations', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_make_backup', 'backend', 'Dash / Make back-up', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Make back-up', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_reservations_confirmed_today', 'backend', 'Infobox / reservations confirmed today', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'reservations for today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_reservations_made_today', 'backend', 'Infobox / new reservations made today', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'reservations made today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_reservation_confirmed_today', 'backend', 'Infobox / reservation confirmed today', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'reservation for today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_reservation_made_today', 'backend', 'Infobox / new reservation made today', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'new reservation made today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_set_confirmation_messages', 'backend', 'Dash / Set Confirmation Messages', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set Confirmation Messages', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnAddReservation', 'backend', 'Button / Add reservation', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoAvailabilityDesc', 'backend', 'Infobox / Availability', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Check the monthly availability of all your calendars. Click on each reservation to see details.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoAvailabilityTitle', 'backend', 'Infobox / Availability', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Availability calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoGeneralDesc', 'backend', 'Infobox / General options', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Configure the general settings for your Availability Booking Calendar.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoGeneralTitle', 'backend', 'Infobox / General options', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'General options', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblAdults', 'backend', 'Label / adults', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'adults', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblCalendarHasReservation', 'backend', 'Label / There are X reservations for this calendar which will be deleted too. Do you want to delete it?', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There is {COUNT} reservation for this calendar which will be deleted too. Do you want to delete it?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblCalendarHasReservations', 'backend', 'Label / There are X reservations for this calendar which will be deleted too. Do you want to delete it?', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'There are {COUNT} reservations for this calendar which will be deleted too. Do you want to delete it?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblCalendars', 'backend', 'Label / Calendars', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblChildren', 'backend', 'Label / chidren', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'recipients_ARRAY_client', 'arrays', 'recipients_ARRAY_client', 'script', '2020-11-12 03:38:26');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'recipients_ARRAY_owner', 'arrays', 'recipients_ARRAY_owner', 'script', '2020-10-26 05:40:30');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'recipients_ARRAY_admin', 'arrays', 'recipients_ARRAY_admin', 'script', '2020-10-26 05:40:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Administrator', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoNotificationsTitle', 'backend', 'Infobox / Notifications', 'script', '2020-10-20 06:56:53');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoNotificationsDesc', 'backend', 'Infobox / Notifications', 'script', '2020-10-20 06:58:15');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email notifications will be sent to administrator or owner after new registration or reservation made. If you leave subject field blank no email will be sent.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_recipient', 'backend', 'Label / Messages sent to', 'script', '2020-10-26 05:41:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent to', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_msg_to_client', 'backend', 'notifications_msg_to_client', 'script', '2020-10-26 05:54:34');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent to Client', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_msg_to_owner', 'backend', 'notifications_msg_to_owner', 'script', '2020-10-26 05:54:34');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent to Owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_msg_to_admin', 'backend', 'notifications_msg_to_admin', 'script', '2020-10-26 05:54:45');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent to Admin', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_msg_to_default', 'backend', 'notifications_msg_to_default', 'script', '2020-10-26 05:55:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages sent', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_send', 'backend', 'notifications_send', 'script', '2020-10-26 05:55:37');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_do_not_send', 'backend', 'notifications_do_not_send', 'script', '2020-10-26 05:55:53');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Do not send', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_confirmation', 'arrays', 'notifications_ARRAY_client_email_confirmation', 'plugin', '2020-08-03 19:43:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send booking confirmation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_payment', 'arrays', 'notifications_ARRAY_client_email_payment', 'plugin', '2020-08-03 19:44:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_client_email_cancel', 'arrays', 'notifications_ARRAY_client_email_cancel', 'plugin', '2020-08-03 19:44:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_owner_email_confirmation', 'arrays', 'notifications_ARRAY_owner_email_confirmation', 'plugin', '2020-08-03 19:43:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send booking confirmation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_owner_email_payment', 'arrays', 'notifications_ARRAY_owner_email_payment', 'plugin', '2020-08-03 19:44:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_owner_email_cancel', 'arrays', 'notifications_ARRAY_owner_email_cancel', 'plugin', '2020-08-03 19:44:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_confirmation', 'arrays', 'notifications_ARRAY_admin_email_confirmation', 'plugin', '2020-08-03 19:54:22');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send booking confirmation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_payment', 'arrays', 'notifications_ARRAY_admin_email_payment', 'plugin', '2020-08-03 19:54:34');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_email_cancel', 'arrays', 'notifications_ARRAY_admin_email_cancel', 'plugin', '2020-08-03 19:54:45');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_sms_confirmation', 'arrays', 'notifications_ARRAY_admin_sms_confirmation', 'plugin', '2020-08-03 19:55:25');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send booking confirmation SMS', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_sms_payment', 'arrays', 'notifications_ARRAY_admin_sms_payment', 'plugin', '2020-08-03 19:55:47');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation SMS', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_admin_sms_cancel', 'arrays', 'notifications_ARRAY_admin_sms_cancel', 'plugin', '2020-08-03 19:55:47');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send booking cancel SMS', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subject', 'backend', 'Label / Subject', 'plugin', '2020-08-03 20:01:46');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Subject', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_messages', 'backend', 'Label / Messages', 'plugin', '2020-08-03 20:02:46');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Messages', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_is_active', 'backend', 'Label / Send this message', 'plugin', '2020-08-03 20:03:27');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send this message', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_confirmation', 'arrays', 'notifications_titles_ARRAY_client_email_confirmation', 'plugin', '2020-08-03 20:04:56');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Confirmation email sent to Client', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_confirmation', 'arrays', 'notifications_subtitles_ARRAY_client_email_confirmation', 'plugin', '2020-08-03 20:05:27');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to client when a new booking is made.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_payment', 'arrays', 'notifications_titles_ARRAY_client_email_payment', 'plugin', '2020-08-03 20:05:52');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Confirmation email sent to Client', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_payment', 'arrays', 'notifications_subtitles_ARRAY_client_email_payment', 'plugin', '2020-08-03 20:06:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the client when a payment is made for a new booking.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_client_email_cancel', 'arrays', 'notifications_titles_ARRAY_client_email_cancel', 'plugin', '2020-08-03 20:06:54');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Cancellation email sent to Client', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_client_email_cancel', 'arrays', 'notifications_subtitles_ARRAY_client_email_cancel', 'plugin', '2020-08-03 20:07:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the client when a client cancels a booking.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_owner_email_confirmation', 'arrays', 'notifications_titles_ARRAY_owner_email_confirmation', 'plugin', '2020-08-03 20:04:56');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Confirmation email sent to Owner', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_owner_email_confirmation', 'arrays', 'notifications_subtitles_ARRAY_owner_email_confirmation', 'plugin', '2020-08-03 20:05:27');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to owner when a new booking is made.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_owner_email_payment', 'arrays', 'notifications_titles_ARRAY_owner_email_payment', 'plugin', '2020-08-03 20:05:52');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Confirmation email sent to Owner', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_owner_email_payment', 'arrays', 'notifications_subtitles_ARRAY_owner_email_payment', 'plugin', '2020-08-03 20:06:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the owner when a payment is made for a new booking.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_owner_email_cancel', 'arrays', 'notifications_titles_ARRAY_owner_email_cancel', 'plugin', '2020-08-03 20:06:54');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Cancellation email sent to Owner', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_owner_email_cancel', 'arrays', 'notifications_subtitles_ARRAY_owner_email_cancel', 'plugin', '2020-08-03 20:07:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the owner when a client cancels a booking.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_confirmation', 'arrays', 'notifications_titles_ARRAY_admin_email_confirmation', 'plugin', '2020-08-03 20:10:26');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Confirmation email sent to Admin', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_confirmation', 'arrays', 'notifications_subtitles_ARRAY_admin_email_confirmation', 'plugin', '2020-08-03 20:10:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to Admin when a new booking is made.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_payment', 'arrays', 'notifications_titles_ARRAY_admin_email_payment', 'plugin', '2020-08-03 20:11:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Confirmation email sent to Admin', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_payment', 'arrays', 'notifications_subtitles_ARRAY_admin_email_payment', 'plugin', '2020-08-03 20:11:58');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the Admin when a payment is made for a new booking.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_email_cancel', 'arrays', 'notifications_titles_ARRAY_admin_email_cancel', 'plugin', '2020-08-03 20:12:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Cancellation email sent to Admin', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_email_cancel', 'arrays', 'notifications_subtitles_ARRAY_admin_email_cancel', 'plugin', '2020-08-03 20:12:51');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This message is sent to the Admin when a booking cancelled.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_sms_confirmation', 'arrays', 'notifications_titles_ARRAY_admin_sms_confirmation', 'plugin', '2020-08-03 20:13:25');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Confirmation SMS sent to Admin', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_sms_confirmation', 'arrays', 'notifications_subtitles_ARRAY_admin_sms_confirmation', 'plugin', '2020-08-03 20:13:50');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to the Admin when a booking made.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_sms_payment', 'arrays', 'notifications_titles_ARRAY_admin_sms_payment', 'plugin', '2020-08-03 20:14:14');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Confirmation SMS sent to Admin', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_sms_payment', 'arrays', 'notifications_subtitles_ARRAY_admin_sms_payment', 'plugin', '2020-08-03 20:14:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to the Admin when the payment made for new booking.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_admin_sms_cancel', 'arrays', 'notifications_titles_ARRAY_admin_sms_cancel', 'plugin', '2020-08-03 20:14:14');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation cancelled SMS sent to Admin', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_admin_sms_cancel', 'arrays', 'notifications_subtitles_ARRAY_admin_sms_cancel', 'plugin', '2020-08-03 20:14:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to the admin when the client cancels a reservation.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_sms_na', 'backend', 'Label / Subject', 'plugin', '2020-08-03 20:18:09');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMS notifications are currently not available for your website. See details', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_sms_na_here', 'backend', 'Label / Subject', 'plugin', '2020-08-03 20:18:43');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'here', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_main_title', 'backend', 'notifications_main_title', 'script', '2020-10-26 08:00:36');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_main_subtitle', 'backend', 'notifications_main_subtitle', 'script', '2020-10-26 08:01:25');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Automated messages are sent both to owner and administrator on specific events. Select message type to edit it - enable/disable or just change message text. For SMS notifications you need to enable SMS service. See more <a href="https://www.phpjabbers.com/web-sms/" target="_blank">here</a>.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_tokens', 'backend', 'notifications_tokens', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Available Tokens', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_tokens_note', 'backend', 'notifications_tokens_note', 'script', '2020-10-26 08:06:16');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Personalize the message by including any of the available tokens and it will be replaced with corresponding data.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'copyAppearanceInfo', 'backend', 'Label / Copy appearance', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set custom appearance for this calendar. [STAG]Copy appearance from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyAppearanceTitle', 'backend', 'Label / Copy appearance title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy appearance from another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDatesFontFamily', 'backend', 'Label / Dates font family', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dates font family', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblLegendFontFamily', 'backend', 'Label / Legend font family', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Legend font family', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblDateColors', 'backend', 'Label / Date colors', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dates font family', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblWeekMonthColors', 'backend', 'Label / Week/Month colors', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Week/Month colors', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblFontSizes', 'backend', 'Label / Font sizes', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Font sizes', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblToolColors', 'backend', 'Label / Tool colors', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tool colors', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblFontStyles', 'backend', 'Label / Font styles', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Font styles', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblBorderWidth', 'backend', 'Label / Border width', 'script', '2020-10-26 08:06:01');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Border width', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'copyLimitsInfo', 'backend', 'Label / Copy limits', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Define different periods throughout the year and set custom booking limits. For example, you may want to allow only bookings of minimum 3 nights during the high season. You can copy all the limits below from any of your other calendars. [STAG]Copy limits from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyLimitsTitle', 'backend', 'Label / Copy limits title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy limits from another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'copyPricesInfo', 'backend', 'Label / Copy prices', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set a default price for each day/night of the week. Click on "Add Seasonal Prices" to define different seasonal prices for specific periods of the year. [STAG]Copy prices from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyPricesTitle', 'backend', 'Label / Copy prices title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy prices from another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'copyPricePerPeriodsInfo', 'backend', 'Label / Copy prices', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Create different periods and set price for each of them. The price can also be based on the number of adults and children who make the reservation. [STAG]Copy prices from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyPricePerPeriodsTitle', 'backend', 'Label / Copy prices title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy prices from another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_add_seasonal_price', 'backend', 'Label / Add seasonal prices', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add seasonal prices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_add_default_price_title', 'backend', 'Label / Default price title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Default price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_add_default_price_desc', 'backend', 'Label / Default price desc', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set different price for each day/night of the week', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_add_price_per_guests_title', 'backend', 'Label / Price per guests title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Special Price Based on Number of Guests', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_add_price_per_guests_desc', 'backend', 'Label / Price per guests desc', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can add different price based on number of guests that room accommodates. Add as many adults & children combinations as you have.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_price_default', 'backend', 'Hotel / Default Price', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Default Price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_price_adults_children', 'backend', 'Label / Special Price Based on Number of Guests', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Special Price Based on Number of Guests', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_add_price_adults_children', 'backend', 'Label / Add Number of Guests Special Price', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Add Number of Guests Special Price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_add_seasonal_price_title', 'backend', 'Label / Add seasonal prices', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Add New Season', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_season_title', 'backend', 'Label / Season Title', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Season Title', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_date_range_from', 'backend', 'Label / Date range from', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Date range from', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_date_range_to', 'backend', 'Label / Date range to', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Date range to', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_adults', 'backend', 'Label / Adults', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Adults', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_children', 'backend', 'Label / Children', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_default_season_price', 'backend', 'Label / Default Season price', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Default Season price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_price_status_start', 'backend', 'Label / Saving start notification', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Please wait while prices are saved...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_price_status_end', 'backend', 'Label / Saving start notification', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Prices have been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_price_status_fail', 'backend', 'Label / Saving start notification', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'The season date range overlap with another season.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_duplicated_special_prices', 'backend', 'Label / Saving start notification', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Special prices are duplicated.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_invalid_input', 'backend', 'Label / The price value cannot be greater than 99999999999999.99', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'The price value cannot be greater than 99999999999999.99', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_invalid_price', 'backend', 'Label / Please enter a valid price.', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Please enter a valid price.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_price_status_duplicate', 'backend', 'Label / Saving start notification', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Duplicated session prices.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_delete_seasonal_price_title', 'backend', 'Prices / Delete season', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Delete season', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'prices_delete_seasonal_price_desc', 'backend', 'Prices / Delete season', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Do you really want to delete this season price?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnDelete', 'backend', 'Button Delete', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Delete', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblLoading', 'backend', 'Label / Loading', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Loading...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_default_price', 'backend', 'Label / Default price', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Default price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_start_date', 'backend', 'Label / Start date', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Start date', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_end_date', 'backend', 'Label / End date', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'End date', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_from_day', 'backend', 'Label / From day', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'From day', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_to_day', 'backend', 'Label / To day', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'To day', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_adults_children', 'backend', 'Label / Adults & Children', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Adults & Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_status_start', 'backend', 'Label / Saving start notification', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Please wait while periods are saved...', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_status_end', 'backend', 'Label / Saving end notification', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Periods has been saved.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_adults', 'backend', 'Label / Adults', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Adults', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_children', 'backend', 'Label / Children', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Children', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_add_period', 'backend', 'Label / Add period / price', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Add period / price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_del_title', 'backend', 'Period / Delete period title', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Delete period', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'period_del_desc', 'backend', 'Period / Delete period description', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Are you sure you want to delete selected period/price?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnImport', 'backend', 'Button / Import', 'script', '2020-11-12 06:54:18');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoAddICalFeed', 'backend', 'Infobox / Add iCal feed', 'script', '2020-11-12 06:55:22');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add iCal feed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblFeedURL', 'backend', 'Label / Feed URL', 'script', '2020-11-12 06:55:52');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Feed URL', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pj_field_url', 'backend', 'Label / Please enter a valid URL.', 'script', '2020-11-12 06:57:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please enter a valid URL.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pj_feed_error_msg', 'backend', 'Label / Feed error msg', 'script', '2020-11-12 06:58:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'iCal feed was not loaded. Please, make sure you specify a valid iCal feed URL', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feeds_provider', 'backend', 'Labe / Provider', 'script', '2020-11-12 07:49:36');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Provider', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feed_upcoming_reservations', 'backend', 'Labe / Upcoming reservations ', 'script', '2020-11-12 07:49:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Upcoming reservations ', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feeds_import_title', 'backend', 'rpbc_feeds_import_title', 'script', '2020-11-12 08:08:04');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import data', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feeds_import_desc', 'backend', 'rpbc_feeds_import_desc', 'script', '2020-11-12 08:08:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import all data from this feed?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feeds_import_success_desc', 'backend', 'rpbc_feeds_import_success_desc', 'script', '2020-11-12 08:08:41');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import data success!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feeds_import_error_desc', 'backend', 'rpbc_feeds_import_error_desc', 'script', '2020-11-12 08:09:04');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Import data error!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feeds_import_standard_title', 'backend', 'rpbc_feeds_import_standard_title', 'script', '2020-11-12 08:09:49');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'iCal feed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feeds_import_standard_desc', 'backend', 'rpbc_feeds_import_standard_desc', 'script', '2020-11-12 08:10:18');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Supported iCal feeds are Airbnb, VRBO, Homeway, Tripadvisor, Booking.com. Your iCal feed was not recognized and will only work if it’s a standard iCal format. Contact us if you require another iCal feed to be supported', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'feed_providers_ARRAY_1', 'arrays', 'feed_providers_ARRAY_1', 'script', '2020-11-12 08:11:06');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Standard iCal', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'feed_providers_ARRAY_2', 'arrays', 'feed_providers_ARRAY_2', 'script', '2020-11-12 08:11:18');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Airbnb', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'feed_providers_ARRAY_3', 'arrays', 'feed_providers_ARRAY_3', 'script', '2020-11-12 08:11:27');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'VRBO', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'feed_providers_ARRAY_4', 'arrays', 'feed_providers_ARRAY_4', 'script', '2020-11-12 08:11:37');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Homeway', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'feed_providers_ARRAY_5', 'arrays', 'feed_providers_ARRAY_5', 'script', '2020-11-12 08:11:47');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tripadvisor', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'feed_providers_ARRAY_6', 'arrays', 'feed_providers_ARRAY_6', 'script', '2020-11-12 08:11:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking.com', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_feed_url_empty', 'backend', 'rpbc_feed_url_empty', 'script', '2020-11-12 08:29:40');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The feed URL is empty.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuSchedule', 'backend', 'Menu / Schedule', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Schedule', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuReservationsList', 'backend', 'Menu / Reservations List', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Reservations List', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoScheduleTitle', 'backend', 'Info / Schedule title', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Schedule', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoScheduleDesc', 'backend', 'Info / Schedule desc', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'You can see below the schedule of all calendars.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'tabDetails', 'backend', 'Tab / Details', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Details', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'tabClient', 'backend', 'Tab / Client', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Client', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPriceDetailsDesc', 'backend', 'Info / Price details', 'script', '2015-03-20 11:37:44');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Below is price details or reservation. You can also add extras and/or apply promo code.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'script_online_payment_gateway', 'backend', 'Label / Online payments', 'script', '2020-11-09 14:41:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Online payments', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'script_offline_payment', 'backend', 'Label / Offline payments', 'script', '2020-11-09 14:41:46');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Offline payments', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dashboard_reservations_empty', 'backend', 'Label / No reservations found.', 'script', '2020-11-09 14:41:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'No reservations found.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPaymentMade', 'backend', 'Label / Payment Made', 'script', '2020-11-09 14:41:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Made', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationPaymentDue', 'backend', 'Label / Payment Due', 'script', '2020-11-09 14:41:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Due', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_email_confirmation', 'backend', 'Label / Email confirmation', 'script', '2020-11-13 01:55:07');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email confirmation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_email_cancellation', 'backend', 'Label / Email cancellation', 'script', '2020-11-13 01:55:19');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email cancellation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblEmailNotificationNotSet', 'backend', 'Label / Email notification is not set.', 'script', '2020-11-13 03:23:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email notification is not set.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblEmailCancellationNotSet', 'backend', 'Label / Email cancellation is not set.', 'script', '2020-11-13 03:48:40');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email cancellation is not set.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblSubject', 'backend', 'Label / Subject', 'script', '2020-11-13 01:55:07');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Subject', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblMessage', 'backend', 'Label / Message', 'script', '2020-11-13 01:55:19');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Message', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoPreviewTitle', 'backend', 'Infobox / Preview front end', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview front end', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoPreviewDesc', 'backend', 'Infobox / Preview front end', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Here is how the Front-End look like.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'script_change_labels', 'backend', 'Label / Change Labels', 'script', '2020-08-13 11:15:50');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Change Labels', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'script_preview_your_website', 'backend', 'Label / Preview your website', 'script', '2020-08-13 11:19:08');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Open in new window', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'script_install_your_website', 'backend', 'Label / Install your website', 'script', '2020-08-13 11:19:33');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install your website', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnPreview', 'backend', 'Button / Preview', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoInstallCodeTitle', 'backend', 'Info / Install code title', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install code', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoInstallCodeBody', 'backend', 'Info / Install code body', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy the code below and paste it on your web page where you want the calendar to appear.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyPaymentsInfo', 'backend', 'Label / Copy payments', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set custom payment options for this calendar. [STAG]Copy payment options from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyPaymentsTitle', 'backend', 'Label / Copy payments title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy custom payment options another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'copy_options_msg_ARRAY_1', 'arrays', 'copy_options_msg_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Missing parameters', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'copy_options_msg_ARRAY_2', 'arrays', 'copy_options_msg_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your selected calendar is using prices based on %s. Are you sure you want to copy prices from this calendar?', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pj_field_negative_number_err', 'backend', 'Label / Please enter a value greater than or equal to 0.', 'script', '2020-08-13 11:19:33');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Please enter a value greater than or equal to 0.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_ip_address_blocked', 'frontend', 'front_ip_address_blocked', 'script', '2020-10-21 08:17:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Your IP address has been blocked.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_v_captcha', 'frontend', 'Validate / Captcha', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Capcha is required', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_v_captcha_match', 'frontend', 'Validate / Captcha is wrong', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Capcha is wrong', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_cancel_title', 'frontend', 'Cancel / Reservation cancellation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation cancellation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_today', 'backend', 'Label / today', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_this_month', 'backend', 'Label / this month', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'this month', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_new_reservations', 'backend', 'Label / New Reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'New Reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_total_reservations', 'backend', 'Label / Total Reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total Reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_you_received_bookings', 'backend', 'Dash / You received xx reservations', 'script', '2020-08-13 15:32:49');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You received %s reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_you_received_booking', 'backend', 'Dash / You received xx reservation', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You received %s reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_view_all', 'backend', 'Dash / View All', 'script', '2020-08-13 15:35:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'View All', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_reservations_arriving_today', 'backend', 'Dash / Reservations Arriving Today', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations Arriving Today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_you_have_bookings_arriving_today', 'backend', 'Dash / You have xx reservations arriving today', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You have %s reservations arriving today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_you_have_booking_arriving_today', 'backend', 'Dash / You have xx reservation arriving today', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You have %s reservation arriving today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_reservations_leaving_today', 'backend', 'Dash / Reservations Leaving Today', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations Leaving Today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_you_have_bookings_leaving_today', 'backend', 'Dash / You have xx reservations leaving today', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You have %s reservations leaving today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'dash_you_have_booking_leaving_today', 'backend', 'Dash / You have xx reservation leaving today', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You have %s reservation leaving today', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationClient', 'backend', 'Label / Client', 'script', '2020-08-13 15:35:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Client', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationDates', 'backend', 'Label / Dates', 'script', '2020-08-13 15:35:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dates', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationTotalPrice', 'backend', 'Dash / Total Price', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Total Price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblRefId', 'backend', 'Label / Ref ID', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Ref ID', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblLatestReservation', 'backend', 'Label / Latest Reservation', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Latest Reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'label_on', 'backend', 'Label / on', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'on', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuPrices', 'backend', 'Menu / Prices', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Prices', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuIcalFeeds', 'backend', 'Menu / iCal feeds', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'iCal feeds', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuGeneralSettings', 'backend', 'Menu / General Settings', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'General Settings', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuBookingOptions', 'backend', 'Menu / Booking Options', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Options', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuEmailNotifications', 'backend', 'Menu / Email Notifications', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email Notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuExport', 'backend', 'Menu / Export', 'script', '2020-08-13 15:33:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_0', 'arrays', 'short_days_ARRAY_0', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Su', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_1', 'arrays', 'short_days_ARRAY_1', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Mo', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_2', 'arrays', 'short_days_ARRAY_2', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Tu', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_3', 'arrays', 'short_days_ARRAY_3', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'We', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_4', 'arrays', 'short_days_ARRAY_4', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Th', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_5', 'arrays', 'short_days_ARRAY_5', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Fr', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_days_ARRAY_6', 'arrays', 'short_days_ARRAY_6', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sa', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_1', 'arrays', 'short_months_ARRAY_1', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Jan', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_10', 'arrays', 'short_months_ARRAY_10', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Oct', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_11', 'arrays', 'short_months_ARRAY_11', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Nov', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_12', 'arrays', 'short_months_ARRAY_12', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dec', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_2', 'arrays', 'short_months_ARRAY_2', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Feb', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_3', 'arrays', 'short_months_ARRAY_3', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Mar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_4', 'arrays', 'short_months_ARRAY_4', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Apr', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_5', 'arrays', 'short_months_ARRAY_5', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'May', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_6', 'arrays', 'short_months_ARRAY_6', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Jun', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_7', 'arrays', 'short_months_ARRAY_7', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Jul', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_8', 'arrays', 'short_months_ARRAY_8', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Aug', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'short_months_ARRAY_9', 'arrays', 'short_months_ARRAY_9', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sep', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOwner', 'backend', 'Label / Owner', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'accept_booking_types_ARRAY_reservations', 'arrays', 'accept_booking_types_ARRAY_reservations', 'script', '2020-11-06 05:02:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'accept_booking_types_ARRAY_availability', 'arrays', 'accept_booking_types_ARRAY_availability', 'script', '2020-11-06 05:02:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Availability', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'property_b_statuses_ARRAY_confirmed', 'arrays', 'property_b_statuses_ARRAY_confirmed', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Confirmed', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'property_b_statuses_ARRAY_pending', 'arrays', 'property_b_statuses_ARRAY_pending', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Pending', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'property_b_statuses_ARRAY_cancelled', 'arrays', 'property_b_statuses_ARRAY_cancelled', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancelled', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'property_price_based_on_ARRAY_days', 'arrays', 'property_price_based_on_ARRAY_days', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Days', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'property_price_based_on_ARRAY_nights', 'arrays', 'property_price_based_on_ARRAY_nights', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Nights', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'property_price_plugin_ARRAY_price', 'arrays', 'property_price_plugin_ARRAY_price', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Day/Night', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'property_price_plugin_ARRAY_period', 'arrays', 'property_price_plugin_ARRAY_period', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Periods', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'script_offline_payment_methods', 'backend', 'Label / Offline Payment Methods', 'script', '2020-11-06 08:02:34');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Offline Payment Methods', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'copyGeneralSettingsInfo', 'backend', 'Label / Copy general settings', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set general settings for this calendar. [STAG]Copy general settings from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyGeneralSettingsTitle', 'backend', 'Label / Copy general settings title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy general settings from another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'copyBookingOptionsInfo', 'backend', 'Label / Copy booking options', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Set custom booking options for this calendar. [STAG]Copy booking options from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyBookingOptionsTitle', 'backend', 'Label / Copy booking options title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy booking options from another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyTermsInfo', 'backend', 'Label / Copy terms', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Enter your booking terms and conditions. You can also add a link to an external web page. [STAG]Copy booking terms from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyTermsTitle', 'backend', 'Label / Copy terms title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy terms from another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionsTermsURLDesc', 'backend', 'Label / Booking terms URL desc', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Enter booking terms URL', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblOptionsTermsContentDesc', 'backend', 'Label / Booking terms Content desc', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Enter booking terms content', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblCopyFrom', 'backend', 'Label / Copy from', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy from', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnClose', 'backend', 'Button / Close', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Close', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyEmailNotificationsInfo', 'backend', 'Label / Copy email notifications', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Below you can set email templates that will be sent to client and admin. [STAG]Copy email notifications from another calendar.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyEmailNotificationsTitle', 'backend', 'Label / Copy email notifications title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy email notifications another calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_message', 'backend', 'Label / Message', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Message', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblNoCalendarAssignedMsg', 'backend', 'Label / You are not assigned to any calendar, please contact the administrator', 'script', '2020-11-17 10:50:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You are not assigned to any calendar, please contact the administrator.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoReservationsTitle', 'backend', 'Infobox / List of reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'List of reservations', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoReservationsDesc', 'backend', 'Infobox / List of reservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'You can find below the list of reservations made on the system. If you want to add new reservation, click on the button "+ Add reservation".', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoAddReservationTitle', 'backend', 'Infobox / Add reservation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Add reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoAddReservationDesc', 'backend', 'Infobox / Add reservation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Fill in the form below and click "Save" button to add new reservation.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnAdvancedSearch', 'backend', 'Button / Advanced search', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Advanced search', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblFilterDate', 'backend', 'Label / Date', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Date', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblFilterAmount', 'backend', 'Label / Amount', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Amount', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblFilterFrom', 'backend', 'Label / From', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'From', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblFilterTo', 'backend', 'Label / To', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'To', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationDateFromTo', 'backend', 'Label / Date from/to', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Date from/to', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationNights', 'backend', 'Label / Nights', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Nights', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationNameEmail', 'backend', 'Label / Name/Email', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Name/Email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationCancel', 'backend', 'Label / Send Cancellation Email', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send cancellation email', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoUpdatePropertyTitle', 'backend', 'Infobox / Edit calendar', 'script', '2020-11-02 07:38:14');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Edit "%s" calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoUpdatePropertyDesc', 'backend', 'Infobox / Edit calendar', 'script', '2020-11-02 07:39:12');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'You can make any changes on the form below to update calendar information.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'rpbc_duplicate_ref_id', 'backend', 'Calendar / RefID', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Calendar with such ID exists.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_for_1_day', 'frontend', 'Label / for 1 day', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'for 1 day', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_for_1_nights', 'frontend', 'Label / for 1 night', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'for 1 night', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_for_days', 'frontend', 'Label / for days', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'for {DAYS} days', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_for_nights', 'frontend', 'Label / for nights', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'for {NIGHTS} nights', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_from_total_price', 'frontend', 'Label / from total price', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'from total price', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'front_start_over', 'frontend', 'Label / Start over', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Start over', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationFromTo', 'backend', 'Label / From/To', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'From/To', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblReservationID', 'backend', 'Options / Reservation ID', 'script', '2020-12-14 07:04:00');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation ID', 'script');


INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_owner_sms_confirmation', 'arrays', 'notifications_ARRAY_owner_sms_confirmation', 'plugin', '2020-08-03 19:43:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send booking confirmation SMS', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_owner_sms_payment', 'arrays', 'notifications_ARRAY_owner_sms_payment', 'plugin', '2020-08-03 19:43:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send payment confirmation SMS', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_ARRAY_owner_sms_cancel', 'arrays', 'notifications_ARRAY_owner_sms_cancel', 'plugin', '2020-08-03 19:43:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Send booking cancel SMS', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_owner_sms_confirmation', 'arrays', 'notifications_titles_ARRAY_owner_sms_confirmation', 'plugin', '2020-08-03 20:04:56');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking Confirmation SMS sent to Owner', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_owner_sms_confirmation', 'arrays', 'notifications_subtitles_ARRAY_owner_sms_confirmation', 'plugin', '2020-08-03 20:05:27');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to owner when a booking made.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_owner_sms_payment', 'arrays', 'notifications_titles_ARRAY_owner_sms_payment', 'plugin', '2020-08-03 20:05:52');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment Confirmation SMS sent to Owner', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_owner_sms_payment', 'arrays', 'notifications_subtitles_ARRAY_owner_sms_payment', 'plugin', '2020-08-03 20:06:23');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to owner when the payment made for new booking.', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_titles_ARRAY_owner_sms_cancel', 'arrays', 'notifications_titles_ARRAY_owner_sms_cancel', 'plugin', '2020-08-03 20:06:54');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservation cancelled SMS sent to Owner', 'plugin');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'notifications_subtitles_ARRAY_owner_sms_cancel', 'arrays', 'notifications_subtitles_ARRAY_owner_sms_cancel', 'plugin', '2020-08-03 20:07:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'This SMS is sent to the owner when the client cancels a reservation.', 'plugin');


INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AOW01', 'arrays', 'error_titles_ARRAY_AOW01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owner updated!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AOW01', 'arrays', 'error_bodies_ARRAY_AOW01', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'All the changes made to this owner have been saved. ', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AOW03', 'arrays', 'error_titles_ARRAY_AOW03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owner added!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AOW03', 'arrays', 'error_bodies_ARRAY_AOW03', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The owner has been added into the system.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AOW04', 'arrays', 'error_titles_ARRAY_AOW04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owner not addeD!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AOW04', 'arrays', 'error_bodies_ARRAY_AOW04', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The owner could not be added into the system successfully.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_titles_ARRAY_AOW08', 'arrays', 'error_titles_ARRAY_AOW08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owner not found!', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'error_bodies_ARRAY_AOW08', 'arrays', 'error_bodies_ARRAY_AOW08', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'The owner you are looking for is missing. Please try again.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infobOwnersTitle', 'backend', 'Inbox / Owners', 'script', '2020-11-06 09:47:31');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owners', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infobOwnersDesc', 'backend', 'Inbox / Owners', 'script', '2020-11-06 09:48:22');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add and manage owner. Set users as ''Inactive'' if you wish to temporarily restrict their access to the system without deleting them.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'btnAddOwner', 'backend', 'Button / Add owner', 'script', '2020-11-06 09:49:24');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoAddOwnerTitle', 'backend', 'Inbox / Add owner', 'script', '2020-11-06 10:11:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoAddOwnerDesc', 'backend', 'Inbox / Add owner', 'script', '2020-11-06 10:11:40');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Fill out the fields and click on ''Save'' button to add new owner to the system.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoUpdateOwnerTitle', 'backend', 'Inbox / Update owner', 'script', '2020-11-06 10:19:54');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'infoUpdateOwnerDesc', 'backend', 'Inbox / Add owner', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Review and update owner information.', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblEmailNotifications', 'backend', 'Label / Email notifications', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'lblSmsNotifications', 'backend', 'Label / Sms notifications', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Sms notifications', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_email_notifictions_ARRAY_all_email_confirmation', 'arrays', '_owner_email_notifictions_ARRAY_all_email_confirmation', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking confirmation - all calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_email_notifictions_ARRAY_all_email_payment', 'arrays', '_owner_email_notifictions_ARRAY_all_email_payment', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment confirmation - all calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_email_notifictions_ARRAY_all_email_cancel', 'arrays', '_owner_email_notifictions_ARRAY_all_email_cancel', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancellation confirmation - all calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_email_notifictions_ARRAY_mycal_email_confirmation', 'arrays', '_owner_email_notifictions_ARRAY_mycal_email_confirmation', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking confirmation - my calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_email_notifictions_ARRAY_mycal_email_payment', 'arrays', '_owner_email_notifictions_ARRAY_mycal_email_payment', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment confirmation - my calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_email_notifictions_ARRAY_mycal_email_cancel', 'arrays', '_owner_email_notifictions_ARRAY_mycal_email_cancel', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancellation confirmation - my calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_sms_notifictions_ARRAY_all_sms_confirmation', 'arrays', '_owner_sms_notifictions_ARRAY_all_sms_confirmation', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking confirmation - all calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_sms_notifictions_ARRAY_all_sms_payment', 'arrays', '_owner_sms_notifictions_ARRAY_all_sms_payment', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment confirmation - all calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_sms_notifictions_ARRAY_all_sms_cancel', 'arrays', '_owner_sms_notifictions_ARRAY_all_sms_cancel', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancellation confirmation - all calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_sms_notifictions_ARRAY_mycal_sms_confirmation', 'arrays', '_owner_sms_notifictions_ARRAY_mycal_sms_confirmation', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Booking confirmation - my calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_sms_notifictions_ARRAY_mycal_sms_payment', 'arrays', '_owner_sms_notifictions_ARRAY_mycal_sms_payment', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Payment confirmation - my calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, '_owner_sms_notifictions_ARRAY_mycal_sms_cancel', 'arrays', '_owner_sms_notifictions_ARRAY_mycal_sms_cancel', 'script', '2020-11-06 10:20:35');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Cancellation confirmation - my calendars', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'menuOwners', 'backend', 'Menu / Owners', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owners', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_seder_email_same_as_username', 'backend', 'Label / Same as SMTP Username', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Same as SMTP Username', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_secure', 'backend', 'Label / SMTP Secure', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Secure', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_smtp_auth', 'backend', 'Label / SMTP Auth Type', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'SMTP Auth Type', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_sender_email', 'backend', 'Label / Email address ("From" header)', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Email address ("From" header)', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'opt_o_sender_name', 'backend', 'Label / Name ("From" header)', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Name ("From" header)', 'script');


INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyBookingFormInfo', 'backend', 'Label / Copy booking form', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Choose the fields that should be available on the booking form. [STAG]Copy booking form options from another property.[ETAG]', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'modalCopyBookingFormTitle', 'backend', 'Label / Copy booking form title', 'script', '2020-10-30 08:30:59');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Copy booking form another property', 'script');



INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdmin_pjActionIndex');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdmin_pjActionIndex', 'backend', 'Label / Dashboard Menu', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Dashboard Menu', 'script');


INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminCalendars');
SET @level_1_id := (SELECT LAST_INSERT_ID());

	INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminCalendars_pjActionIndex');
	SET @level_2_id := (SELECT LAST_INSERT_ID());
	
		INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminCalendars_pjActionCreate');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminCalendars_pjActionUpdate');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminCalendars_pjActionDeleteCalendar');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminCalendars_pjActionDeleteCalendarBulk');
	    

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminCalendars', 'backend', 'pjAdminCalendars', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendars menu', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminCalendars_pjActionIndex', 'backend', 'pjAdminCalendars_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Calendars list', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminCalendars_pjActionCreate', 'backend', 'pjAdminCalendars_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminCalendars_pjActionUpdate', 'backend', 'pjAdminCalendars_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminCalendars_pjActionDeleteCalendar', 'backend', 'pjAdminCalendars_pjActionDeleteCalendar', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single calendar', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminCalendars_pjActionDeleteCalendarBulk', 'backend', 'pjAdminCalendars_pjActionDeleteCalendarBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple calendars', 'script');
	    

INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminReservations');
SET @level_1_id := (SELECT LAST_INSERT_ID());
	
	INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminReservations_pjActionSchedule');
	SET @level_2_id := (SELECT LAST_INSERT_ID());
	
	INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminReservations_pjActionIndex');
	SET @level_2_id := (SELECT LAST_INSERT_ID());
	
		INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminReservations_pjActionCreate');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminReservations_pjActionUpdate');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminReservations_pjActionDeleteReservation');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminReservations_pjActionDeleteReservationBulk');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminReservations_pjActionExportReservation');
	    

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminReservations', 'backend', 'pjAdminReservations', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations menu', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminReservations_pjActionSchedule', 'backend', 'pjAdminReservations_pjActionSchedule', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Schedule', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminReservations_pjActionIndex', 'backend', 'pjAdminReservations_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Reservations list', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminReservations_pjActionCreate', 'backend', 'pjAdminReservations_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminReservations_pjActionUpdate', 'backend', 'pjAdminReservations_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminReservations_pjActionDeleteReservation', 'backend', 'pjAdminReservations_pjActionDeleteReservation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single reservation', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminReservations_pjActionDeleteReservationBulk', 'backend', 'pjAdminReservations_pjActionDeleteReservationBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple reservations', 'script');
	    
INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminReservations_pjActionExportReservation', 'backend', 'pjAdminReservations_pjActionExportReservation', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Export reservations', 'script');
	

INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminOptions_pjActionNotifications');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionNotifications', 'backend', 'Label / Notifications Menu', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Notifications Menu', 'script');


INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminExtras');
SET @level_1_id := (SELECT LAST_INSERT_ID());
	
	INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminExtras_pjActionIndex');
	SET @level_2_id := (SELECT LAST_INSERT_ID());
	
		INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminExtras_pjActionCreate');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminExtras_pjActionUpdate');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminExtras_pjActionDeleteExtra');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminExtras_pjActionDeleteExtraBulk');
	    
	    

INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminOptions_pjActionPreview');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionPreview', 'backend', 'pjAdminOptions_pjActionPreview', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Preview', 'script');


INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminOptions_pjActionInstall');
	    
INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOptions_pjActionInstall', 'backend', 'pjAdminOptions_pjActionInstall', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Install', 'script');



INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOwners', 'backend', 'pjAdminOwners', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owners menu', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOwners_pjActionIndex', 'backend', 'pjAdminOwners_pjActionIndex', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Owners list', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOwners_pjActionCreate', 'backend', 'pjAdminOwners_pjActionCreate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Add owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOwners_pjActionUpdate', 'backend', 'pjAdminOwners_pjActionUpdate', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Update owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOwners_pjActionDeleteOwner', 'backend', 'pjAdminOwners_pjActionDeleteOwner', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete single owner', 'script');

INSERT INTO `abcalendar_plugin_base_fields` VALUES (NULL, 'pjAdminOwners_pjActionDeleteOwnerBulk', 'backend', 'pjAdminOwners_pjActionDeleteOwnerBulk', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `abcalendar_plugin_base_multi_lang` VALUES (NULL, @id, 'pjBaseField', '::LOCALE::', 'title', 'Delete multiple owners', 'script');


INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, NULL, 'pjAdminOwners');
SET @level_1_id := (SELECT LAST_INSERT_ID());

	INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_1_id, 'pjAdminOwners_pjActionIndex');
	SET @level_2_id := (SELECT LAST_INSERT_ID());
	
		INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOwners_pjActionCreate');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOwners_pjActionUpdate');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOwners_pjActionDeleteOwner');
	    INSERT INTO `abcalendar_plugin_auth_permissions` (`id`, `parent_id`, `key`) VALUES (NULL, @level_2_id, 'pjAdminOwners_pjActionDeleteOwnerBulk');


