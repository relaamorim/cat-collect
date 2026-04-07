-- ============================================
-- SQL PARA CRIAR A TABELA NO SUPABASE
-- ============================================
-- Execute este script no SQL Editor do Supabase
-- (Painel do Supabase > SQL Editor > New query)

-- Tabela de jogadores (leads + pontuação)
CREATE TABLE jogadores (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  nome text NOT NULL,
  whatsapp text NOT NULL,
  email text NOT NULL,
  pontuacao integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Índice para consultas de ranking (ordenar por pontuação)
CREATE INDEX idx_jogadores_pontuacao ON jogadores (pontuacao DESC);

-- Habilita Row Level Security (segurança)
ALTER TABLE jogadores ENABLE ROW LEVEL SECURITY;

-- Política: permite inserir (qualquer pessoa pode se cadastrar)
CREATE POLICY "Permitir inserção pública"
  ON jogadores FOR INSERT
  TO anon
  WITH CHECK (true);

-- Política: permite atualizar pontuação (qualquer pessoa pode atualizar)
CREATE POLICY "Permitir atualização pública"
  ON jogadores FOR UPDATE
  TO anon
  USING (true)
  WITH CHECK (true);

-- Política: permite ler dados (para o ranking)
CREATE POLICY "Permitir leitura pública"
  ON jogadores FOR SELECT
  TO anon
  USING (true);
