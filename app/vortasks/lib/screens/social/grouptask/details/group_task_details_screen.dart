import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/controllers/social/group_task_invite_controller.dart';
import 'package:vortasks/models/social/grouptask.dart';
import 'package:vortasks/models/social/group_task_invite.dart';
import 'package:vortasks/models/social/group_subtask.dart';
import 'package:vortasks/stores/social/friend_request_store.dart';
import 'package:vortasks/stores/user_store.dart';
import 'package:intl/intl.dart';

class GroupTaskDetailsScreen extends StatefulWidget {
  final GroupTask groupTask;

  const GroupTaskDetailsScreen({super.key, required this.groupTask});

  @override
  State<GroupTaskDetailsScreen> createState() => _GroupTaskDetailsScreenState();
}

class _GroupTaskDetailsScreenState extends State<GroupTaskDetailsScreen> {
  final UserStore _userStore = GetIt.I<UserStore>();
  final GroupTaskInviteController _inviteController =
      GroupTaskInviteController(); // Controlador de convites
  final Map<String, String> _requestStatuses = {};
  List<GroupTaskInvite> _invites = [];

  @override
  void initState() {
    super.initState();
    _fetchInvites();
  }

  // Busca os convites da tarefa
  Future<void> _fetchInvites() async {
    try {
      final invites =
          await _inviteController.getInvitesByGroupTask(widget.groupTask.id);
      setState(() {
        _invites = invites;
      });
    } catch (e) {}
  }

  // Widget para exibir informações da tarefa em grupo
  Widget _buildGroupTaskInfo() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.groupTask.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Descrição: ${widget.groupTask.description ?? ''}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Autor: ${widget.groupTask.author}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Editores: ${widget.groupTask.editors.join(', ')}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Criado em: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.groupTask.createdAt)}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Data de início: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.groupTask.startDate)}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Data de término: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.groupTask.endDate)}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa em Grupo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGroupTaskInfo(),
            const SizedBox(height: 16.0),
            _buildParticipantsSection(),
            const SizedBox(height: 16.0),
            _buildRequestsSection(),
            const SizedBox(height: 16.0),
            _buildGroupSubtasksSection(),
          ],
        ),
      ),
    );
  }

  // Widget para exibir a lista de participantes
  Widget _buildParticipantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Participantes:',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: widget.groupTask.participants.map((participant) {
            return Chip(
              label: Text(participant),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Widget para exibir a lista de pedidos de participação
  Widget _buildRequestsSection() {
    final friendRequestStore = GetIt.I<FriendRequestStore>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pedidos de Participação:',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        if (_invites.isEmpty)
          const Text('Não há pedidos de participação pendentes.')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _invites.length,
            itemBuilder: (context, index) {
              final invite = _invites[index];
              final requestStatus = _requestStatuses[invite.id] ?? 'PENDENTE';

              // Chama a ação para buscar o nome de usuário
              return FutureBuilder(
                // Usa FutureBuilder para lidar com o Future
                future: friendRequestStore.fetchUsername(invite.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      // Exibe um ListTile com indicador de carregamento
                      title: Text('Carregando...'),
                      trailing: Text(
                          'Status: PENDENTE'), // Ou o status que você quiser exibir enquanto carrega
                    );
                  } else if (snapshot.hasError) {
                    return ListTile(
                      // Exibe um ListTile com mensagem de erro
                      title: Text('Erro: ${snapshot.error}'),
                      trailing: Text('Status: $requestStatus'),
                    );
                  } else {
                    // Nome de usuário disponível, constrói o ListTile normal
                    return ListTile(
                      title: Observer(
                        builder: (_) {
                          final username =
                              friendRequestStore.usernames[invite.userId];
                          return Text(username ?? 'Usuário não encontrado');
                        },
                      ),
                      trailing: Text('Status: $requestStatus'),
                    );
                  }
                },
              );
            },
          ),
      ],
    );
  }

  // Widget para exibir a lista de tarefas individuais
  Widget _buildGroupSubtasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tarefas Individuais:',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.groupTask.groupSubtask.length,
          itemBuilder: (context, index) {
            return _buildGroupSubtaskItem(
                widget.groupTask.groupSubtask[index], context);
          },
        ),
      ],
    );
  }

  // Widget para cada item da lista de tarefas individuais
  Widget _buildGroupSubtaskItem(
      GroupSubtask groupSubtask, BuildContext context) {
    groupSubtask.participants.any((user) => user == _userStore.user!.username);
    bool isAuthorOrEditor = widget.groupTask.author == _userStore.username! ||
        widget.groupTask.editors.contains(_userStore.username!);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(groupSubtask.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(groupSubtask.description ?? ''),
            const SizedBox(height: 4.0),
            Wrap(
              spacing: 4.0,
              children: groupSubtask.participants.map((participant) {
                return Chip(
                  label: Text(participant),
                );
              }).toList(),
            ),
          ],
        ),
        trailing: isAuthorOrEditor
            ? IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Lógica para editar a sub tarefa
                },
              )
            : null,
      ),
    );
  }
}
