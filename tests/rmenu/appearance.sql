-- SQL schema for persisting RageUI appearance outfits with qb-core
CREATE TABLE IF NOT EXISTS `rageui_outfits` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(64) NOT NULL,
    `slot` INT NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `saved_at` INT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `identifier_slot` (`identifier`, `slot`)
);
