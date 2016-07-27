select u.id, c.stripe_customer_id, upp.stripe_card_id
from users u
	join user_payment_profiles upp on
		u.id = upp.user_id
	join customers c on
		u.id = c.user_id
where u.is_abuse like true -- or `false`
and stripe_customer_id is not null
and stripe_card_id is not null
group by c.stripe_customer_id
limit 36000;
