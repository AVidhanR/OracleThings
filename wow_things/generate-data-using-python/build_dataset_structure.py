import pandas as pd
import numpy as np
from datetime import datetime, timedelta, date, time
import random

rng = np.random.default_rng(42)
random.seed(42)

# -------------------- Config --------------------
TODAY = datetime(2025, 8, 7, 10, 31)  # align with user's current date/time

N_CUSTOMERS = 500
N_THEATRES = 25
N_MOVIES = 60
N_PAYMENTS = 20

# Reservation volume
N_RESERVATIONS = 12000

# Date ranges
DATE_START = datetime(2024, 1, 1)
DATE_END = datetime(2025, 12, 31)

# -------------------- Helper functions --------------------
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

# -------------------- Build Dimensions --------------------

# Customers
genders = ["M", "F"]
customer_rows = []
for cid in range(1, N_CUSTOMERS + 1):
    gender = rng.choice(genders, p=[0.55, 0.45])
    if gender == "M":
        fn = random.choice(FIRST_NAMES_M)
    else:
        fn = random.choice(FIRST_NAMES_F)
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

# Movies - create fictional titles
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

# Payments - construct combinations (method, provider, gateway)
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

# Time dimension (every 30 minutes 09:00-23:30 between DATE_START and DATE_END)

time_rows = []
current_date = DATE_START.date()
end_date = DATE_END.date()
slot_times = [time(h, m) for h in range(9, 24) for m in (0,30)] + [time(23,30)]
# Note: 23:30 added already; keep duplicates safe
slot_times = sorted(list(set(slot_times)))

while current_date <= end_date:
    for t in slot_times:
        dt = datetime.combine(current_date, t)
        time_id = int(dt.strftime('%Y%m%d%H%M'))
        dow = dt.weekday()  # Mon=0
        time_rows.append((
            time_id,
            dt.date(),
            dt.time().strftime('%H:%M'),
            dt.hour,
            dt.minute,
            dt.strftime('%A'),
            dow + 1,
            int(dow >= 5),
            int(dt.strftime('%W')),
            dt.month,
            (dt.month - 1)//3 + 1,
            dt.year
        ))
    current_date += timedelta(days=1)

# Remove duplicates if any
seen = set()
unique_time_rows = []
for row in time_rows:
    if row[0] not in seen:
        unique_time_rows.append(row)
        seen.add(row[0])

dim_time = pd.DataFrame(unique_time_rows, columns=[
    "time_id", "date", "time", "hour", "minute", "day_name", "day_of_week", "is_weekend",
    "week_of_year", "month", "quarter", "year"
])

# -------------------- Build Fact: Online Movie Reservations --------------------
# To keep relations realistic: map theatres to a subset of languages; assign base price per theatre and seat type multipliers.

# Base ticket price by theatre (random between 150 and 400 INR)
base_price_by_theatre = {tid: float(rng.integers(150, 401)) for tid in dim_theatres.theatre_id}

# Seat type multiplier
seat_multiplier = {"Regular": 1.0, "Premium": 1.3, "Recliner": 1.6, "IMAX": 1.8}

# Peak hour surcharge factor by hour (evenings are pricier)
hour_factor = {h: (1.25 if 18 <= h <= 22 else 1.1 if 14 <= h < 18 else 1.0) for h in range(0,24)}

# Map each theatre to a set of languages it commonly plays
langs_per_theatre = {}
for tid in dim_theatres.theatre_id:
    nlangs = int(rng.integers(2, min(len(languages), 5)))
    langs_per_theatre[tid] = set(rng.choice(languages, size=nlangs, replace=False))

# Precompute valid show times (after movie release date)
movie_release_map = {row.movie_id: pd.to_datetime(row.release_date) for _, row in dim_movies.iterrows()}

# Time IDs list filtered to business hours (already in dim_time) and reasonable date range for shows (release -> TODAY+14)
time_ids = dim_time['time_id'].values

def pick_show_time(movie_id):
    # choose a time_id >= release date of movie and <= TODAY + 14 days
    rel = movie_release_map[movie_id]
    min_id = int(rel.strftime('%Y%m%d0000'))
    max_date = min(DATE_END, TODAY + timedelta(days=14))
    max_id = int(max_date.strftime('%Y%m%d2359'))
    # filter by bounds
    # since time_ids are sorted, we can binary search via pandas boolean mask
    eligible = dim_time[(dim_time.time_id >= min_id) & (dim_time.time_id <= max_id)]
    if eligible.empty:
        return int(dim_time.iloc[-1].time_id)
    # prefer evening shows
    probs = np.where((eligible['hour'] >= 18) & (eligible['hour'] <= 22), 1.8, 1.0)
    probs = probs / probs.sum()
    return int(np.random.choice(eligible['time_id'].values, p=probs))

# Convenience fee distribution and discount logic

def compute_pricing(theatre_id, hour, seat_type, seats):
    base = base_price_by_theatre[theatre_id]
    unit = base * seat_multiplier[seat_type] * hour_factor.get(hour, 1.0)
    # Round to nearest 5 INR for realism
    unit = round(unit / 5) * 5
    base_amount = unit * seats
    conv_fee = round((10 + 0.03 * base_amount), 2)  # fixed + %
    # Occasional promo
    discount = 0.0
    if rng.random() < 0.25:
        discount = round(min(150.0, 0.1 * base_amount), 2)
    taxable = max(0.0, base_amount + conv_fee - discount)
    tax = round(0.18 * taxable, 2)
    gross = round(base_amount + conv_fee + tax, 2)
    total = round(max(0.0, gross - discount), 2)  # equal to taxable + tax actually
    return unit, base_amount, conv_fee, tax, discount, gross, total

# Build reservation fact rows

fact_rows = []

# Choose distribution for statuses
res_status_vals = ["Confirmed", "Cancelled"]
payment_status_vals = ["Success", "Failed", "Refunded"]

for rid in range(1, N_RESERVATIONS + 1):
    customer_id = int(rng.integers(1, N_CUSTOMERS + 1))
    theatre_id = int(rng.integers(1, N_THEATRES + 1))

    # Pick a movie whose language fits theatre's typical languages, 70% of the time; else any
    if rng.random() < 0.7:
        allowed_langs = langs_per_theatre[theatre_id]
        movies_subset = dim_movies[dim_movies['language'].isin(allowed_langs)]
        if movies_subset.empty:
            movie_id = int(rng.integers(1, N_MOVIES + 1))
        else:
            movie_id = int(movies_subset.sample(1, random_state=int(rng.integers(0, 10**6))).iloc[0].movie_id)
    else:
        movie_id = int(rng.integers(1, N_MOVIES + 1))

    # Show time (after release)
    show_time_id = pick_show_time(movie_id)
    show_dt_row = dim_time.loc[dim_time.time_id == show_time_id].iloc[0]
    show_dt = datetime.combine(pd.to_datetime(show_dt_row['date']).date(), datetime.strptime(show_dt_row['time'], '%H:%M').time())

    # Booking time is before show time, up to 30 days earlier
    book_earliest = show_dt - timedelta(days=30)
    book_earliest_id = int(max(int(book_earliest.strftime('%Y%m%d%H%M')), int(DATE_START.strftime('%Y%m%d0900'))))
    # Only pick booking times that exist in dim_time
    eligible_book = dim_time[(dim_time.time_id >= book_earliest_id) & (dim_time.time_id <= show_time_id)]
    if eligible_book.empty:
        booking_time_id = show_time_id
    else:
        # bias toward last 7 days before show
        probs = np.ones(len(eligible_book))
        recent_mask = eligible_book['time_id'] >= int((show_dt - timedelta(days=7)).strftime('%Y%m%d%H%M'))
        probs[recent_mask.values] = 2.0
        probs = probs / probs.sum()
        booking_time_id = int(np.random.choice(eligible_book['time_id'].values, p=probs))

    # Seat type and seats
    seat_type = rng.choice(seat_types, p=[0.6, 0.2, 0.15, 0.05])
    seats = int(rng.integers(1, 7))

    # Screen number within theatre
    num_screens = int(dim_theatres.loc[dim_theatres.theatre_id == theatre_id, 'num_screens'].iloc[0])
    screen = int(rng.integers(1, num_screens + 1))

    # Pricing
    hour = int(show_dt_row['hour'])
    unit_price, base_amount, conv_fee, tax, discount, gross, total = compute_pricing(theatre_id, hour, seat_type, seats)

    # Payment & reservation statuses
    res_status = rng.choice(res_status_vals, p=[0.9, 0.1])
    # If cancelled, increase chance of refunded payment
    if res_status == "Cancelled":
        pay_status = rng.choice(payment_status_vals, p=[0.2, 0.1, 0.7])
    else:
        pay_status = rng.choice(payment_status_vals, p=[0.9, 0.07, 0.03])

    payment_id = int(rng.integers(1, N_PAYMENTS + 1))
    channel = rng.choice(booking_channels, p=[0.5, 0.3, 0.2])

    # Promo code
    promo_pool = ["", "WELCOME50", "MOVIE10", "FIRST100", "WEEKEND25", "FESTIVE150"]
    promo_weights = [0.7, 0.05, 0.08, 0.05, 0.07, 0.05]
    promo = rng.choice(promo_pool, p=promo_weights)

    # For failed/refunded or cancelled reservations, set realized_total to 0; keep quoted_total as reference
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

# -------------------- Save CSV files --------------------
paths = {}
paths['dim_customers'] = '/mnt/data/dim_customers.csv'
paths['dim_theatres'] = '/mnt/data/dim_theatres.csv'
paths['dim_movies'] = '/mnt/data/dim_movies.csv'
paths['dim_payments'] = '/mnt/data/dim_payments.csv'
paths['dim_time'] = '/mnt/data/dim_time.csv'
paths['fact_online_movie_reservations'] = '/mnt/data/fact_online_movie_reservations.csv'

for name, p in paths.items():
    if name == 'dim_time':
        dim_time.to_csv(p, index=False)
    elif name == 'dim_customers':
        dim_customers.to_csv(p, index=False)
    elif name == 'dim_theatres':
        dim_theatres.to_csv(p, index=False)
    elif name == 'dim_movies':
        dim_movies.to_csv(p, index=False)
    elif name == 'dim_payments':
        dim_payments.to_csv(p, index=False)
    elif name == 'fact_online_movie_reservations':
        fact.to_csv(p, index=False)

# Provide small previews
preview = {
    'dim_customers_head': dim_customers.head(3).to_dict(orient='records'),
    'dim_theatres_head': dim_theatres.head(3).to_dict(orient='records'),
    'dim_movies_head': dim_movies.head(3).to_dict(orient='records'),
    'dim_payments_head': dim_payments.head(3).to_dict(orient='records'),
    'dim_time_head': dim_time.head(3).to_dict(orient='records'),
    'fact_head': fact.head(3).to_dict(orient='records'),
    'paths': paths,
    'counts': {
        'dim_customers': len(dim_customers),
        'dim_theatres': len(dim_theatres),
        'dim_movies': len(dim_movies),
        'dim_payments': len(dim_payments),
        'dim_time': len(dim_time),
        'fact_online_movie_reservations': len(fact),
    }
}

print(preview)
