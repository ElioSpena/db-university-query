/* 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia */
SELECT `students`.`name` AS `student_name`, `students`.`surname` AS `student_surname`, `students`.`id` AS `student_id`,`degrees`.`name` AS `degree_type`
FROM `students`
INNER JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
HAVING `degree_type` = 'Corso di Laurea in Economia'

/* 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze */
SELECT `courses`.`name` AS `course_name`, `degrees`.`level` AS `level_degree`, `departments`.`name` AS `department_name`
FROM `degrees`
INNER JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
INNER JOIN `courses`
ON `courses`.`degree_id` = `degrees`.`id`
HAVING `level_degree`= 'magistrale'
AND `department_name` = 'Dipartimento di Neuroscienze'

/* 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
relativo dipartimento, in ordine alfabetico per cognome e nome*/
SELECT `students`.`name` AS `student_name`, `students`.`surname` AS `student_surname`, `degrees`.`name` AS `degree_name`, `departments`.`name` AS `department_name`
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
INNER JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
ORDER BY `student_surname`, `student_name`

/* 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti */
SELECT `degrees`.`name` AS `degree_name`, `courses`.`name` AS `course_name`, `teachers`.`name` AS `teacher_name`, `teachers`.`surname` AS `teacher_surname`
FROM `courses`
INNER JOIN `degrees`
ON `courses`.`degree_id` = `degrees`.`id`
INNER JOIN `course_teacher`
ON `course_teacher`.`course_id` = `courses`.`id`
INNER JOIN `teachers`
ON `course_teacher`.`teacher_id` = `teachers`.`id`
ORDER BY `degree_name`

/* 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54) */
SELECT DISTINCT `teachers`.`name`, `teachers`.`surname`, `departments`.`name` AS `department_name`
FROM `teachers`
INNER JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
INNER JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
HAVING `department_name` = 'Dipartimento di Matematica'

/* 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
superare ciascuno dei suoi esami */
SELECT `students`.`id` AS `student_id`,`students`.`name`,`students`.`surname`, `courses`.`id` AS `course_id`, `courses`.`name` AS `course_name`, COUNT(`exam_student`.`vote`) AS `tries`, MAX(`exam_student`.`vote`) AS `voto_max`
FROM `students`
INNER JOIN `exam_student`
ON `exam_student`.`student_id` = `students`.`id`
INNER JOIN `exams`
ON `exam_student`.`exam_id` = `exams`.`id`
INNER JOIN `courses`
ON `exams`.`course_id` = `courses`.`id`
GROUP BY `students`.`id`, `courses`.`id`
HAVING `voto_max` >= 18
ORDER BY `student_id`, `course_id`
