CREATE TABLE `data_collection`.`answer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(1000) CHARACTER SET 'utf8mb4' NOT NULL,
  `question_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_answer_1`FOREIGN KEY (`question_id`) REFERENCES `data_collection`.`question` (`id`)
);

CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) CHARACTER SET 'utf8mb4' NOT NULL,
  PRIMARY KEY (`id`)
) ;
