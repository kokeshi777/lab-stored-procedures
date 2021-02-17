#question 1

drop procedure if exists customer_info;

delimiter //
create procedure customer_info ()
begin
    select first_name, last_name, email 
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = "Action"
    group by first_name, last_name, email;
    
end;
//
delimiter ;    

call customer_info();

#Question 2

drop procedure if exists customer_info_var;
delimiter //
create procedure customer_info_var (in genre char(20))
begin
    select first_name, last_name, email 
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name COLLATE utf8_general_ci = genre

    group by first_name, last_name, email;
    
end;
//
delimiter ;    

call customer_info_var("action");

#Question 3

drop procedure if exists movie_count;
 delimiter //
  create procedure movie_count (in param1 int)
  begin
  
select name, number_films from (select count(f.title) as number_films, c.name from film as f
join film_category as fc using (film_id)
join category as c using (category_id)
group by c.name) as sub1
where number_films > param1;

end;

//
delimiter ;

call movie_count(65);