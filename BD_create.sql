-- Estructura de tabla para la tabla `voo_prices`
CREATE TABLE IF NOT EXISTS `voo_prices` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `ticker` varchar(10) NOT NULL DEFAULT 'VOO',
  `source` enum('finnhub','yfinance') NOT NULL,
  
  -- Precios Principales
  `price_current` decimal(10,4) DEFAULT NULL COMMENT 'Precio actual',
  `price_open` decimal(10,4) DEFAULT NULL COMMENT 'Apertura del día',
  `price_high` decimal(10,4) DEFAULT NULL COMMENT 'Máximo del día',
  `price_low` decimal(10,4) DEFAULT NULL COMMENT 'Mínimo del día',
  `price_prev_close` decimal(10,4) DEFAULT NULL COMMENT 'Cierre anterior',
  
  -- Variaciones y Volumen
  `price_change` decimal(10,4) DEFAULT NULL COMMENT 'Cambio absoluto',
  `price_change_pct` decimal(8,4) DEFAULT NULL COMMENT 'Cambio porcentual %',
  `volume` bigint DEFAULT NULL COMMENT 'Volumen del período',
  `avg_volume_10d` bigint DEFAULT NULL COMMENT 'Volumen promedio 10 días',
  
  -- Rangos y Fundamentales
  `week_52_high` decimal(10,4) DEFAULT NULL COMMENT 'Máximo 52 semanas',
  `week_52_low` decimal(10,4) DEFAULT NULL COMMENT 'Mínimo 52 semanas',
  `price_return_ytd` decimal(8,4) DEFAULT NULL COMMENT 'Retorno YTD %',
  `market_cap` decimal(18,2) DEFAULT NULL COMMENT 'Market Cap USD',
  `beta` decimal(6,4) DEFAULT NULL COMMENT 'Beta vs S&P500',
  
  -- Datos de ETF y Dividendos
  `nav` decimal(10,4) DEFAULT NULL COMMENT 'Net Asset Value',
  `expense_ratio` decimal(6,4) DEFAULT 0.0003 COMMENT 'Ratio de gastos (0.03% para VOO)',
  `dividend_yield` decimal(6,4) DEFAULT NULL COMMENT 'Dividend yield %',
  `dividend_rate` decimal(8,4) DEFAULT NULL COMMENT 'Dividendo anual USD',
  
  -- Estado de Sesión
  `market_open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=abierto, 0=cerrado',
  `trading_session` enum('pre','regular','post','closed') DEFAULT 'regular',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  -- Índice único para evitar duplicados del mismo ticker a la misma hora
  UNIQUE KEY `uq_ticker_timestamp` (`ticker`,`timestamp`),
  KEY `idx_timestamp` (`timestamp`),
  KEY `idx_source` (`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
