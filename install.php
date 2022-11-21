<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_driveinfos()
{
    $commonObject = new ExtensionCommon;

    // Drop table first
    $commonObject -> sqlQuery("DROP TABLE `driveinfos`;");

    $commonObject -> sqlQuery("CREATE TABLE `driveinfos` (
                             `ID` INT(11) NOT NULL AUTO_INCREMENT,
                             `HARDWARE_ID` INT(11) NOT NULL,
                             `NAME` VARCHAR(255) DEFAULT NULL,
                             `DRIVELABEL` VARCHAR(255) DEFAULT NULL,
                             `DRIVETYPE` VARCHAR(255) DEFAULT NULL,
                             `DRIVELETTER` VARCHAR(255) DEFAULT NULL,
                             `FILESYSTEM` VARCHAR(255) DEFAULT NULL,
                             `CAPACITY` INTEGER(11) DEFAULT NULL,
                             `FREESPACE` INTEGER(11) DEFAULT NULL,
                             
                             PRIMARY KEY  (`ID`,`HARDWARE_ID`)
                             ) ENGINE=InnoDB ;");
}

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_driveinfos()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE `driveinfos`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_driveinfos()
{

}
