import 'cases.dart';

class CasesRepository {
  static const _allCases = <Cases>[
    Cases(
      state: Status.open,
      id: 0,
      stage: Stage.attorney_review,
      name: 'D1002-20 Franklin Eduardo Araniva Pastora',
      number: 'D1002-20',
      added: '1969-07-20 20:18:04Z',
    ),
    Cases(
      state: Status.open,
      id: 1,
      stage: Stage.filed,
      name: 'D1005-19 Jeudy Jorge Benjamin Cordero',
      number: 'D1005-19',
      added: '1969-07-20 20:18:04Z',
    ),
    Cases(
      state: Status.open,
      id: 2,
      stage: Stage.upcoming_trial,
      name: 'D1006-19 Yainier Jimenez Perez',
      number: 'D1006-19',
      added: '1969-07-20 20:18:04Z',
    ),
    Cases(
      state: Status.open,
      id: 3,
      stage: Stage.pending_payment,
      name: 'D1019-20 Melec Alexis Amaya Pastora',
      number: 'D1019-20',
      added: '1969-07-20 20:18:04Z',
    ),
    Cases(
      state: Status.open,
      id: 4,
      stage: Stage.filed,
      name: 'D1020-20 Ada D. Okunoghae',
      number: 'D1020-20',
      added: '1969-07-20 20:18:04Z',
    ),
  ];

  static List<Cases> loadCases(Status state) {
    if (state == Status.open) {
      return _allCases;
    } else {
      return _allCases.where((p) => p.state == state).toList();
    }
  }
}
