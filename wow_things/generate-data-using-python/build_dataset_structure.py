# Let's re-run with safer time slot generation and correct 23:30 duplication logic.
import pandas as pd
import numpy as np
from datetime import datetime, timedelta, date, time
import random

rng = np.random.default_rng(42)
random.seed(42)

TODAY = datetime(2025, 8, 7, 10, 31)

N_CUSTOMERS = 500
N_THEATRES = 25
N_MOVIES = 60
N_PAYMENTS = 20
N_RESERVATIONS = 12000
DATE_START = datetime(2024, 1, 1)
DATE_END = datetime(2025, 12, 31)

CITIES = [
    ("Hyderabad", "TS", "IN"), ("Bengaluru", "KA", "IN"), ("Mumbai", "MH", "IN"), ("Pune", "MH", "IN"),
    ("Chennai", "TN", "IN"), ("New Delhi", "DL", "IN"), ("Kolkata", "WB", "IN"), ("Ahmedabad", "GJ", "IN"),
    ("Kochi", "KL", "IN"), ("Jaipur", "RJ", "IN"), ("Surat", "GJ", "IN"), ("Visakhapatnam", "AP", "IN"),
    ("Lucknow", "UP", "IN"), ("Nagpur", "MH", "IN"), ("Indore", "MP", "IN")
]
FIRST_NAMES_M = ["Aarav", "Vihaan", "Arjun", "Rohit", "Kunal", "Suresh", "Rahul", "Vikram", "Karthik", "Rajat"]
FIRST_NAMES_F = ["Aanya", "Diya", "Isha", "Meera", "Neha", "Ananya", "Priya", "Riya", "Sneha", "Pooja"]
LAST_NAMES = ["Reddy", "Sharma", "Patel", "Gupta", "Singh", "Khan", "Iyer", "Das", "Verma", "Kulkarni"]

genres = ["Action", "Drama", "Comedy", "Thriller", "Romance", "Horror", "Sci-Fi", "Animation", "Family", "Adventure"]
languages = ["Hindi", "English", "Telugu", "Tamil", "Kannada", "Malayalam"]
certs = ["U", "UA", "A", "PG-13"]
prod_cos = ["Sunrise Studios", "BluePeak Films", "Riverstone Pictures", "Golden Reel", "Starlight Media", "Nova Cinema"]
operators = ["PVR", "INOX", "Cinepolis", "AMC", "Cinemark", "Carnival Cinemas"]
formats = ["IMAX", "4DX", "3D", "Dolby Atmos", "None"]
seat_types = ["Regular", "Premium", "Recliner", "IMAX"]
booking_channels = ["Web", "Android", "iOS"]
payment_methods = ["Credit Card", "Debit Card", "UPI", "NetBanking", "Wallet", "PayPal"]
providers = ["Visa", "Mastercard", "RuPay", "HDFC", "SBI", "ICICI", "Axis", "Paytm", "PhonePe", "Google Pay", "PayPal"]
gateways = ["Razorpay", "PayU", "CCAvenue", "Stripe", "Braintree"]
risk_bands = ["Low", "Medium", "High"]
loyalty_tiers = ["Bronze", "Silver", "Gold", "Platinum"]
age_bands = ["18-24", "25-34", "35-44", "45-54", "55+"]

# Customers
genders = ["M", "F"]
customer_rows = []
for cid in range(1, N_CUSTOMERS + 1):
    gender = rng.choice(genders, p=[0.55, 0.45])
    fn = random.choice(FIRST_NAMES_M if gender == "M" else FIRST_NAMES_F)
    ln = random.choice(LAST_NAMES)
    city, state, country = random.choice(CITIES)
    email = f"{fn.lower()}.{ln.lower()}{cid}@example.com"
    phone = f"9{rng.integers(10**9, 10**10-1)}"
    tier = rng.choice(loyalty_tiers, p=[0.5, 0.3, 0.15, 0.05])
    signup = DATE_START + timedelta(days=int(rng.integers(0, (TODAY - DATE_START).days)))
    age_band = rng.choice(age_bands, p=[0.28, 0.34, 0.2, 0.12, 0.06])
    marketing_opt_in = rng.choice([True, False], p=[0.65, 0.35])
    customer_rows.append((cid, fn, ln, gender, email, phone, city, state, country, tier, signup.date(), age_band, marketing_opt_in))

dim_customers = pd.DataFrame(customer_rows, columns=[
    "customer_id", "first_name", "last_name", "gender", "email", "phone", "city", "state", "country",
    "loyalty_tier", "signup_date", "age_band", "marketing_opt_in"
])

# Theatres
theatre_rows = []
for tid in range(1, N_THEATRES + 1):
    city, state, country = random.choice(CITIES)
    operator = random.choice(operators)
    name = f"{operator} {city} #{tid:02d}"
    num_screens = int(rng.integers(3, 12))
    avg_seats = int(rng.integers(90, 260))
    total_seats = num_screens * avg_seats
    premium = ", ".join(sorted(set(rng.choice(formats, size=int(rng.integers(1, 3))).tolist())))
    theatre_rows.append((tid, name, operator, city, state, country, num_screens, total_seats, premium))

dim_theatres = pd.DataFrame(theatre_rows, columns=[
    "theatre_id", "theatre_name", "operator", "city", "state", "country", "num_screens", "total_seats", "premium_formats"
])

# Movies
adj = ["Silent", "Crimson", "Hidden", "Galactic", "Eternal", "Broken", "Laughing", "Midnight", "Golden", "Neon", "Blazing", "Shadow"]
nouns = ["Echoes", "Skies", "Promise", "Horizon", "Quest", "Storm", "Secret", "Reckoning", "Odyssey", "Riddle", "Pulse", "Mirage"]
movie_titles = set()
while len(movie_titles) < N_MOVIES:
    movie_titles.add(f"{random.choice(adj)} {random.choice(nouns)}")
movie_titles = list(movie_titles)

movie_rows = []
for mid in range(1, N_MOVIES + 1):
    title = movie_titles[mid-1]
    genre = random.choice(genres)
    language = random.choice(languages)
    runtime = int(rng.integers(90, 180))
    release = DATE_START + timedelta(days=int(rng.integers(0, (TODAY - DATE_START).days)))
    cert = random.choice(certs)
    prod = random.choice(prod_cos)
    is3d = rng.choice([True, False], p=[0.25, 0.75])
    movie_rows.append((mid, title, genre, language, runtime, release.date(), cert, prod, is3d))

dim_movies = pd.DataFrame(movie_rows, columns=[
    "movie_id", "title", "genre", "language", "runtime_min", "release_date", "rating_cert", "production_company", "is_3d"
])

# Payments
payment_rows = []
for pid in range(1, N_PAYMENTS + 1):
    method = random.choice(payment_methods)
    provider = random.choice(providers)
    gateway = random.choice(gateways)
    currency = "INR"
    supports_refund = True
    risk_band = random.choice(risk_bands)
    payment_rows.append((pid, method, provider, gateway, currency, supports_refund, risk_band))

dim_payments = pd.DataFrame(payment_rows, columns=[
    "payment_id", "payment_method", "provider", "gateway", "currency", "supports_refund", "risk_band"
])

# Time dimension: 30-minute slots from 09:00 to 23:30 inclusive
slot_times = []
for h in range(9, 24):
    slot_times.append(time(h, 0))
    slot_times.append(time(h, 30))
slot_times.append(time(23,30))  # ensure 23:30 exists
# Deduplicate while preserving order
seen_t = set()
slot_times_unique = []
for st in slot_times:
    if st not in seen_t:
        slot_times_unique.append(st)
        seen_t.add(st)

# Build dim_time
rows = []
current_date = DATE_START.date()
end_date = DATE_END.date()
while current_date <= end_date:
    for t in slot_times_unique:
        dt = datetime.combine(current_date, t)
        time_id = int(dt.strftime('%Y%m%d%H%M'))
        dow = dt.weekday()
        rows.append((time_id, dt.date(), dt.time().strftime('%H:%M'), dt.hour, dt.minute,
                     dt.strftime('%A'), dow+1, int(dow>=5), int(dt.strftime('%W')),
                     dt.month, (dt.month-1)//3 + 1, dt.year))
    current_date += timedelta(days=1)

dim_time = pd.DataFrame(rows, columns=[
    "time_id", "date", "time", "hour", "minute", "day_name", "day_of_week", "is_weekend",
    "week_of_year", "month", "quarter", "year"
])

# Pricing helpers
base_price_by_theatre = {int(tid): float(np.random.randint(150, 401)) for tid in dim_theatres.theatre_id}
seat_multiplier = {"Regular": 1.0, "Premium": 1.3, "Recliner": 1.6, "IMAX": 1.8}
hour_factor = {h: (1.25 if 18 <= h <= 22 else 1.1 if 14 <= h < 18 else 1.0) for h in range(0,24)}
langs_per_theatre = {}
for tid in dim_theatres.theatre_id:
    nlangs = int(np.random.randint(2, min(len(languages),5)+1))
    langs_per_theatre[int(tid)] = set(np.random.choice(languages, size=nlangs, replace=False))

movie_release_map = {int(row.movie_id): pd.to_datetime(row.release_date) for _, row in dim_movies.iterrows()}

def pick_show_time(movie_id):
    rel = movie_release_map[int(movie_id)]
    min_id = int(rel.strftime('%Y%m%d0000'))
    max_date = min(DATE_END, TODAY + timedelta(days=14))
    max_id = int(max_date.strftime('%Y%m%d2359'))
    eligible = dim_time[(dim_time.time_id >= min_id) & (dim_time.time_id <= max_id)]
    if eligible.empty:
        return int(dim_time.iloc[-1].time_id)
    probs = np.where((eligible['hour'] >= 18) & (eligible['hour'] <= 22), 1.8, 1.0)
    probs = probs / probs.sum()
    return int(np.random.choice(eligible['time_id'].values, p=probs))


def compute_pricing(theatre_id, hour, seat_type, seats):
    base = base_price_by_theatre[int(theatre_id)]
    unit = base * seat_multiplier[seat_type] * hour_factor.get(int(hour), 1.0)
    unit = round(unit / 5) * 5
    base_amount = unit * seats
    conv_fee = round((10 + 0.03 * base_amount), 2)
    discount = 0.0
    if np.random.random() < 0.25:
        discount = round(min(150.0, 0.1 * base_amount), 2)
    taxable = max(0.0, base_amount + conv_fee - discount)
    tax = round(0.18 * taxable, 2)
    gross = round(base_amount + conv_fee + tax, 2)
    total = round(max(0.0, gross - discount), 2)
    return unit, base_amount, conv_fee, tax, discount, gross, total

# Build fact
fact_rows = []
res_status_vals = ["Confirmed", "Cancelled"]
payment_status_vals = ["Success", "Failed", "Refunded"]

for rid in range(1, N_RESERVATIONS + 1):
    customer_id = int(np.random.randint(1, N_CUSTOMERS + 1))
    theatre_id = int(np.random.randint(1, N_THEATRES + 1))

    if np.random.random() < 0.7:
        allowed_langs = langs_per_theatre[int(theatre_id)]
        movies_subset = dim_movies[dim_movies['language'].isin(list(allowed_langs))]
        if movies_subset.empty:
            movie_id = int(np.random.randint(1, N_MOVIES + 1))
        else:
            movie_id = int(movies_subset.sample(1).iloc[0].movie_id)
    else:
        movie_id = int(np.random.randint(1, N_MOVIES + 1))

    show_time_id = pick_show_time(movie_id)
    show_dt_row = dim_time.loc[dim_time.time_id == show_time_id].iloc[0]
    show_dt = datetime.combine(pd.to_datetime(show_dt_row['date']).date(), datetime.strptime(show_dt_row['time'], '%H:%M').time())

    # Booking time before show, up to 30 days earlier
    book_earliest = show_dt - timedelta(days=30)
    book_earliest_id = int(max(int(book_earliest.strftime('%Y%m%d%H%M')), int(DATE_START.strftime('%Y%m%d0900'))))
    eligible_book = dim_time[(dim_time.time_id >= book_earliest_id) & (dim_time.time_id <= show_time_id)]
    if eligible_book.empty:
        booking_time_id = show_time_id
    else:
        probs = np.ones(len(eligible_book))
        recent_mask = eligible_book['time_id'] >= int((show_dt - timedelta(days=7)).strftime('%Y%m%d%H%M'))
        probs[recent_mask.values] = 2.0
        probs = probs / probs.sum()
        booking_time_id = int(np.random.choice(eligible_book['time_id'].values, p=probs))

    seat_type = np.random.choice(seat_types, p=[0.6, 0.2, 0.15, 0.05])
    seats = int(np.random.randint(1, 7))

    num_screens = int(dim_theatres.loc[dim_theatres.theatre_id == theatre_id, 'num_screens'].iloc[0])
    screen = int(np.random.randint(1, num_screens + 1))

    hour = int(show_dt_row['hour'])
    unit_price, base_amount, conv_fee, tax, discount, gross, total = compute_pricing(theatre_id, hour, seat_type, seats)

    res_status = np.random.choice(res_status_vals, p=[0.9, 0.1])
    if res_status == "Cancelled":
        pay_status = np.random.choice(payment_status_vals, p=[0.2, 0.1, 0.7])
    else:
        pay_status = np.random.choice(payment_status_vals, p=[0.9, 0.07, 0.03])

    payment_id = int(np.random.randint(1, N_PAYMENTS + 1))
    channel = np.random.choice(booking_channels, p=[0.5, 0.3, 0.2])

    promo_pool = ["", "WELCOME50", "MOVIE10", "FIRST100", "WEEKEND25", "FESTIVE150"]
    promo_weights = [0.7, 0.05, 0.08, 0.05, 0.07, 0.05]
    promo = np.random.choice(promo_pool, p=promo_weights)

    quoted_total = total
    realized_total = total if (pay_status == "Success" and res_status == "Confirmed") else 0.0

    fact_rows.append((
        rid, customer_id, theatre_id, movie_id, payment_id,
        booking_time_id, show_time_id, screen, seat_type, seats,
        round(unit_price,2), round(base_amount,2), round(conv_fee,2), round(tax,2), round(discount,2), round(quoted_total,2), round(realized_total,2),
        res_status, str(pay_status), channel, promo
    ))

fact = pd.DataFrame(fact_rows, columns=[
    "reservation_id", "customer_id", "theatre_id", "movie_id", "payment_id",
    "booking_time_id", "show_time_id", "theatre_screen", "seat_type", "seats_booked",
    "ticket_unit_price", "base_amount", "convenience_fee", "tax_amount", "discount_amount", "quoted_total_amount", "realized_total_amount",
    "reservation_status", "payment_status", "booking_channel", "promo_code"
])

# Save CSVs
paths = {
    'dim_customers': '/mnt/data/dim_customers.csv',
    'dim_theatres': '/mnt/data/dim_theatres.csv',
    'dim_movies': '/mnt/data/dim_movies.csv',
    'dim_payments': '/mnt/data/dim_payments.csv',
    'dim_time': '/mnt/data/dim_time.csv',
    'fact_online_movie_reservations': '/mnt/data/fact_online_movie_reservations.csv'
}

dim_customers.to_csv(paths['dim_customers'], index=False)
dim_theatres.to_csv(paths['dim_theatres'], index=False)
dim_movies.to_csv(paths['dim_movies'], index=False)
dim_payments.to_csv(paths['dim_payments'], index=False)
dim_time.to_csv(paths['dim_time'], index=False)
fact.to_csv(paths['fact_online_movie_reservations'], index=False)

preview = {
    'paths': paths,
    'counts': {
        'dim_customers': len(dim_customers),
        'dim_theatres': len(dim_theatres),
        'dim_movies': len(dim_movies),
        'dim_payments': len(dim_payments),
        'dim_time': len(dim_time),
        'fact_online_movie_reservations': len(fact),
    },
    'dim_customers_head': dim_customers.head(3).to_dict(orient='records'),
    'dim_theatres_head': dim_theatres.head(3).to_dict(orient='records'),
    'dim_movies_head': dim_movies.head(3).to_dict(orient='records'),
    'dim_payments_head': dim_payments.head(3).to_dict(orient='records'),
    'dim_time_head': dim_time.head(3).to_dict(orient='records'),
    'fact_head': fact.head(3).to_dict(orient='records')
}
