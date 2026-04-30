#!/bin/bash
# O script abaixo deve filtrar no arquivo apache.log as linhas que contenham
# o código 4786228.66 e exibir apenas as 5 primeiras ocorrências.

grep "4786228.66" apache.log | head -5
