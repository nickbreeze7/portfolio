import  { StyleSheet } from 'react-native';

export const styles = StyleSheet.create({
    item: {
        fontSize: 12,
        color: '#rgba(0,0,0,0.5)',
        marginRight: 17,
        paddingVertical: 2,

    },
    selectedItem: {
        color: '#000000'
    },
    itemContainer: {
        marginVertical: 14,
    },
    selectedItemContainer: {
        borderBottomColor: '#4681A3',
        borderBottomWidth: 1,
    }
});

export default styles;
