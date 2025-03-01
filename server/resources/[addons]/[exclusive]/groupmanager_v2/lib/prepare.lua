local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRP.prepare('groupmanager/memberscreate', [[CREATE TABLE IF NOT EXISTS `groupmanager_members` (
  `id` int(50) NOT NULL DEFAULT uuid(),
  `name` varchar(255) DEFAULT NULL,
  `org` varchar(255) DEFAULT NULL,
  `cargo` varchar(255) DEFAULT NULL,
  `lastAt` varchar(255) DEFAULT NULL,
  `createdAt` int(11) NOT NULL DEFAULT unix_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;]])

vRP.prepare('groupmanager/groups', [[CREATE TABLE IF NOT EXISTS `groupmanager_groups` (
  `name` varchar(255) DEFAULT NULL,
  `bank` int(50) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `max_members` int(50) DEFAULT NULL,
  `createdAt` int(11) NOT NULL DEFAULT unix_timestamp(),
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;]])

vRP.prepare('groupmanager/chest_logs', [[CREATE TABLE IF NOT EXISTS `groupmanager_chest_logs` (
  `groups` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `createdAt` int(11) NOT NULL DEFAULT unix_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;]])

vRP.prepare('groupmanager/chest', [[CREATE TABLE IF NOT EXISTS `groupmanager_chest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT 0,
  `perm` varchar(50) NOT NULL,
  `cds` varchar(255) DEFAULT NULL,
  `cds2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;]])

vRP.prepare('groupmanager/bank', [[CREATE TABLE IF NOT EXISTS `groupmanager_bank` (
  `groups` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `quantity` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `createdAt` int(11) NOT NULL DEFAULT unix_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;]])

Citizen.CreateThread(function()
  vRP.execute('groupmanager/memberscreate')
  vRP.execute('groupmanager/groups')
  vRP.execute('groupmanager/chest')
  vRP.execute('groupmanager/chest_logs')
  vRP.execute('groupmanager/bank')
end)