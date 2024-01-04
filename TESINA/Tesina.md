# Tesina Sistemi Dinamici

![ritagliata](assets/ritagliata.png)

## Schema del sistema

![SchemaDarkModeNoBG](assets/SchemaDarkModeNoBG.png)

> Schema del sistema idraulico composto da due serbatoi.

### Circuito Equivalente

E` possibile rappresentare lo schema idraulico in termini di **circuito elettrico**, con le componenti che conosciamo, andando a sostituire:

|   Schema Idraulico    |    Schema Elettrico    |
| :-------------------: | :--------------------: |
|       Serbatoio       |      Condensatore      |
|       Rubinetti       | Generatori di corrente |
| Pressione atmosferica | Generatore di tensione |
| Resistenze idrauliche | Resistenze elettriche  |
| Induttanze idrauliche | Induttanze idrauliche  |

Bisogna tenere a mente diversi accorgimenti:

- Come nello schema idraulico, le resistenze ed induttanze vanno poste tra due serbatoi (condensatori).
- Tra un serbatoio e l'altro, se connessi, scorre un flusso q<sub>n</sub>; nello schema elettrico questo si traduce nel flusso, elettrico, ovvero in *corrente elettrica*.

![CircuitoEquivalenteRichDark.drawio](assets/CircuitoEquivalenteRichDark.drawio.png)

> Circuito equivalente

### Equazioni del sistema

A partire dal circuito equivalente è possibile estrapolare le equazioni del sistema, che lo descrivono:
$$
\begin{equation}
    \begin{cases}
      C_{1} \cdot \frac{\mathrm{d} }{\mathrm{d} t}P_{1} = q_{1} - q_{3}\\
      C_{2} \cdot \frac{\mathrm{d} }{\mathrm{d} t}P_{2} = q_{2} + q_{3} - q_{4}\\
      L_{1} \cdot \frac{\mathrm{d} }{\mathrm{d} t}q_{3} = -R_{1} \cdot q_{3} + p_{1} - p_{2}\\
      L_{2} \cdot \frac{\mathrm{d} }{\mathrm{d} t}q_{4} = -R_{1} \cdot q_{4} + p_{1} - p_{a}\\

    \end{cases}\,.
\end{equation}
$$


Ricordando la natura del sistema, possiamo identificare i valori di input:

- **Input:**
  - q<sub>1</sub> : flusso in immissione tank 1
  - q<sub>2</sub> : flusso in immissione tank 2
  - P<sub>a</sub>: Pressione atmosferica "a valle"; Se si considera questa pressione molto più piccola rispetto alla pressione alla base del tank 2, la si può ignorare.

### Modello nello spazio di stato

Possiamo quindi partire dalle equazioni del sistema e rappresentarlo nello spazio di stato, andando a scegliere **Variabili di stato**, **Entrate** ed **uscite**:
$$
\begin{equation}\\Variabili \ di \ stato
    \begin{cases}
x_{1} = P_{1}\\
x_{2} = P_{2}\\
x_{3} = q_{3}\\
    \end{cases}\
\end{equation}
$$

$$
\begin{equation}input
\begin{cases}
u_{1} = q_{1}\\
u_{2} = q_{2}\\
u_{3} = P_{a}\\
    \end{cases}\,
\end{equation}
$$

$$
\begin{equation}uscita
\begin{cases}
y_{1} = P_{1}\\
    \end{cases}\
\end{equation}
$$










## Richieste

La prova orale consiste nella presentazione di un esempio simulato in Matlab/Simulink e due domande dall’elenco allegato. 

Un modello di traccia per la presentazione del modello da simulare (lo studente deve portare con sé il codice oppure un portatile per mostrare la simulazione) è il seguente:

- **Primo lucido**: disegno del sistema (si può scegliere tra quelli fatti a lezione eventualmente introducendo piccole varianti o un altro modello a scelta), equazioni, modello nello spazio di stato, funzione di trasferimento
- **Secondo lucido**: parametri, risposta impulsiva con singoli modi (espressione analitica e rappresentazione grafica)
- **Terzo lucido**: diagrammi di Bode e risposta a sinusoide/i
- **Quarto lucido**: risposta nel tempo a diverse condizioni (*ingressi*, *parametri*)