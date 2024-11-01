import 'package:flutter/material.dart';
import 'package:vortasks/screens/widgets/my_app_bar.dart';
import 'package:vortasks/screens/shop/order_summary_screen.dart';

class PaymentDataScreen extends StatefulWidget {
  const PaymentDataScreen({super.key});

  @override
  State<PaymentDataScreen> createState() => _PaymentDataScreenState();
}

class _PaymentDataScreenState extends State<PaymentDataScreen> {
  bool _showCreditCardForm = false;
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _validityController = TextEditingController();
  final _cvcController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _validityController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Dados de Pagamento'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCreditCardSection(),
            const SizedBox(height: 16.0),
            _buildPixSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardSection() {
    return Card(
      child: ExpansionTile(
        title: const Text('Cartão de Crédito'),
        initiallyExpanded: _showCreditCardForm,
        onExpansionChanged: (expanded) {
          setState(() {
            _showCreditCardForm = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cardNumberController,
                    decoration:
                        const InputDecoration(labelText: 'Número do Cartão'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o número do cartão';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _validityController,
                    decoration:
                        const InputDecoration(labelText: 'Validade (MM/AA)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a validade do cartão';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cvcController,
                    decoration: const InputDecoration(labelText: 'CVC'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o CVC do cartão';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Navega para a tela de Resumo do Pedido
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderSummaryScreen(
                              paymentMethod: 'Cartão de Crédito',
                              cardNumber: _cardNumberController.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Ir para o Resumo do Pedido'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPixSection() {
    return Card(
      child: ExpansionTile(
        title: const Text('Pix'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderSummaryScreen(
                      paymentMethod: 'Pix',
                    ),
                  ),
                );
              },
              child: const Text('Ir para o Resumo do Pedido'),
            ),
          ),
        ],
      ),
    );
  }
}
