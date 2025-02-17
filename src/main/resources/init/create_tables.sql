CREATE TABLE IF NOT EXISTS guestbook(
    guestbook_idx INT PRIMARY KEY,
    guestbook_name VARCHAR(20),
    guestbook_memo VARCHAR(100),
    guestbook_today DATE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS member (
    member_idx INT PRIMARY KEY,
    username VARCHAR(20),
    password VARCHAR(68),
    role VARCHAR(15) DEFAULT 'ROLE_MEMBER',
    name VARCHAR(10), 
    phone VARCHAR(14),
    email VARCHAR(30),
    postcode VARCHAR(10),
    address VARCHAR(50),
    detailaddress VARCHAR(50),
    extraaddress VARCHAR(50),
    regdate DATE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    etc VARCHAR(100),
    uuid VARCHAR(36)
);

CREATE TABLE IF NOT EXISTS board (
    board_idx INT PRIMARY KEY,
    member_idx INT,
    member_name VARCHAR(20),
    board_title VARCHAR(50),
    board_content VARCHAR(1000),
    board_map VARCHAR(10),
    board_imgstr VARCHAR(50),
    board_today DATE DEFAULT CURRENT_TIMESTAMP,
    board_cnt INT,
    map_dot VARCHAR(1000),
    FOREIGN KEY (member_idx) REFERENCES member(member_idx)
);

CREATE TABLE IF NOT EXISTS comment_board (
    comment_idx INT PRIMARY KEY,
    board_idx INT,
    member_idx INT,
    comment_content VARCHAR(1000),
    comment_date DATE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (board_idx) REFERENCES board(board_idx),
    FOREIGN KEY (member_idx) REFERENCES member(member_idx)
);

CREATE TABLE IF NOT EXISTS product (
    product_idx INT PRIMARY KEY,
    product_name VARCHAR(20),
    product_price DECIMAL(10, 2),
    product_desc VARCHAR(50),
    product_imgstr VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS cart (
    cart_idx INT PRIMARY KEY,
    member_idx INT,
    product_idx INT,
    product_name VARCHAR(20),
    product_amount INT,
    product_price DECIMAL(10, 2),
    product_imgstr VARCHAR(50),
    FOREIGN KEY (product_idx) REFERENCES product(product_idx),
    FOREIGN KEY (member_idx) REFERENCES member(member_idx)
);

CREATE TABLE IF NOT EXISTS order_tbl (
    order_idx INT PRIMARY KEY,
    cart_idx INT,
    member_idx INT,
    product_idx INT,
    product_name VARCHAR(20),
    product_amount INT,
    product_price DECIMAL(10, 2),
    product_imgstr VARCHAR(50),
    order_price DECIMAL(10, 2),
    order_today DATE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_idx) REFERENCES member(member_idx),
    FOREIGN KEY (product_idx) REFERENCES product(product_idx)
);

CREATE TABLE IF NOT EXISTS bookmark (
    bookmark_idx INT PRIMARY KEY,
    member_idx INT,
    board_idx INT,
    boardbookmarked INT DEFAULT 0,
    FOREIGN KEY (board_idx) REFERENCES board(board_idx),
    FOREIGN KEY (member_idx) REFERENCES member(member_idx)
);

CREATE TABLE IF NOT EXISTS pokemon (
    pokemon_idx INT PRIMARY KEY,
    num VARCHAR(10),
    name VARCHAR(15),
    image VARCHAR(1000),
    type1 VARCHAR(5),
    type2 VARCHAR(5)
);