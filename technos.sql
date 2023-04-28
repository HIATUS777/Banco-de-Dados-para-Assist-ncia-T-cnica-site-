-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18-Abr-2023 às 14:05
-- Versão do servidor: 10.4.24-MariaDB
-- versão do PHP: 8.1.6
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!40101 SET NAMES utf8mb4 */
;
--
-- Banco de dados: `technos`
--

-- --------------------------------------------------------
--
-- Estrutura da tabela `administrador`
--

CREATE TABLE `administrador` (
    `idadministrador` int(11) NOT NULL,
    `login` varchar(255) NOT NULL,
    `senha` varchar(32) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
-- --------------------------------------------------------
--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
    `idcliente` int(11) NOT NULL,
    `nome` varchar(255) NOT NULL,
    `endereco` varchar(255) NOT NULL,
    `cpf` varchar(18) NOT NULL,
    `rg` varchar(32) NOT NULL,
    `telefone` varchar(25) NOT NULL,
    `data_nasc` varchar(10) NOT NULL,
    `data_cadastro` date NOT NULL,
    `email` varchar(255) NOT NULL,
    `cep` varchar(45) NOT NULL,
    `sexo` enum('M', 'F') NOT NULL,
    `login` varchar(255) NOT NULL,
    `senha` varchar(32) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
-- --------------------------------------------------------
--
-- Estrutura da tabela `equipamentos`
--

CREATE TABLE `equipamentos` (
    `idequipamento` int(11) NOT NULL,
    `ordemdeserviço_equipamentos_idequipamentos` int(11) NOT NULL,
    `fornecedor_idfornecedor` int(11) NOT NULL,
    `ordemdeserviço_numeroOS` int(11) NOT NULL,
    `marca` varchar(45) NOT NULL,
    `modelo` varchar(45) NOT NULL,
    `cor` varchar(45) DEFAULT NULL,
    `caracteristicas` varchar(255) NOT NULL,
    `observaçao` varchar(255) DEFAULT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
-- --------------------------------------------------------
--
-- Estrutura da tabela `fornecedor`
--

CREATE TABLE `fornecedor` (
    `idfornecedor` int(11) NOT NULL,
    `nome_empresa` varchar(255) NOT NULL,
    `endereco_empresa` varchar(255) NOT NULL,
    `cnpj` varchar(20) NOT NULL,
    `cep_empresa` varchar(32) NOT NULL,
    `telefone_empresa` varchar(25) NOT NULL,
    `email_empresa` varchar(255) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
-- --------------------------------------------------------
--
-- Estrutura da tabela `ordemdeserviço`
--

CREATE TABLE `ordemdeserviço` (
    `numeroOS` int(11) NOT NULL,
    `equipamentos_idequipamentos` int(11) NOT NULL,
    `cliente_idcliente` int(11) NOT NULL,
    `administrador_idadministrador` int(11) NOT NULL,
    `status` varchar(255) NOT NULL,
    `orçamento` double NOT NULL,
    `diagnostico` varchar(255) NOT NULL,
    `observações` varchar(255) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `administrador`
--
ALTER TABLE `administrador`
ADD PRIMARY KEY (`idadministrador`),
    MODIFY `idadministrador` int(11) NOT NULL AUTO_INCREMENT;
--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
ADD PRIMARY KEY (`idcliente`),
    MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT;
--
-- Índices para tabela `equipamentos`
--
ALTER TABLE `equipamentos`
ADD PRIMARY KEY (`idequipamento`),
    MODIFY `idequipamento` int(11) NOT NULL AUTO_INCREMENT,
    ADD KEY `ordemdeserviço` (`ordemdeserviço_numeroOS`),
    ADD KEY `ordemdeserviço_equipamentos_idequipamentos` (`ordemdeserviço_equipamentos_idequipamentos`),
    ADD KEY `fornecedor_idfornecedor` (`fornecedor_idfornecedor`);
--
-- Índices para tabela `fornecedor`
--
ALTER TABLE `fornecedor`
ADD PRIMARY KEY (`idfornecedor`),
    MODIFY `idfornecedor` int(11) NOT NULL AUTO_INCREMENT;
--
-- Índices para tabela `ordemdeserviço`
--
ALTER TABLE `ordemdeserviço`
ADD PRIMARY KEY (`numeroOS`),
    ADD UNIQUE KEY `equipamentos_idequipamentos` (`equipamentos_idequipamentos`),
    ADD UNIQUE KEY `cliente_idcliente` (`cliente_idcliente`),
    ADD KEY `administrador_idadministrador` (`administrador_idadministrador`);
--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `equipamentos`
--
ALTER TABLE `equipamentos`
ADD CONSTRAINT `EQP_EQP` FOREIGN KEY (`ordemdeserviço_equipamentos_idequipamentos`) REFERENCES `equipamentos` (`idequipamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    ADD CONSTRAINT `F_EQP` FOREIGN KEY (`fornecedor_idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    ADD CONSTRAINT `OS_EQP` FOREIGN KEY (`ordemdeserviço_numeroOS`) REFERENCES `ordemdeserviço` (`numeroOS`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Limitadores para a tabela `ordemdeserviço`
--
ALTER TABLE `ordemdeserviço`
ADD CONSTRAINT `ADM` FOREIGN KEY (`administrador_idadministrador`) REFERENCES `administrador` (`idadministrador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    ADD CONSTRAINT `CLIENT` FOREIGN KEY (`cliente_idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    ADD CONSTRAINT `EQP` FOREIGN KEY (`equipamentos_idequipamentos`) REFERENCES `equipamentos` (`idequipamento`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;
