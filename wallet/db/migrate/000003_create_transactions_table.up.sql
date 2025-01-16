CREATE TABLE transactions (
    id VARCHAR(255) PRIMARY KEY,
    account_id_from VARCHAR(255) NOT NULL,
    account_id_to VARCHAR(255) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (account_id_from) REFERENCES accounts(id) ON DELETE CASCADE,
    FOREIGN KEY (account_id_to) REFERENCES accounts(id) ON DELETE CASCADE
);
