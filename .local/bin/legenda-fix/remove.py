#!/bin/python3

import sys

def main():
    if len(sys.argv) < 2:
        print("Erro: faltam argumentos.")
    else:
        print("Abrindo a legenda: ", sys.argv[1])
        file = open(sys.argv[1], "r")
        sub = file.read()
        file.close()

        if sub == None:
            print("Arquivo está vazio.")
            return

        print("Removendo tags...")

        nsub = ""
        intag = False
        for c in sub:
            if c != '<' and not intag:
                nsub += c
            else:
                intag = not (c == '>')

        if len(sys.argv) > 2:
            filename = sys.argv[2]
            if filename[-4:] != ".srt":
                filename += ".srt"
        else:
            filename = sys.argv[1][:-4] + ".srt"
    
        print("Escrevendo em ", filename,"...")
        file = open(filename, "w")
        file.write(nsub)
        file.close()
        print("Pronto.")

if __name__ == '__main__':
    main()
