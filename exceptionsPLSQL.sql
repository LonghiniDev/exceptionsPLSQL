-- CRIAR UM BLOCO DE PL/SQL:
-- I -> INCLUIR
-- E -> EXCLUIR
-- REGRAS
-- 1) Se for digitada a opção errada, deve ser gerada uma exception (criar uma)
-- 2) Se for incluído um pedido que já existe deve ser tradada na exception (pré-definida -> Valores duplicados)
-- 3) Se for incluído um pedido com um cliente inexistente deve ser tratada com uma exception (criar um pragma).
-- 4) Se não existir o pedido a ser excluído deve ser tratada com uma exception (criar uma) utilizar o curso implícito


  DECLARE
      vOpcao        VARCHAR2(01) := '&OP';
    vCodPedido    PEDIDO.CODPEDIDO%TYPE     := &Pedido;
    vCodCliente   PEDIDO.CODCLIENTE%TYPE    := &Cliente;
    vDataPedido   PEDIDO.DATAPEDIDO%TYPE    := '&Data';
    vNF           PEDIDO.NF%TYPE            := '&Nfe';
    vValor        PEDIDO.VALORTOTAL%TYPE    := &Valor;
    ERROCLIENTE   EXCEPTION;
    PRAGMA EXCEPTION_INIT(ERROCLIENTE,-2291);
    ERROOPCAO     EXCEPTION;
  BEGIN
      IF vOpcao NOT IN ('I','E') THEN
        RAISE ERROOPCAO;
      ELSIF vOpcao = 'I' THEN
         INSERT INTO PEDIDO (CODPEDIDO,CODCLIENTE,DATAPEDIDO,NF,VALORTOTAL) 
                   VALUES   (vCodPedido,vCodCliente,vDataPedido,vNF,vValor);
      ELSE
        DELETE FROM PEDIDO WHERE CODPEDIDO = vCodPedido;
        IF SQL%NOTFOUND THEN 
           RAISE_APPLICATION_ERROR(-20005,'Não há pedido para excluir!!!');
        END IF;   
      END IF;

     EXCEPTION 
      WHEN ERROOPCAO THEN
          RAISE_APPLICATION_ERROR(-20001,'Digite a opção correta (I) ou (E)');
      WHEN DUP_VAL_ON_INDEX THEN
          RAISE_APPLICATION_ERROR(-20002,'Número do Pedido já cadastrado');
      WHEN ERROCLIENTE THEN
         RAISE_APPLICATION_ERROR(-20003,'Cliente não cadastrado!!!');
      WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20004,SQLERRM(SQLCODE));
      
  END;
