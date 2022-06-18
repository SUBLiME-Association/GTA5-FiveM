
CREATE TABLE IF NOT EXISTS `sublime_permissions` (
  `identifier` varchar(100) NOT NULL,
  `rank` int(2) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `sublime_bans` (
  `identifier` varchar(40) NOT NULL,
  `reason` longtext DEFAULT NULL,
  `expiration` varchar(50) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `sublime_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '**NIL**',
  `data` LONGTEXT NULL DEFAULT NULL,
  `type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
