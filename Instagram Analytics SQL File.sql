# A) Marketing Analysis:

	# 1. Loyal User Reward
	select id, username from users
	order by created_at asc
	limit 5;

	# 2. Inactive User Engagement
	select id, username from users
	where not id in(select distinct user_id from photos);

	# 3. Contest Winner Declaration
	select  a.user_id, c.username, a.image_url, b.photo_id, count(b.user_id) total_likes from photos a
	inner join likes b
	on a.id = b.photo_id
	inner join users c
	on a.user_id = c.id
	group by b.photo_id
	order by total_likes desc
	limit 1;

	# 4. Hashtag Research
	select a.tag_id, b.tag_name, count(b.tag_name) total from photo_tags a
	inner join tags b
	on a.tag_id = b.id
	group by a.tag_id
	order by total desc
	limit 5;

	#5. Ad Campaign Launch
	select  dayname(created_at) weekday, count(dayname(created_at)) count from users
	group by weekday
	order by count desc
	limit 1;

# B) Investor Metrics:

	# 1. User Engagement
	select (select count(*) from users) user_count, (select count(*) from photos) photo_count, ((select count(*) from photos)/(select count(*) from users)) avg;

	# 2. Bots & Fake Accounts
	select id, username from users
	where id in (
		select user_id from likes
		group by user_id
		having count(*) = (select count(*) from photos)
		);