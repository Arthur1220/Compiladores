#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <tuple>

using namespace std;

class Automato {
private:
    vector<string> estados;
    vector<string> alfabeto;
    vector<tuple<string, string, string>> transicoes;
    string estadoInicial;
    vector<string> estadosFinais;
    string cadeia;

    bool estaNoVetor(const vector<string>& vetor, const string& str) const {
        for (const auto& item : vetor) {
            if (item == str) return true;
        }
        return false;
    }

    bool executarTransicao(string& estadoAtual, char simbolo) const {
        for (const auto& [estado, simboloTransicao, proximoEstado] : transicoes) {
            if (estado == estadoAtual && simboloTransicao[0] == simbolo) {
                estadoAtual = proximoEstado;
                return true;
            }
        }
        return false;
    }

public:
    Automato() : estadoInicial(""), cadeia("") {}

    void inicializar() {
        estados.clear();
        alfabeto.clear();
        transicoes.clear();
        estadoInicial.clear();
        estadosFinais.clear();
        cadeia.clear();
    }

    void lerAutomato(const string& nomeArquivo) {
        ifstream arquivo(nomeArquivo);
        if (!arquivo.is_open()) {
            cerr << "Erro ao abrir o arquivo\n";
            exit(EXIT_FAILURE);
        }

        string linha;
        int linhaAtual = 0;
        bool estadoInicialDefinido = false;
        bool estadosFinaisDefinidos = false;

        while (getline(arquivo, linha)) {
            istringstream iss(linha);
            string token;
            vector<string> elementos;

            while (iss >> token) {
                elementos.push_back(token);
            }

            if (linhaAtual == 0) { // Processa os estados
                estados = elementos;
            } else if (linhaAtual == 1) { // Processa o alfabeto
                alfabeto = elementos;
            } else if (elementos.size() == 3 && !estadoInicialDefinido) { // Processa transições enquanto o estado inicial não estiver definido
                const string& estadoOrigem = elementos[0];
                const string& simbolo = elementos[1];
                const string& estadoDestino = elementos[2];

                // Verifica se os estados e o símbolo pertencem às listas definidas
                if (!estaNoVetor(estados, estadoOrigem)) {
                    cerr << "Erro na linha " << (linhaAtual+1) << "\n";
                    cerr << "TRANSIÇÃO: " << estadoOrigem << " " << simbolo << " " << estadoDestino << "\n";
                    cerr << "Erro: Estado de origem '" << estadoOrigem << "' não pertence à lista de estados.\n";
                    exit(EXIT_FAILURE);
                }
                if (!estaNoVetor(alfabeto, simbolo)) {
                    cerr << "Erro na linha " << (linhaAtual+1) << "\n";
                    cerr << "TRANSIÇÃO: " << estadoOrigem << " " << simbolo << " " << estadoDestino << "\n";
                    cerr << "Erro: Símbolo '" << simbolo << "' não pertence ao alfabeto.\n";
                    exit(EXIT_FAILURE);
                }
                if (!estaNoVetor(estados, estadoDestino)) {
                    cerr << "Erro na linha " << (linhaAtual+1) << "\n";
                    cerr << "TRANSIÇÃO: " << estadoOrigem << " " << simbolo << " " << estadoDestino << "\n";
                    cerr << "Erro: Estado de destino '" << estadoDestino << "' não pertence à lista de estados.\n";
                    exit(EXIT_FAILURE);
                }

                transicoes.emplace_back(estadoOrigem, simbolo, estadoDestino);
            } else if (!estadoInicialDefinido && elementos.size() == 1) { // Define o estado inicial
                if (estaNoVetor(estados, elementos[0])) {
                    estadoInicial = elementos[0];
                    estadoInicialDefinido = true;
                } else {
                    cerr << "Erro na linha " << (linhaAtual+1) << "\n";
                    cerr << "Erro: O estado inicial '" << elementos[0] << "' não pertence à lista de estados.\n";
                    exit(EXIT_FAILURE);
                }
            } else if (estadoInicialDefinido && !estadosFinaisDefinidos) {
                // Define os estados finais
                for (const auto& estadoFinal : elementos) {
                    if (estaNoVetor(estados, estadoFinal)) {
                        estadosFinais.push_back(estadoFinal);
                    } else {
                        cerr << "Erro na linha " << (linhaAtual+1) << "\n";
                        cerr << "Erro: O estado final '" << estadoFinal << "' não pertence à lista de estados.\n";
                        exit(EXIT_FAILURE);
                    }
                }
                estadosFinaisDefinidos = true;
            } else if (estadosFinaisDefinidos && !elementos.empty()) { // Define a cadeia se ela estiver vazia
                cadeia = elementos[0];
            }

            linhaAtual++;
        }
        arquivo.close();
    }

    bool verificarCadeia() const {
        string estadoAtual = estadoInicial;

        for (char simbolo : cadeia) {
            if (!executarTransicao(estadoAtual, simbolo))
                return false;
        }

        for (const auto& estadoFinal : estadosFinais) {
            if (estadoAtual == estadoFinal)
                return true;
        }

        return false;
    }

    void imprimirAutomato() const {
        cout << "Estados: ";
        for (const auto& estado : estados) {
            cout << estado << " ";
        }
        cout << "\n";

        cout << "Alfabeto: ";
        for (const auto& simbolo : alfabeto) {
            cout << simbolo << " ";
        }
        cout << "\n";

        cout << "Transições:\n";
        for (const auto& [estado, simboloTransicao, proximoEstado] : transicoes) {
            cout << "(" << estado << ", " << simboloTransicao << ") -> " << proximoEstado << "\n";
        }

        cout << "Estado Inicial: " << estadoInicial << "\n";

        cout << "Estados Finais: ";
        if (estadosFinais.empty()) {
            cout << "Nenhum estado final definido.\n";
        } else {
            for (const auto& estadoFinal : estadosFinais) {
                cout << estadoFinal << " ";
            }
            cout << "\n";
        }

        cout << "Cadeia: " << cadeia << "\n";
    }
};

int main() {
    Automato automato;
    automato.inicializar();
    automato.lerAutomato("dois_estados.txt");
    automato.imprimirAutomato();

    if (automato.verificarCadeia())
        cout << "  - Cadeia aceita pelo automato.\n";
    else
        cout << "  - Cadeia rejeitada pelo automato.\n";

    return 0;
}
